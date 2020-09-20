// 1.
//class Dog {
//    var name: String
//    init(name: String) {
//        self.name = name
//    }
//}
//
//class Bone {
//    var owner: Dog
//    init(owner: Dog) {
//        self.owner = owner
//        print("bone is initialized")
//    }
//    deinit {
//        print("bone is deinitialized")
//    }
//}
//
//var lucky: Dog? = Dog(name: "Lucky")
//// print : Lucky is initialized
//var bone : Bone = Bone(owner: lucky!)
//// print : bone is initialized
//lucky = nil
////什麼事都沒有發生
//
//print(lucky?.name)
////print: nil
//print(bone.owner.name)
////print: Lucky


// 2.
//class DogV2 {
//    var name: String
//    var bone: BoneV2?
//    init(name: String) {
//        self.name = name
//        print("\(name) is initialized")
//    }
//    // 當物件死亡時會執行 deinit 方法裡的動作
//    deinit {
//        print("\(name) is deinitialized")
//    }
//}
//
//class BoneV2 {
//    var owner: DogV2?
//    init() {
//        print("boneV2 is initialized")
//    }
//    deinit {
//        print("boneV2 is deinitialized")
//    }
//}
//
//var boneV2: BoneV2? = BoneV2()
//var coco: DogV2? = DogV2(name: "Coco")
//boneV2?.owner = coco
//coco?.bone = boneV2
//
//coco = nil
////boneV2 = nil
//
//print(coco?.name)
////print: nil
//print(boneV2?.owner?.name)
////print: Lucky


// 3.
//class Dog{
//    var name : String
//    init(name : String) {
//        self.name = name
//        print("\(name) is initialized")
//    }
//    deinit {
//        print("\(name) is deinitialized")
//    }
//}
//
//class Bone{
//    weak var owner : Dog?
//    init(owner : Dog?) {
//        self.owner = owner
//        print("bone is initialized")
//    }
//    deinit {
//        print("bone is deinitialized")
//    }
//}
//
//var lucky : Dog? = Dog(name: "Lucky")
//var bone : Bone? = Bone(owner: lucky)
//
//lucky = nil
////print : Lucky is deinitialized
//print(bone?.owner?.name)



// 4.
//class Dog{
//    var name : String
//    var bone : Bone?
//
//    init(name : String) {
//        self.name = name
//        self.bone = Bone(owner: self)
//        print("\(name) is initialized")
//    }
//    deinit {
//        print("\(name) is deinitialized")
//    }
//}
//
//class Bone{
//    unowned let owner : Dog
//    init(owner : Dog) {
//        self.owner = owner
//        print("bone is initialized")
//    }
//    deinit {
//        print("bone is deinitialized")
//    }
//}
//
//var lucky : Dog? = Dog(name: "Lucky")
//// bone is initialized
//// Lucky is initialized
//
////lucky?.bone = nil
//////bone is deinitialized
//
//lucky = nil
//// Lucky is deinitialized
//// bone is deinitialized

// 5.
//var i1 = 1
//var i2 = 1
//
//var fStrong = {
//    i1 += 1
//    i2 += 2
//}
//
//fStrong()
//print(i1,i2) //Prints 2 and 3

// 6.
var i1 = 1, i2 = 1

var fStrong = {
    i1 += 1
    i2 += 2
}

var fCopy = { [i1] in
    print(i1,i2)
}

fStrong()
print(i1,i2) //打印结果是 2 和 3

fCopy()  //打印结果是 1 和 3

print(i1,i2)

// 7.
class AClass{
    var value = 1
}

var c1 = AClass()
var c2: AClass? = AClass()

var fSpec = { [unowned c1, weak c2] in
    c1.value += 1
    //c2?.value += 1
    if let c2 = c2 {
        c2.value += 1
    }
}

var fTest = { [c2] in
    c2?.value += 2
    print(c2)
}

//fSpec()
fTest()
print(c2)
c2 = nil
print(c1.value, c2) //Prints 2 and 2



