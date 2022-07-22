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
        signin()
    }
    
    let autoSignIn: Bool = true
    
    let myUserDefaults = UserDefaults.standard
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = button.frame.width/2
        button.clipsToBounds = true
        
//        autoSignIn.true = myUserDefaults.bool(forKey: <#T##String#>)
    }
    
    private func signin() {
        let url = "http://35.216.6.254:8080/login"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // POST 로 보낼 정보
        let params: Parameters = [
            "username": "\(txtFieldID.text!)",
            "password": "\(txtFieldPW.text!)"
        ]

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        
        AF.request(request).response { (response) in
            switch response.result {
            case .success:
                debugPrint(response)
                
                if let data = try? JSONDecoder().decode(TokenModel.self, from: response.data!) {
                    KeyChain.create(key: "accessToken", token: data.accessToken)
                    KeyChain.create(key: "refreshToken", token: data.refreshToken)
                }
                
                guard let logInVC = self.storyboard?.instantiateViewController(identifier: "TabBarVC") as? TabBarVC else { return }
                
                logInVC.modalPresentationStyle = .fullScreen
                self.present(logInVC, animated: true, completion: nil)
                
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "로그인 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "아이디와 패스워드를 다시 확인해주세요.", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
            }
        }
    }
}


