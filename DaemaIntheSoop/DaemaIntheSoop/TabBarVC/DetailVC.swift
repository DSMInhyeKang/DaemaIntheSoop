//
//  DetailVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/17.
//

import UIKit
import Alamofire

class DetailVC: UIViewController {
    @IBOutlet weak var lbPostTitle: UILabel!
    @IBOutlet weak var lbPostWriter: UILabel!
    @IBOutlet weak var txtViewContent: UITextView!
    
    
    var result: [DetailPostModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPostDetail()
    }

    private func getPostDetail() {
        AF.request("http://35.216.6.254:8080/board/all", method: .get)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: [DetailPostModel].self) {
                response in switch response.result {
                case.success:
                    if let data = try? JSONDecoder().decode([DetailPostModel].self, from: response.data!){
                        print(data)
                        DispatchQueue.main.async {
                            self.result = data
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }

//}
//
//extension MainVC: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return result.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! PostListCell
//        cell.lbUser.text = "\(result[indexPath.row].username)"
//        cell.lbTitle.text = "\(result[indexPath.row].title)"
//        return cell
//    }
//
}
