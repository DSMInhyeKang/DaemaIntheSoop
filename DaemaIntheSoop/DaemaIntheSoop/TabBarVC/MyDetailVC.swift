//
//  MyDetailVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/07/24.
//

import UIKit

class MyDetailVC: UIViewController {
    @IBOutlet weak var lbMyPostTitle: UILabel!
    @IBOutlet weak var txtViewMyPostContent: UITextView!
    
    
    var myPostTitle: String = ""
    var myPostContent: String = ""
    var myID: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMyPostTitle.text = "\(myPostTitle)"
        txtViewMyPostContent.text = "\(myPostContent)"
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
