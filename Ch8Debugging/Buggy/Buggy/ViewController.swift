//
//  ViewController.swift
//  Buggy
//
//  Created by Sravya Kaki on 11/17/20.
//  Copyright © 2020 Sravya Kaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // Using Literal expressions for Debugging
        print("Method: \(#function) in file: \(#file) line: \(#line) called.")
        badMethod()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func badMethod() {
        let array = NSMutableArray()

        for i in 0..<10 {
            array.insert(i, at: i)
        }
        
        for _ in 0..<10 {
            array.removeObject(at: 0)
        }
    }


}

