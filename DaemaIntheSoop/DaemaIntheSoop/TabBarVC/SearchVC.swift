//
//  SearchVC.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/08/07.
//

import UIKit
import Alamofire

class SearchVC: UIViewController {
    @IBOutlet weak var searchTableView: UITableView!

    var searchList =  SearchModel()
    var result: [Content] = []

    var arr: Array<String> = []
    var filteredArr: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(named: "NoticeColor")
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 30, weight: .bold), 
            .foregroundColor: UIColor(named: "NoticeColor") ?? ""
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupSearchController()
        self.setupTableView()
    
        searchTableView.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 30)
        
        getPostList()
    }
  
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    
    private func getPostList() {
        AF.request("http://52.5.10.3:8080/board/all", method: .get)
            .validate(statusCode: 200..<500)
            .responseData {
                response in switch response.result {
                case .success:
                    debugPrint(response)
                    if let data = try? JSONDecoder().decode(MainPostModel.self, from: response.data!){
                        DispatchQueue.main.async { [self] in
                            self.result = data.content
                            self.searchTableView.reloadData()
                            
                            print("thisiswhatIprint")
                            self.searchList.arrSearch = self.result.map { $0.title }
                            self.arr = searchList.arrSearch
                            print(arr)
                        }
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    
            }
        }
    }

    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색어를 입력하세요."
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "NoticeColor")!]
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupTableView() {
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredArr.count : self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if self.isFiltering {
            cell.textLabel?.text = self.filteredArr[indexPath.row]
        } else {
            cell.textLabel?.text = self.arr[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTableView.deselectRow(at: indexPath, animated: true)
        guard let view = self.storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultVC else { return }
        view.postTitle = "\(result[indexPath.row].title)"
        view.postWriter = "\(result[indexPath.row].username)"
        view.txt = "\(result[indexPath.row].content)"
        view.postID = result[indexPath.row].id

        navigationController?.pushViewController(view, animated: true)
    }
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        self.filteredArr = self.arr.filter { $0.localizedCaseInsensitiveContains(text) }
        
        self.searchTableView.reloadData()
    }
}
