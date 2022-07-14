//
//  MainVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/06/16.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var listTableView: UITableView!
    
    var result: [Content] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self
        
        refreshControl.endRefreshing() // 초기화 - refresh 종료
        listTableView.refreshControl = refreshControl
        
//        let refreshLoading = PublishRelay<Bool>() // ViewModel에 있다고 가정
//        refreshControl.rx.controlEvent(.valueChanged)
//            .bind(onNext: { [weak self] _ in
//                // viewModel.updateDataSource()
//
//                // 아래코드: viewModel에서 발생한다고 가정
//                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) { [weak self] in
//                    self?.refreshLoading.accept(true) // viewModel에서 dataSource업데이트 끝난 경우
//                }
//            }).disposed(by: bag)
        
        getPostList()
    }
    
    private func getPostList() {
        AF.request("http://35.216.6.254:8080/board/all", method: .get)
            .validate(statusCode: 200..<500)
            .responseData {
                response in switch response.result {
                case .success:
//                    print(response.result)
                    debugPrint(response)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listTableView.deselectRow(at: indexPath, animated: true)
        guard let view = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        view.postTitle = "\(result[indexPath.row].title)"
        view.postWriter = "\(result[indexPath.row].username)"
        view.txt = "\(result[indexPath.row].content)"
//        view.indexList = indexList
//        view.indexValue = indexPath.row
        view.id = result[indexPath.row].id
        navigationController?.pushViewController(view, animated: true)
    }
}
