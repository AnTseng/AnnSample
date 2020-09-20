//
//  KeychainManager.swift
//  AnnSample
//
//  Created by Ann on 2020/9/20.
//  Copyright © 2020 Ann. All rights reserved.
//

import Foundation
/*
 Keychain是iOS所提供的一個安全儲存參數的方式，最常用來當作儲存帳號、密碼、信用卡資料等需要保密的資訊，Keychain會以加密的方式將這些資訊儲存於裝置當中。
 
 由於Keychain的資料並不是儲存在App的Sandbox中，所以即使將App從裝置中刪除了，這些資料還是存在於裝置中，當使用者重新安裝了相同儲存ㄕㄨ的App後，這些資訊還是可以被取得。

 另一個特色是，Keychain的資料可以透過Group Access的方式，讓資料可以在App間共享，Google系列的App (Gmail、Google+、日曆…)就是透過這樣的方式來紀錄使用者登入資訊，只要使用者在其中一個App中完成登入了，其他的App也可以讀取到同相的登入資訊進行登入。
 參考 Swift之密码管理(Keychain)的介绍和使用: https://www.jianshu.com/p/31e5654166db
 參考 iOS的密码管理系统 Keychain的介绍和使用: https://blog.csdn.net/zhoushuangjian511/article/details/78583429
 參考 App Security：實作 App 的安全防護 小心保護使用者資料: https://www.appcoda.com.tw/app-security/
 參考 Storing Keys in the Keychain: https://developer.apple.com/documentation/security/certificate_key_and_trust_services/keys/storing_keys_in_the_keychain
 參考 iOS筆記: 使用Keychain在App間共享資料: https://8085studio.wordpress.com/2015/08/29/ios%E7%AD%86%E8%A8%98-%E4%BD%BF%E7%94%A8keychain%E5%9C%A8app%E9%96%93%E5%85%B1%E4%BA%AB%E8%B3%87%E6%96%99/
 參考 数据存储之归档解档 NSKeyedArchiver NSKeyedUnarchiver: https://github.com/pro648/tips/wiki/%E6%95%B0%E6%8D%AE%E5%AD%98%E5%82%A8%E4%B9%8B%E5%BD%92%E6%A1%A3%E8%A7%A3%E6%A1%A3-NSKeyedArchiver-NSKeyedUnarchiver
 參考 iOS12 unarchiveObject(with:) was deprecated に対応する: https://qiita.com/rcftdbeu/items/2de95d1bc8f520f590ef
 */

class KeychainManager: NSObject {
    
    // 創建查詢條件
    class func createQuaryMutableDictionary(identifier: String) -> NSMutableDictionary {
        // 創建一個條件字典
        let keychainQuaryMutableDictionary = NSMutableDictionary.init(capacity: 0)
        // 設置條件儲存的類型
        keychainQuaryMutableDictionary.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        // 設置儲存數據的標記
        keychainQuaryMutableDictionary.setValue(identifier, forKey: kSecAttrService as String)
        keychainQuaryMutableDictionary.setValue(identifier, forKey: kSecAttrAccount as String)
        // 設置數據訪問屬性
        keychainQuaryMutableDictionary.setValue(kSecAttrAccessibleAfterFirstUnlock, forKey: kSecAttrAccessible as String)
        
        return keychainQuaryMutableDictionary
    }
    
    /// 儲存數據
    class func keychainSaveData(data: Any, withIdentifier identifier: String) -> Bool {
        // 獲取儲存數據的條件
        let keychainSaveMutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        // 刪除舊的儲存數據
        SecItemDelete(keychainSaveMutableDictionary)
        
        do {
            // 設置數據
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
            keychainSaveMutableDictionary.setValue(archivedData, forKey: kSecValueData as String)
            // 進行儲存數據
            let saveState = SecItemAdd(keychainSaveMutableDictionary, nil)
            if saveState == noErr {
                return true
            }
            return false
        } catch {
            print("error: \(error.localizedDescription)")
        }
        return false
    }
    
    /// 更新數據
    class func keychainUpdate(data: Any, withIdentifier identifier: String) -> Bool {
        // 獲取更新的條件
        let keychainUpdateMutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        // 創建數據儲存字典
        let updateMutableDictionary = NSMutableDictionary.init(capacity: 0)
        
        do {
            // 設置數據
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
            updateMutableDictionary.setValue(archivedData, forKey: kSecValueData as String)
            // 更新數據
            let updateState = SecItemUpdate(keychainUpdateMutableDictionary, updateMutableDictionary)
            if updateState == noErr {
                return true
            }
            return false
        } catch {
            print("error: \(error.localizedDescription)")
        }
        return false
    }
    
    /// 獲取數據
    class func keychainReadData(identifier: String) -> Any {
        var idObject: Any?
        // 獲取查詢條件
        let keychainReadMutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        // 提供查詢數據的兩個必要參數
        keychainReadMutableDictionary.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        keychainReadMutableDictionary.setValue(kSecMatchLimitOne, forKey: kSecMatchLimit as String)
        // 創建獲取數據的引用
        var queryResult: AnyObject?
        // 通過查詢是否存在數據
        let readState = withUnsafeMutablePointer(to: &queryResult) { SecItemCopyMatching(keychainReadMutableDictionary, UnsafeMutablePointer($0))
        }
        if readState == errSecSuccess {
            if let data = queryResult as! NSData? {
                do {
                    idObject = try NSKeyedUnarchiver.unarchivedObject(ofClasses: <#T##[AnyClass]#>, from: <#T##Data#>)
                    idObject = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as Any
                } catch {
                    print("error: \(error.localizedDescription)")
                }
            }
        }
        return idObject as Any
    }
    
}
