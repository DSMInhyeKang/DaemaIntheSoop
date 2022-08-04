//
//  NewUserVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/16.
//

import UIKit
import Alamofire

class NewUserVC: UIViewController {
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldUsername: UITextField!
    @IBOutlet weak var txtFieldPW: UITextField!
    @IBOutlet weak var lbUserState: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCheckUser(_ sender: Any) {
        
        let txtFieldUsername = self.txtFieldUsername.text

        
        let url = "http://52.5.10.3:8080/register"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .post
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = [
            "username": "\(txtFieldUsername!)"
        ] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).response { (response) in
            switch response.result {
            case .success:
                self.lbUserState.text = "사용 가능한 아이디입니다."
            case .failure(_):
                self.lbUserState.text = "이미 존재하는 사용자입니다."
            }
        }
    }
    
    
    @IBAction func btnNewUser(_ sender: Any) {
        let url = "http://52.5.10.3:8080/register"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // POST 로 보낼 정보
        let params: Parameters = [
            "username": txtFieldUsername.text!,
            "name": txtFieldName.text!,
            "password": txtFieldPW.text!
        ]

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        
        
        AF.request(request).response { (response) in
            print(response.request ?? "")
            switch response.result {
            case .success:
                debugPrint(response)
                
                let successOnAlert = UIAlertController(title: "안내", message: "회원가입 성공!", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "로그인 페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "이미 존재하는 사용자입니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "로그인 페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    
}
