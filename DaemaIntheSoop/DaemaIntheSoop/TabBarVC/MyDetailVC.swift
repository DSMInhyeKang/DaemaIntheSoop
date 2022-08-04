//
//  MyDetailVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/08/04.
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbMyPostTitle.text = "\(myPostTitle)"
        txtViewMyPostContent.text = "\(myPostContent)"
    }
    

    @IBAction func reviseBtn(_ sender: UIButton) {
        guard let view = self.storyboard?.instantiateViewController(withIdentifier: "ReviseVC") as? ReviseVC else { return }
        view.reviseTitle = "\(lbMyPostTitle.text!)"
        view.reviseContent = "\(txtViewMyPostContent.text!)"
        view.id = self.myID
        navigationController?.pushViewController(view, animated: true)
    }

}
