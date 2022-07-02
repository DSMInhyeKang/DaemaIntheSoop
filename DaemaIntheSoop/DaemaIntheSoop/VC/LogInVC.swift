//
//  LogInVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/16.
//

import UIKit
import Alamofire

class LogInVC: UIViewController {
    @IBOutlet weak var txtFieldID: UITextField!
    @IBOutlet weak var txtFieldPW: UITextField!
    @IBAction func btnLogIn(_ sender: Any) {
        guard let logInVC = self.storyboard?.instantiateViewController(identifier: "TabBarVC") as? TabBarVC else { return }
        
        logInVC.modalPresentationStyle = .fullScreen
        
        self.present(logInVC, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
