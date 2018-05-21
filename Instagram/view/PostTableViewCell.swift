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
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var wrapView: UIView!
    
    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    
    var postDataList: [PostData]?
    
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
    func setPostData(_ index: Int, _ postDataList: [PostData]) {
        
        commentTable.delegate = self
        commentTable.dataSource = self
        commentTable.tag = index
        
        self.postDataList = postDataList
        let postData = self.postDataList![index]
        
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
        
        /** コメント数 */
        let commentNumber = postData.commentList.count
        commentLabel.text = "(" + "\(commentNumber)" + "件)"
        
        /** コメント */
        let buttonCommentImage = UIImage(named: Const.IMG_COMMENT)
        self.commentButton.setImage(buttonCommentImage, for: .normal)
        
        /** テーブルセルのタップを無効にする */
        self.commentTable.allowsSelection = false
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        self.commentTable.register(nib, forCellReuseIdentifier: "CommentCell")
        
        /** view */
        self.wrapView.layer.borderWidth = 0.5
        self.wrapView.layer.borderColor = UIColor.lightGray.cgColor
        self.commentTable.layer.borderWidth = 0.5
        self.commentTable.layer.borderColor = UIColor.lightGray.cgColor
        if commentNumber == 0{
            self.tableHeight.constant = 0
        }else{
            self.tableHeight.constant = 100
        }
        
        /** TableViewを再表示する */
        self.commentTable.reloadData()
    }
}

/**---------------------------------*
 * コメントテーブル
 *----------------------------------*/
extension PostTableViewCell: UITableViewDataSource, UITableViewDelegate{
    
    /**
     * tableView
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let postData = postDataList![tableView.tag]
        return postData.commentList.count

    }
    
    /**
     * tableView
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /** セルを取得してデータを設定する */
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        let postData = postDataList![tableView.tag]
        cell.setCommentData(postData.commentList[indexPath.row])
        
        return cell
    }
    
    /**
     * ヘッダーを消す
     */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
}
