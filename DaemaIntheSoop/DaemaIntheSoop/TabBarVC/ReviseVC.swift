//
//  ReviseVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/07/12.
//

import UIKit

class ReviseVC: UIViewController {
    @IBOutlet weak var lbReviseTitle: UILabel!
    @IBOutlet weak var lbReviseUser: UILabel!
    @IBOutlet weak var txtViewReviseContent: UITextView!
    
    var reviseTitle: String = ""
    var reviseUser: String = ""
    var reviseContent: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbReviseTitle.text = "\(reviseTitle)"
        lbReviseUser.text = "\(reviseUser)"
        txtViewReviseContent.text = "\(reviseContent)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
