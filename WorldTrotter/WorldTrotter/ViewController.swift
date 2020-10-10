//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Sravya Kaki on 10/5/20.
//  Copyright © 2020 Sravya Kaki. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientBackground()
    }
    
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.red.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
    }



}

