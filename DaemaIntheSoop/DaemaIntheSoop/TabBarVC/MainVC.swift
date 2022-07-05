//
//  MainVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/16.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var result: [Content] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        
        getPostList()
    }
    
    private func getPostList() {
        AF.request("http://35.216.6.254:8080/board/all", method: .get)
            .validate(statusCode: 200..<500)
            .responseData {
                response in switch response.result {
                case.success:
                    print(response.result)
                    if let data = try? JSONDecoder().decode(MainPostModel.self, from: response.data!){
                        DispatchQueue.main.async {
                            self.result = data.content
                            self.listTableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! PostListCell
        cell.lbUser.text = "\(result[indexPath.row].username)"
        cell.lbTitle.text = "\(result[indexPath.row].title)"
        return cell
    }

}
