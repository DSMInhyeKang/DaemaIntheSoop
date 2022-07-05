//
//  ViewController.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lbAppTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        for family in UIFont.familyNames {
//          print(family)
//
//          for sub in UIFont.fontNames(forFamilyName: family) {
//            print("====> \(sub)")
//          }
//        }
        
        lbAppTitle.text = "Daema; In the Soop"
        lbAppTitle.font = UIFont(name: "StretchProRegular", size: 55)
        
        
    }

}

