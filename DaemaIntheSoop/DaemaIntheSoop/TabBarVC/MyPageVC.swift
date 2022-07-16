//
//  MyPageVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/16.
//

import UIKit

class MyPageVC: UIViewController {
    @IBOutlet weak var myPostsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        guard let signOut = self.storyboard?.instantiateViewController(identifier: "LogInVC") as? LogInVC else { return }
        
        signOut.modalPresentationStyle = .fullScreen
        self.present(signOut, animated: true, completion: nil)
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
