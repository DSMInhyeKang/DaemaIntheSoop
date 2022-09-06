//
//  SearchCommentVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/09/06.
//

import UIKit
import Alamofire

class SearchCommentVC: UIViewController {
    @IBOutlet weak var txtViewComment: UITextView!
    
    var searchID: Int = 0
    var searchComment: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtViewComment.text = "\(searchComment ?? "")"
        
        txtViewComment.layer.cornerRadius = 10
        txtViewComment.layer.borderWidth = 1.0
        txtViewComment.layer.borderColor = UIColor(named: "ThemeColor")?.cgColor
        txtViewComment.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    @IBAction func btnResultRevise(_ sender: UIButton) {
        searchComment = self.txtViewComment.text

        let url = "http://52.5.10.3:8080/board/comment/\(searchID)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .patch
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
       
        let params = ["comment" : searchComment!] as Dictionary
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            
        } catch {
            print("http Body Error")
        }

        AF.request(request).response { (response) in
            print(response.request ?? "")
            switch response.response!.statusCode {
            case (200..<400):
                debugPrint(response)
                let successOnAlert = UIAlertController(title: "안내", message: "수정 완료", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default, handler: nil)
                
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
                self.txtViewComment.text = nil
        
                
            case (400..<600):
                debugPrint(response)
                let failOnAlert = UIAlertController(title: "안내", message: "게시글 수정 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
                
                self.txtViewComment.text = nil
                
            default:
                print("인증 토큰이 만료되었습니다")
            }
        }
    }
    
    
    @IBAction func btnResultDelete(_ sender: UIButton) {
        let url = "http://52.5.10.3:8080/board/comment/\(searchID)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .delete
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        AF.request(request).response { (response) in
            print(response.request ?? "")
            switch response.response?.statusCode {
            case 200:
                debugPrint(response)
                let successOnAlert = UIAlertController(title: "안내", message: "댓글 삭제 완료", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default, handler: nil)

                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
                
            case 403:
                print("error")
                let successOnAlert = UIAlertController(title: "안내", message: "삭제할 수 없습니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default, handler: nil)

                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
            
                
            default:
                debugPrint(response)
            }
        }

    }
    
}
