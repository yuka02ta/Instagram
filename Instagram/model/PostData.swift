//
//  PostData.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/17.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

/**---------------------------------*
 * PostData
 *----------------------------------*/
class PostData: NSObject {
    
    var id: String?
    
    /** 画像(UIImageに変換済み) */
    var image: UIImage?
    
    /** 画像(Base64のまま) */
    var imageString: String?
    
    /** 投稿者名 */
    var name: String?
    
    /** キャプション */
    var caption: String?
    
    /** 日付 */
    var date: Date?
    
    /** いいねをした人のIDの配列 */
    var likes: [String] = []
    
    /** 自分がいいねしたかどうかのフラグ */
    var isLiked: Bool = false
    
    /** コメント */
    var commentList: [CommentData] = []
    
    /**
     * 初期処理
     */
    init(snapshot: DataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: Any]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        
        self.name = valueDictionary["name"] as? String
        
        self.caption = valueDictionary["caption"] as? String
        
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
        /** いいねをした人取得 */
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }
        
        /** コメント */
        if let commentList = valueDictionary["commentList"] as? [CommentData]{
            self.commentList = commentList
        }
    }
}

/**---------------------------------*
 * CommentData
 *----------------------------------*/
class CommentData: NSObject {
    
    var id: String?
    var name: String?
    var comment: String?
    
    /**
     * 初期処理
     */
    init(snapshot: DataSnapshot) {
        self.id = snapshot.key
 
        let valueDictionary = snapshot.value as! [String: Any]
        
        self.name = valueDictionary["name"] as? String
        self.comment = valueDictionary["comment"] as? String
    }
}
