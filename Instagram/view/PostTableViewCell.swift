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
    
    @IBOutlet weak var commentTable: UITableView!
    
    var postData: PostData?
    
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
        
        commentTable.delegate = self
        commentTable.dataSource = self
        
        self.postData = postData
        
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
        let buttonCommentImage = UIImage(named: Const.IMG_COMMENT)
        self.commentButton.setImage(buttonCommentImage, for: .normal)
        
        /** テーブルセルのタップを無効にする */
        self.commentTable.allowsSelection = false
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        self.commentTable.register(nib, forCellReuseIdentifier: "CommentCell")
        
        // テーブル行の高さをAutoLayoutで自動調整する
        //self.commentTable.rowHeight = UITableViewAutomaticDimensio
        
        self.commentTable.rowHeight = 50 * 2
        
        // テーブル行の高さの概算値を設定しておく
        // 高さ概算値 = 「縦横比1:1のUIImageViewの高さ(=画面幅)」+「いいねボタン、キャプションラベル、その他余白の高さの合計概算(=100pt)」
        //self.commentTable.estimatedRowHeight = 50
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
        //
        
        if let data = self.postData?.commentList{
           return data.count
        }else{
            return 0
        }
    }
    
    /**
     * tableView
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /** セルを取得してデータを設定する */
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        
        if let data = self.postData?.commentList[indexPath.row] {
            cell.setCommentData(data)
            print(data.comment!)
        }
        
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
