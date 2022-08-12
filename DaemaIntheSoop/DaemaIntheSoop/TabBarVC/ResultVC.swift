//
//  ResultVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/08/12.
//

import UIKit
import Alamofire

class ResultVC: UIViewController {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var txtViewContent: UITextView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var tableViewComment: UITableView!
    
    
    let refreshControl = UIRefreshControl()
    var model = CommentModel()
    var result = Content()
    
    var postTitle: String = ""
    var postWriter: String = ""
    var txt: String = ""
    var postID: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("thisiswhatIprint")
        print(postID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        tableViewComment.delegate = self
        tableViewComment.dataSource = self
    
        tableViewComment.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 30)
        
        getPost()
        getComments()
    }
    
    
    @objc func pullToRefresh(_ sender: Any) {
        getComments()
        
        refreshControl.endRefreshing()
    }

    
    private func getPost() {
        let url = "http://52.5.10.3:8080/board/\(postID)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        AF.request(request).response { (response) in switch response.result {
                case .success:
                    debugPrint(response)
            
                    if let data = try? JSONDecoder().decode(Content.self, from: response.data!){
                        DispatchQueue.main.async {
                            self.result = data
                            
                            self.lbTitle.text = "\(self.result.title)"
                            self.lbUser.text = "\(self.result.username)"
                            self.txtViewContent.text = "\(self.result.content)"
                        }
                    }
            
            
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func getComments() {
        let url = "http://52.5.10.3:8080/board/\(postID)/comment"
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
                            self.tableViewComment.reloadData()
                            
                            self.tableViewComment.refreshControl = UIRefreshControl()
                            self.tableViewComment.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                            self.refreshControl.endRefreshing()
                        }
                    }
            
            
                case .failure(let error):
                    print(error)
                    self.tableViewComment.refreshControl = UIRefreshControl()
                    self.tableViewComment.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                    self.refreshControl.endRefreshing()
            }
        }
    }
    
    
    @IBAction func sendBtn(_ sender: UIButton) {
        let txtFieldComment = self.commentTextField.text
        
        let url = "http://52.5.10.3:8080/board/\(postID)/comment"
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
                
                self.commentTextField.text = nil
               
                self.getComments()
                
                
            case .failure(let error):
                print(error)
                
                let successOnAlert = UIAlertController(title: "안내", message: "등록 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default, handler: nil)
                successOnAlert.addAction(onAction)
                self.present(successOnAlert, animated: true, completion: nil)
                
                self.commentTextField.text = nil
               
                self.getComments()
            }
        }
    }
}


extension ResultVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reCommentCell", for: indexPath) as! ReCommentCell
        cell.lbCommentWriter.text = "\(model.content[indexPath.row].username)"
        cell.lbCommentContent.text = "\(model.content[indexPath.row].comment)"
        
        print(cell.lbCommentWriter.text!)
        print(cell.lbCommentContent.text!)
        
        return cell
    }
}
