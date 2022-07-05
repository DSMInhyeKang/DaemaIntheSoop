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
    
    
    @IBAction func btnSendPost(_ sender: Any) {
        let txtFieldNewTitle = self.txtFieldNewTitle.text
        let txtViewNewContent = self.txtViewNewContent.text
        
        //전송할 값
        let url = "http://35.216.6.254:8080/board"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = ["title": "\(txtFieldNewTitle!)",
                      "content": "\(txtViewNewContent!)"] as Dictionary
        
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
                let successOnAlert = UIAlertController(title: "안내", message: "게시글 등록 성공", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "게시글 작성 페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
        
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "게시글 등록 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "게시글 작성 페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
            }
        }
    }
}
