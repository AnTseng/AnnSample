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
    
    lazy var rotateItem: UIView = {
        return UIView()
    }()
    
    private var startTime: Date?

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
        gestureLabel.text = "Please tap, double tap, hold or shake."
        gestureLabel.isUserInteractionEnabled = true
        gestureLabel.textColor = .darkGray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureLabel(_:)))
        gestureLabel.addGestureRecognizer(tapGestureRecognizer)
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapGestureLabel(_:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        gestureLabel.addGestureRecognizer(doubleTapGestureRecognizer)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressLable(_:)))
        gestureLabel.addGestureRecognizer(longPressGestureRecognizer)
        
        view.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textColor = .lightGray
        
        view.addSubview(rotateItem)
        rotateItem.translatesAutoresizingMaskIntoConstraints = false
        rotateItem.backgroundColor = .lightGray
        
        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotationAction(_:)))
        rotateItem.addGestureRecognizer(rotateGestureRecognizer)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(_:)))
        rotateItem.addGestureRecognizer(pinchGestureRecognizer)
        
        let rotateLabel = UILabel()
        rotateItem.addSubview(rotateLabel)
        rotateLabel.translatesAutoresizingMaskIntoConstraints = false
        rotateLabel.text = "rotate or pinch item"
        rotateLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            gestureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gestureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            resultLabel.topAnchor.constraint(equalTo: gestureLabel.bottomAnchor, constant: 80),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rotateItem.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            rotateItem.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rotateItem.heightAnchor.constraint(equalToConstant: 80),
            rotateItem.widthAnchor.constraint(equalToConstant: 180),
            
            rotateLabel.centerXAnchor.constraint(equalTo: rotateItem.centerXAnchor),
            rotateLabel.centerYAnchor.constraint(equalTo: rotateItem.centerYAnchor)
        ])
        
    }
    
    @objc private func tapGestureLabel(_ gesture: UITapGestureRecognizer) {
        resultLabel.text = "tap"
    }
    
    @objc private func doubleTapGestureLabel(_ gesture: UITapGestureRecognizer) {
        resultLabel.text = "double tap"
    }
    
    @objc private func longPressLable(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            startTime = Date()
            
        } else if gesture.state == .ended, let startTime = startTime {
            
            let duaration = Date().timeIntervalSince(startTime)
            resultLabel.text = "hold \(duaration) seconds"
            self.startTime = nil
        } 
    }
    
    @objc private func rotationAction(_ sender: UIRotationGestureRecognizer) {
        let radian = sender.rotation
        rotateItem.transform = CGAffineTransform(rotationAngle: radian)
    }
    
    @objc private func pinchAction(_ sender: UIPinchGestureRecognizer) {
        rotateItem.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }

}
