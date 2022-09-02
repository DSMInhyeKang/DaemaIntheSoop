//
//  CommentCell.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/08/06.
//

import UIKit
import Alamofire

class CommentCell: UITableViewCell {
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    
    var commentID: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    @IBAction func btnDeleteComment(_ sender: UIButton) {
        let url = "http://52.5.10.3:8080/board/comment/\(commentID)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .delete
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        AF.request(request).response { (response) in
            print(response.request ?? "")
            switch response.response?.statusCode {
            case 200:
                debugPrint(response)
//                let successOnAlert = UIAlertController(title: "안내", message: "댓글 삭제 완료", preferredStyle: UIAlertController.Style.alert)
//                let onAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default, handler: nil)
//
//                successOnAlert.addAction(onAction)
//                present(successOnAlert, animated: true, completion: nil)
                
            case 403:
                print("error")
//                let successOnAlert = UIAlertController(title: "안내", message: "삭제할 수 없습니다.", preferredStyle: UIAlertController.Style.alert)
//                let onAction = UIAlertAction(title: "닫기", style: UIAlertAction.Style.default, handler: nil)
//
//                successOnAlert.addAction(onAction)
//                present(successOnAlert, animated: true, completion: nil)
            
            default:
                debugPrint(response)
            }
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
