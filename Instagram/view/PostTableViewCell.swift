//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/17.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!

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
    func setPostData(_ postData: PostData) {
        
        /** 写真・キャプション */
        self.postImageView.image = postData.image
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        /** いいね数 */
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        /** 日付 */
        self.dateLabel.text = dateToString(postData.date!)
        
        /** いいねの画像 */
        if postData.isLiked {
            let buttonImage = UIImage(named: Const.IMG_LIKE_EXIST)
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: Const.IMG_LIKE_NONE)
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        /** コメント */
        let buttonCommentImage = UIImage(named: Const.IMG_LIKE_NONE)
        self.commentButton.setImage(buttonCommentImage, for: .normal)
    }
}
