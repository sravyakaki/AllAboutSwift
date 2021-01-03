//
//  ViewController.swift
//  Mandala
//
//  Created by Sravya Kaki on 1/1/21.
//  Copyright © 2021 Sravya Kaki. All rights reserved.
//

import UIKit

class MoodSelectionViewController: UIViewController {
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var addMoodButton: UIButton!
    
    var moodsConfigurable: MoodsConfigurable!
    
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
            moodButtons = moods.map { mood in
                let moodButton = UIButton()
                moodButton.setImage(mood.image, for: .normal)
                moodButton.imageView?.contentMode = .scaleAspectFit
                moodButton.adjustsImageWhenHighlighted = false
                moodButton.addTarget(self, action: #selector(moodSelectionChanged(_:)), for: .touchUpInside)
                return moodButton
            }
        }
    }
    var moodButtons: [UIButton] = [] {
        didSet {
            oldValue.forEach {$0.removeFromSuperview() }
            moodButtons.forEach { stackView.addArrangedSubview($0)}
        }
    }
    
    @IBAction func addMoodTapped(_ sender: Any) {
        guard let currentMood = currentMood else {
            return
        }
        let newMoodEntry = MoodEntry(mood: currentMood, timestamp: Date())
        moodsConfigurable.add(newMoodEntry)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedContainerViewController":
            // The following code triggers the view controller that conforms to MoodsConfigurable protocol
            guard let moodsConfigurable = segue.destination as? MoodsConfigurable else {
                preconditionFailure(
                "View Controller expected to conform to MoodsConfigurable")
            }
            self.moodsConfigurable = moodsConfigurable
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
            
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
            
            addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)
            addMoodButton?.backgroundColor = currentMood.color
        }
    }
    
    @objc func moodSelectionChanged(_ sender: UIButton) {
        guard let selectedIndex = moodButtons.firstIndex(of: sender) else {
            preconditionFailure(
                "Unable to find the tapped button in the buttons array.")
        }
        currentMood = moods[selectedIndex]
    }
    
    


}

