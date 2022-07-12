//
//  ReviseVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/07/12.
//

import UIKit
import Alamofire

class ReviseVC: UIViewController {
    @IBOutlet weak var lbReviseTitle: UILabel!
    @IBOutlet weak var lbReviseUser: UILabel!
    @IBOutlet weak var txtViewReviseContent: UITextView!
    
    var reviseTitle: String = ""
    var reviseUser: String = ""
    var reviseContent: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbReviseTitle.text = "\(reviseTitle)"
        lbReviseUser.text = "\(reviseUser)"
        txtViewReviseContent.text = "\(reviseContent)"
    }
    
    @IBAction func reviseBtn(_ sender: UIButton) {
        let lbReviseTitle = self.lbReviseTitle.text
        let txtViewReviseContent = self.txtViewReviseContent.text
        
        
        //전송할 값
        let url = "http://35.216.6.254:8080/board"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .patch
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        // POST 로 보낼 정보
        let params = ["title" : lbReviseTitle!,
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
        
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "게시글 수정 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "상세보기 화면으로", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
            }
        }
    }
    
}
