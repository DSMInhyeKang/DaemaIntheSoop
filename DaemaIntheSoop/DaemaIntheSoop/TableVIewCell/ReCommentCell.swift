//
//  ReCommentCell.swift
//  DaemaIntheSoop
//
//  Created by 강인혜 on 2022/08/12.
//

import UIKit

class ReCommentCell: UITableViewCell {
    @IBOutlet weak var lbCommentWriter: UILabel!
    @IBOutlet weak var lbCommentContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
