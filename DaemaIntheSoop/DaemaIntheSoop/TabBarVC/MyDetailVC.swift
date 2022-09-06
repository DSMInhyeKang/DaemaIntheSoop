//
//  MyDetailVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/08/04.
//

import UIKit
import Alamofire

class MyDetailVC: UIViewController {
    @IBOutlet weak var lbMyPostTitle: UILabel!
    @IBOutlet weak var txtViewMyPostContent: UITextView!
    @IBOutlet weak var txtFieldComment: UITextField!
    @IBOutlet weak var commentTableView: UITableView!
    
    var model = CommentModel()
    let refreshControl = UIRefreshControl()
    
    var myPostTitle: String = ""
    var myPostContent: String = ""
    var myID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        commentTableView.delegate = self
        commentTableView.dataSource = self
    
        commentTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 30)
        
        getComments()
        
        lbMyPostTitle.text = "\(myPostTitle)"
        txtViewMyPostContent.text = "\(myPostContent)"
    }
    

    @IBAction func reviseBtn(_ sender: UIButton) {
        guard let view = self.storyboard?.instantiateViewController(withIdentifier: "ReviseVC") as? ReviseVC else { return }
        view.reviseTitle = "\(lbMyPostTitle.text!)"
        view.reviseContent = "\(txtViewMyPostContent.text!)"
        view.id = self.myID
        navigationController?.pushViewController(view, animated: true)
    }
    
    
    @objc func pullToRefresh(_ sender: Any) {
        getComments()
        
        refreshControl.endRefreshing()
    }

    
    private func getComments() {
        let url = "http://52.5.10.3:8080/board/\(myID)/comment"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.timeoutInterval = 10
        
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        AF.request(request).response { (response) in switch response.result {
                case .success:
                    debugPrint(response)
            
                    if let data = try? JSONDecoder().decode(CommentModel.self, from: response.data!){
                        DispatchQueue.main.async {
                            self.model = data
                            self.commentTableView.reloadData()
                            
                            self.commentTableView.refreshControl = UIRefreshControl()
                            self.commentTableView.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                            self.refreshControl.endRefreshing()
                        }
                    }
            
            
                case .failure(let error):
                    print(error)
                    self.commentTableView.refreshControl = UIRefreshControl()
                    self.commentTableView.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                    self.refreshControl.endRefreshing()
            }
        }
    }
    
    @IBAction func btnSendComment(_ sender: UIButton) {
        let txtFieldComment = self.txtFieldComment.text
        
        let url = "http://52.5.10.3:8080/board/\(myID)/comment"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .post
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        let params = ["comment" : txtFieldComment!] as Dictionary
        
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
//                let successOnAlert = UIAlertController(title: "안내", message: "등록 성공", preferredStyle: UIAlertController.Style.alert)
//                let onAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default, handler: nil)
//                successOnAlert.addAction(onAction)
//                self.present(successOnAlert, animated: true, completion: nil)
                
                self.txtFieldComment.text = nil
               
                self.getComments()
                
                
            case .failure(let error):
                print(error)
                
                let successOnAlert = UIAlertController(title: "안내", message: "등록 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default, handler: nil)
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
                self.txtFieldComment.text = nil
               
                self.getComments()
            }
            
        }
    }
}


extension MyDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCommentCell", for: indexPath) as! MyCommentCell
        cell.lbMyUser.text = "\(model.content[indexPath.row].username)"
        cell.lbMyComment.text = "\(model.content[indexPath.row].comment)"
        
        print(cell.lbMyUser.text!)
        print(cell.lbMyComment.text!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let view = self.storyboard?.instantiateViewController(withIdentifier: "MyCommentVC") as? MyCommentVC else { return }

        view.myCommentID = self.model.content[indexPath.row].commentId
        view.myComment = "\(self.model.content[indexPath.row].comment)"

        print(self.model.content[indexPath.row].commentId)
        print(self.model.content[indexPath.row].comment)

        navigationController?.pushViewController(view, animated: true)
    }
}
