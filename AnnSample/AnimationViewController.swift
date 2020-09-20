//
//  AnimationViewController.swift
//  AnnSample
//
//  Created by Ann on 2020/9/20.
//  Copyright © 2020 Ann. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    lazy var moveButton: UIButton = {
        return UIButton()
    }()
    
    lazy var cGAffineTransformButton: UIButton = {
        return UIButton()
    }()
    
    lazy var animationView: UIView = {
        return UIView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
    }
    
    private func setUI() {
        view.addSubview(moveButton)
        moveButton.translatesAutoresizingMaskIntoConstraints = false
        moveButton.setTitle("移動動畫", for: .normal)
        moveButton.setTitleColor(.black, for: .normal)
        moveButton.addTarget(self, action: #selector(moveAnimation), for: .touchUpInside)
        
        view.addSubview(cGAffineTransformButton)
        cGAffineTransformButton.translatesAutoresizingMaskIntoConstraints = false
        cGAffineTransformButton.setTitle("CGAffineTransformButton", for: .normal)
        cGAffineTransformButton.setTitleColor(.black, for: .normal)
        cGAffineTransformButton.addTarget(self, action: #selector(cGAffineTransform), for: .touchUpInside)
        
        view.addSubview(animationView)
        animationView.backgroundColor = .green
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            moveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cGAffineTransformButton.topAnchor.constraint(equalTo: moveButton.bottomAnchor, constant: 50),
            cGAffineTransformButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 50),
            animationView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc private func moveAnimation() {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.animationView.frame = self.animationView.frame.offsetBy(dx: 100, dy: 0)
        }
        animator.startAnimation()
    }
    
    @objc private func cGAffineTransform() {
        animationView.transform = CGAffineTransform(scaleX: 2, y: 2)
    }
}
