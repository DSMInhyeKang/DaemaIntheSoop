//
//  DetailVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/08/04.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var lbPostTitle: UILabel!
    @IBOutlet weak var lbPostWriter: UILabel!
    @IBOutlet weak var txtViewContent: UITextView!
    
    var postTitle: String = ""
    var postWriter: String = ""
    var txt: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbPostTitle.text = "\(postTitle)"
        lbPostWriter.text = "\(postWriter)"
        txtViewContent.text = "\(txt)"
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
