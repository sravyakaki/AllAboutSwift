// 
//  Copyright © 2020 Big Nerd Ranch
//

import UIKit

class ConversionViewController: UIViewController {
    
    var farhtDegreeLabel: UILabel!
    var fUnitMeasureLabel: UILabel!
    var conversionText: UILabel!
    var CDegreeLabel: UILabel!
    var CUnitMeasureLabel: UILabel!
   
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        farhtDegreeLabel = UILabel()
        farhtDegreeLabel.translatesAutoresizingMaskIntoConstraints = false
        farhtDegreeLabel.text = "212"
        farhtDegreeLabel.font = farhtDegreeLabel.font.withSize(70)
        farhtDegreeLabel.textColor = UIColor.init(red: 225.0/255, green: 88.0/255, blue: 41.0/255, alpha: 1.0)
        farhtDegreeLabel.textAlignment = .center
        view.addSubview(farhtDegreeLabel)
        
        let fDegreeLabelTopConstraint = farhtDegreeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let fLabelAlignmentConstraint = farhtDegreeLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
        
        fDegreeLabelTopConstraint.isActive = true
        fLabelAlignmentConstraint.isActive = true
        
        fUnitMeasureLabel = UILabel()
        fUnitMeasureLabel.translatesAutoresizingMaskIntoConstraints = false
        fUnitMeasureLabel.text = "degrees fahrenheit"
        fUnitMeasureLabel.font = fUnitMeasureLabel.font.withSize(36)
        fUnitMeasureLabel.textColor = UIColor.init(red: 225.0/255, green: 88.0/255, blue: 41.0/255, alpha: 1.0)
        fUnitMeasureLabel.textAlignment = .center
        view.addSubview(fUnitMeasureLabel)
        
        let fUnitTopConstraint = fUnitMeasureLabel.topAnchor.constraint(equalTo: farhtDegreeLabel.bottomAnchor, constant: 8)
        let fUnitCenterXConstraint = fUnitMeasureLabel.centerXAnchor.constraint(equalTo: farhtDegreeLabel.centerXAnchor)
        
        fUnitTopConstraint.isActive = true
        fUnitCenterXConstraint.isActive = true
        
        conversionText = UILabel()
        conversionText.font = conversionText.font.withSize(36)
        conversionText.textColor = UIColor.black
        conversionText.textAlignment = .center
        conversionText.text = "is really"
        conversionText.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(conversionText)
        
        let converTextTopConstraint = conversionText.topAnchor.constraint(equalTo: fUnitMeasureLabel.bottomAnchor, constant: 8)
        let converTextCenterConstraint = conversionText.centerXAnchor.constraint(equalTo: farhtDegreeLabel.centerXAnchor)
        
        converTextTopConstraint.isActive = true
        converTextCenterConstraint.isActive = true
        
        CDegreeLabel = UILabel()
        CDegreeLabel.text = "100"
        CDegreeLabel.font = CDegreeLabel.font.withSize(70)
        CDegreeLabel.textColor = UIColor.init(red: 225.0/255, green: 88.0/255, blue: 41.0/255, alpha: 1.0)
        CDegreeLabel.textAlignment = .center
        CDegreeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CDegreeLabel)
        
        let cDegTopConstr = CDegreeLabel.topAnchor.constraint(equalTo: conversionText.bottomAnchor, constant: 8)
        let cDegCenterConstr = CDegreeLabel.centerXAnchor.constraint(equalTo: farhtDegreeLabel.centerXAnchor)
        
        cDegTopConstr.isActive = true
        cDegCenterConstr.isActive = true
        
        
        
        CUnitMeasureLabel = UILabel()
        CUnitMeasureLabel.text = "degrees Celsius"
        CUnitMeasureLabel.font = CUnitMeasureLabel.font.withSize(36)
        CUnitMeasureLabel.textColor = UIColor.init(red: 225.0/255, green: 88.0/255, blue: 41.0/255, alpha: 1.0)
        CUnitMeasureLabel.textAlignment = .center
        CUnitMeasureLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CUnitMeasureLabel)
               
        let cUnitTopConstr = CUnitMeasureLabel.topAnchor.constraint(equalTo: CDegreeLabel.bottomAnchor, constant: 8)
        let cUnitCenterConstr = CUnitMeasureLabel.centerXAnchor.constraint(equalTo: CDegreeLabel.centerXAnchor)
               
        cUnitTopConstr.isActive = true
        cUnitCenterConstr.isActive = true
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("ConversionViewController loaded its view.")
    }
}
