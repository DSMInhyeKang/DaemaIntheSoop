//
//  MyPageVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/16.
//

import UIKit
import Alamofire

class MyPageVC: UIViewController {
    
    @IBOutlet weak var myPostsTableView: UITableView!
    @IBOutlet weak var lbMyName: UILabel!
    @IBOutlet weak var lbMyUsername: UILabel!
    
    var model = MainPostModel()
    var userModel = UserInfoModel()
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        myPostsTableView.delegate = self
        myPostsTableView.dataSource = self
        
        myPostsTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 30)
        
        getUserInfo()
        getMyPosts()
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        guard let signOut = self.storyboard?.instantiateViewController(identifier: "LogInVC") as? LogInVC else { return }
        
        signOut.modalPresentationStyle = .fullScreen
        self.present(signOut, animated: true, completion: nil)
    }
    
    
    @objc func pullToRefresh(_ sender: Any) {
        getMyPosts()
    }
    
    
    private func getMyPosts() {
        let url = "http://52.5.10.3:8080/board"
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
            
                    if let data = try? JSONDecoder().decode(MainPostModel.self, from: response.data!){
                        DispatchQueue.main.async {
                            self.model = data
                            self.myPostsTableView.reloadData()
                            
                            self.myPostsTableView.refreshControl = UIRefreshControl()
                            self.myPostsTableView.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                            self.myRefreshControl.endRefreshing()
                        }
                    }
            
            
                case .failure(let error):
                    print(error)
                    self.myPostsTableView.refreshControl = UIRefreshControl()
                    self.myPostsTableView.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                    self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    private func getUserInfo() {
        let url = "http://52.5.10.3:8080/user"
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
            
                    if let data = try? JSONDecoder().decode(UserInfoModel.self, from: response.data!){
                        DispatchQueue.main.async {
                            self.userModel = data
                            
                            self.lbMyName.text = "\(self.userModel.name)"
                            self.lbMyUsername.text = "\(self.userModel.username)"
                        }
                    }
            
            
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}


extension MyPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myListCell", for: indexPath) as! MyPostCell
        myCell.lbMyPostTitle.text = "\(model.content[indexPath.row].title)"
        
//        lbMyName.text = "\(model.content.)"
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myPostsTableView.deselectRow(at: indexPath, animated: true)
        guard let myPost = self.storyboard?.instantiateViewController(withIdentifier: "MyDetailVC") as? MyDetailVC else { return }
        myPost.myPostTitle = "\(model.content[indexPath.row].title)"
        myPost.myPostContent = "\(model.content[indexPath.row].content)"
        myPost.myID = model.content[indexPath.row].id
        navigationController?.pushViewController(myPost, animated: true)
    }
}
