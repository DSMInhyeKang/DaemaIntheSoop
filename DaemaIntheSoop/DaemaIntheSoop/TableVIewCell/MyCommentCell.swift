//
//  MyCommentCell.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/08/11.
//

import UIKit

class MyCommentCell: UITableViewCell {
    @IBOutlet weak var lbMyUser: UILabel!
    @IBOutlet weak var lbMyComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
