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
    
    
//    var result: [resultsArr] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        lbPostTitle.delegate = self
//        lbPostTitle.dataSource = self
//
//        getUsers()
//    }
//
//    private func getUsers() {
//        AF.request("http://35.216.6.254:8080/board/all", method: .get)
//            .validate(statusCode: 200..<500)
//            .responseDecodable(of: [resultsArr].self) {
//                response in switch response.result {
//                case.success:
//                    if let data = try? JSONDecoder().decode([resultsArr].self, from: response.data!){
//                        print(data)
//                        DispatchQueue.main.async {
//                            self.result = data
//                            self.listTableView.reloadData()
//                        }
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
//
//
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//
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
