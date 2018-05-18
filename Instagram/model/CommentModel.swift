//
//  CommentModel.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/18.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseDatabase

/**---------------------------------*
 * PostModel
 *----------------------------------*/
class CommentModel{
    
    /**
     * コメント投稿処理
     */
    func doCommentPost(_ postData: PostData?, _ comment: String?){
        
        /** postDataに必要な情報を取得しておく */
        let name = Auth.auth().currentUser?.displayName
        
        if let postData = postData{
            /** 辞書を作成してFirebaseに保存する */
            let postRef = Database.database().reference().child(Const.POST_PATH).child(postData.id!).child("commentList")
            
            let comments = ["name": name, "comment": comment]
            postRef.childByAutoId().setValue(comments)
        }
    }
}
