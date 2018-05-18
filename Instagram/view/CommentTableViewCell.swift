//
//  CommentTableViewCell.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/17.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    /**
     * awakeFromNib
     */
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
     * setSelected
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /**
     * 表示内容をセット
     */
    func setCommentData(_ commentData: CommentData) {
        
        print("set")
        
        /** 写真・キャプション */
        self.commentLabel.text = commentData.comment
        self.nameLabel.text = commentData.name
    }
}
