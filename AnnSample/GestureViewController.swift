//
//  GestureViewController.swift
//  AnnSample
//
//  Created by Ann on 2020/9/20.
//  Copyright © 2020 Ann. All rights reserved.
//

import UIKit

class GestureViewController: UIViewController {
    
    lazy var gestureLabel: UILabel = {
        return UILabel()
    }()
    
    lazy var resultLabel: UILabel = {
        return UILabel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            resultLabel.text = "shake"
        }
    }
    
    private func setUI() {
        view.addSubview(gestureLabel)
        gestureLabel.translatesAutoresizingMaskIntoConstraints = false
        gestureLabel.text = "Please tap or double tap."
        gestureLabel.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureLabel(_:)))
        gestureLabel.addGestureRecognizer(tapGestureRecognizer)
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapGestureLabel(_:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        gestureLabel.addGestureRecognizer(doubleTapGestureRecognizer)
        
        view.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gestureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gestureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            resultLabel.topAnchor.constraint(equalTo: gestureLabel.bottomAnchor, constant: 80),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    @objc private func tapGestureLabel(_ gesture: UITapGestureRecognizer) {
        resultLabel.text = "tap"
    }
    
    @objc private func doubleTapGestureLabel(_ gesture: UITapGestureRecognizer) {
        resultLabel.text = "double tap"
    }

}
