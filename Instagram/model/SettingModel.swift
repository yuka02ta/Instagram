//
//  SettingModel.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/17.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

/**---------------------------------*
 * SettingModel
 *----------------------------------*/
class SettingModel{
    
    /**
     * 表示ユーザー名取得
     */
    func getDispUserName() -> String?{
        
        var userName: String? = ""
        /** 表示名を取得してTextFieldに設定する */
        let user = Auth.auth().currentUser
        if let user = user {
            userName = user.displayName
        }
        
        return userName!
    }
    
    /**
     * 表示ユーザー名チェック
     */
    func chkDisName(_ dispName: String?) -> String{
        
        var msg = ""
        
        /** チェック */
        if let dispName = dispName {
            if dispName.isEmpty{
                msg = "表示名を入力して下さい"
            }
        }
        
        return msg
    }
    
    /**
     * 表示ユーザー名更新
     */
    func doUpdateDisName( _ target: UIViewController, _ dispName: String?){
        
        if let dispName = dispName {

            let user = Auth.auth().currentUser
            
            if let user = user {
                
                /** 表示ユーザー名更新 */
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = dispName
                changeRequest.commitChanges { error in
                    if let error = error {
                        print("DEBUG_PRINT: " + error.localizedDescription)
                    }
                    printDebag("[displayName = \(String(describing: user.displayName))]の設定に成功しました。")

                    alertOk("表示名を変更しました", target)
                }
            } else {
                printDebag("displayNameの設定に失敗しました。")
            }
        }
    }
    
    /**
     * ログアウト処理
     */
    func doLogout(){
        
        /** ログアウトする */
        try! Auth.auth().signOut()
    }
    
    
}
