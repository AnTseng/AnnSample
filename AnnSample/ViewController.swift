//
//  ViewController.swift
//  AnnSample
//
//  Created by Ann on 2020/9/20.
//  Copyright © 2020 Ann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var gestureLabel: UILabel = {
        return UILabel()
    }()
    
    lazy var animationLabel: UILabel = {
        return UILabel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
    }
    
    private func setUI() {
        view.addSubview(gestureLabel)
        gestureLabel.translatesAutoresizingMaskIntoConstraints = false
        gestureLabel.text = "gesture"
        gestureLabel.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureLabel(_:)))
        gestureLabel.addGestureRecognizer(tapGestureRecognizer)
        
        view.addSubview(animationLabel)
        animationLabel.translatesAutoresizingMaskIntoConstraints = false
        animationLabel.text = "animation"
        animationLabel.isUserInteractionEnabled = true
        let tapAnimationGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapAnimationLabel(_:)))
        animationLabel.addGestureRecognizer(tapAnimationGestureRecognizer)
        
        NSLayoutConstraint.activate([
            gestureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gestureLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            animationLabel.topAnchor.constraint(equalTo: gestureLabel.bottomAnchor, constant: 50),
            animationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    @objc private func tapGestureLabel(_ gesture: UITapGestureRecognizer) {
        let gestureVC = GestureViewController()
        gestureVC.view.backgroundColor = .white
        navigationController?.pushViewController(gestureVC, animated: true)
    }
    
    @objc private func tapAnimationLabel(_ gesture: UITapGestureRecognizer) {
        let gestureVC = AnimationViewController()
        gestureVC.view.backgroundColor = .white
        navigationController?.pushViewController(gestureVC, animated: true)
    }
}

