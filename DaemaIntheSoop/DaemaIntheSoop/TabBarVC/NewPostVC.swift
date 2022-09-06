//
//  NewPostVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/16.
//

import UIKit
import Alamofire

class NewPostVC: UIViewController {
    @IBOutlet weak var txtFieldNewTitle: UITextField!
    @IBOutlet weak var txtViewNewContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtFieldNewTitle.layer.cornerRadius = 5
        txtFieldNewTitle.layer.borderWidth = 1.0
        txtFieldNewTitle.layer.borderColor = UIColor(named: "ThemeColor")?.cgColor
        txtViewNewContent.layer.cornerRadius = 10
        txtViewNewContent.layer.borderWidth = 1.0
        txtViewNewContent.layer.borderColor = UIColor(named: "ThemeColor")?.cgColor
        txtViewNewContent.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    
    
    @IBAction func btnSendPost(_ sender: Any) {
        let txtFieldNewTitle = self.txtFieldNewTitle.text
        let txtViewNewContent = self.txtViewNewContent.text
        
        
        //전송할 값
        let url = "http://52.5.10.3:8080/board"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .post
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        // POST 로 보낼 정보
        let params = ["title" : txtFieldNewTitle!,
                      "content" : txtViewNewContent!] as Dictionary
        
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
                let successOnAlert = UIAlertController(title: "안내", message: "게시글 등록 성공", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "게시글 작성 페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
                self.txtFieldNewTitle.text = nil
                self.txtViewNewContent.text = nil
                
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "게시글 등록 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "게시글 작성 페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
                
                self.txtFieldNewTitle.text = nil
                self.txtViewNewContent.text = nil
            }
        }
    }
}
