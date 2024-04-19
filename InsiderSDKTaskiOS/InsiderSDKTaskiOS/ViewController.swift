//
//  ViewController.swift
//  InsiderSDKTaskiOS
//
//  Created by Uslu, Teyhan on 18.04.2024.
//

import UIKit
import InsiderSDKTaskFramework

class ViewController: UIViewController {
    @IBOutlet weak var skyView: SkyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func smallStarButtonTapped(_ sender: Any) {
        skyView.addStarInterface(type: .S)
    }
    
    @IBAction func bigStarButtonTapped(_ sender: Any) {
        skyView.addStarInterface(type: .B)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        skyView.addStarInterface(type: nil)
    }
}
