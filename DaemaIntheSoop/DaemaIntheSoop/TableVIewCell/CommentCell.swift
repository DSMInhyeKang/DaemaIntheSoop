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
    
}
