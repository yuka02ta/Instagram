//
//  PostModel.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/17.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

/**---------------------------------*
 * PostModel
 *----------------------------------*/
class PostModel{
    
    /**
     * 投稿処理
     */
    func doPost(_ imageData: Data?, _ caption: String?){
        
        /** base64形式に変換 */
        let imageString = imageData!.base64EncodedString(options: .lineLength64Characters)
        
        /** postDataに必要な情報を取得しておく */
        let time = Date.timeIntervalSinceReferenceDate
        let name = Auth.auth().currentUser?.displayName
        
        /** 辞書を作成してFirebaseに保存する */
        let postRef = Database.database().reference().child(Const.POST_PATH)
        let postData = ["caption": caption!, "image": imageString, "time": String(time), "name": name!]
        postRef.childByAutoId().setValue(postData)
    }
}
