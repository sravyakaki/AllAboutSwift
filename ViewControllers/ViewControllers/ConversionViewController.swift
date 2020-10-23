// 
//  Copyright © 2020 Big Nerd Ranch
//

import UIKit

class ConversionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
         view.backgroundColor = randomBGColor()
     }
     
     func randomBGColor() -> UIColor {
         return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0
         )
     }
}

