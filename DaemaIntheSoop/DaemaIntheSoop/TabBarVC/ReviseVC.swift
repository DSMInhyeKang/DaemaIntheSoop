//
//  ReviseVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/07/12.
//

import UIKit
import Alamofire

class ReviseVC: UIViewController {
    
    @IBOutlet weak var txtFieldReviseTitle: UITextField!
    @IBOutlet weak var txtViewReviseContent: UITextView!
    
    var id: Int = 0
    var reviseTitle: String = ""
    var reviseContent: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldReviseTitle.text = "\(reviseTitle)"
        txtViewReviseContent.text = "\(reviseContent)"
    }
    
    
    @IBAction func reviseBtn(_ sender: UIButton) {
        let txtFieldReviseTitle = self.txtFieldReviseTitle.text
        let txtViewReviseContent = self.txtViewReviseContent.text
        
        
        //전송할 값
        let url = "http://52.5.10.3:8080/board/\(id)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .patch
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.timeoutInterval = 10
        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
       
        let params = ["title" : txtFieldReviseTitle!,
                      "content" : txtViewReviseContent!] as Dictionary
        
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
                let successOnAlert = UIAlertController(title: "안내", message: "게시글 수정 완료", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "홈 화면으로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
                self.txtFieldReviseTitle.text = nil
                self.txtViewReviseContent.text = nil
        
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "게시글 수정 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "상세보기 화면으로", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
                
                self.txtFieldReviseTitle.text = nil
                self.txtViewReviseContent.text = nil
            }
        }
    }
    
    
    @IBAction func btnMyPostDelete(_ sender: UIButton) {
        //전송할 값
        let url = "http://52.5.10.3:8080/board/\(id)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .delete
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.timeoutInterval = 10
        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        
        AF.request(request).response { (response) in
            print(response.request ?? "")
            switch response.result {
            case .success:
                debugPrint(response)
                let successOnAlert = UIAlertController(title: "안내", message: "게시글 삭제 완료", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "마이페이지로 돌아가기", style: UIAlertAction.Style.default, handler: nil)
                
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "게시글 삭제 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "상세보기 화면으로", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
            }
        }

    }
    
}
