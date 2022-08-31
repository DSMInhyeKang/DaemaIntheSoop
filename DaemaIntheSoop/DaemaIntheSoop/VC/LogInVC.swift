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
        signIn()
    }
    
    @IBOutlet weak var passwordEyeBtn: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    
    var autoState: Bool = true
    
    var userID: String = ""
    var userPW: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtFieldPW.isSecureTextEntry = true
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = button.frame.width/2
        button.clipsToBounds = true
        manualSignIn()
    }
    
    
    @IBAction func passwordEyeBtnDidTap(_ sender: Any) {
        // 보안 설정 반전
        txtFieldPW.isSecureTextEntry.toggle()
        // 버튼 선택 상태 반전
        passwordEyeBtn.isSelected.toggle()
        // 버튼 선택 상태에 따른 눈 모양 이미지 변경
        let eyeImage = passwordEyeBtn.isSelected ? "password shown eye icon" : "password hidden eye icon"
        passwordEyeBtn.setImage(UIImage(named: eyeImage), for: .normal)
        // 버튼 선택된 경우 자동으로 들어가는 틴트 컬러를 투명으로 변경해줌
        passwordEyeBtn.tintColor = .clear
    }
    
    
    @IBAction func btnAutoSignIn(_ sender: UIButton) {
        if(autoState == false) {
            autoSignIn()
        }
        
        else if (autoState == true) {
            manualSignIn()
        }
    }
    
    
    func autoSignIn() {
        checkBox.titleLabel?.textColor = UIColor(named: "ThemeColor")
        let state = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
        let successImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: state)
        checkBox.setImage(successImage, for: .normal)
        
        autoState = true
        
        userID = self.txtFieldID.text!
        userPW = self.txtFieldPW.text!
        
        UserDefaults.standard.set(self.userID, forKey: "id")
        UserDefaults.standard.set(self.userPW, forKey: "pw")
        
    }
    
    func manualSignIn() {
        checkBox.titleLabel?.textColor = UIColor(named: "ThemeColor")
        let state = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
        let successImage = UIImage(systemName: "square", withConfiguration: state)
        checkBox.setImage(successImage, for: .normal)
        
        autoState = false
    }
    
    
    
    private func signIn() {
        let url = "http://52.5.10.3:8080/login"
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
