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
    
    var model: [Content] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPostsTableView.delegate = self
        myPostsTableView.dataSource = self
        
        myPostsTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 20)
        
        getMyPosts()
    }
    
    
    
    @IBAction func btnLogOut(_ sender: Any) {
        guard let signOut = self.storyboard?.instantiateViewController(identifier: "LogInVC") as? LogInVC else { return }
        
        signOut.modalPresentationStyle = .fullScreen
        self.present(signOut, animated: true, completion: nil)
    }
    
    
    private func getMyPosts() {
        
        let url = "http://35.216.6.254:8080/board"
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
                            self.model = data.content
                            self.myPostsTableView.reloadData()
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
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myListCell", for: indexPath) as! MyPostCell
        myCell.lbMyPostTitle.text = "\(model[indexPath.row].title)"
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myPostsTableView.deselectRow(at: indexPath, animated: true)
        guard let myPost = self.storyboard?.instantiateViewController(withIdentifier: "MyDetailVC") as? MyDetailVC else { return }
        myPost.myPostTitle = "\(model[indexPath.row].title)"
        myPost.myPostContent = "\(model[indexPath.row].content)"
        myPost.myID = model[indexPath.row].id
        navigationController?.pushViewController(myPost, animated: true)
    }
}
