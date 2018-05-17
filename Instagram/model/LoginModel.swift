//
//  LoginModel.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/17.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

/**---------------------------------*
 * LoginModel
 *----------------------------------*/
class LoginModel{
    
    /**
     * ログイン処理
     */
    func doLogin( _ target: UIViewController, _ mailAddress: String?, _ password: String?){

        if let mailAddress = mailAddress, let password = password {
            
            /** アドレスとパスワード名のいずれかでも入力されていない時は何もしない */
            if mailAddress.isEmpty || password.isEmpty {
                alertOk("必要項目を入力して下さい", target)
                return
            }
            
            /** HUD表示 */
            progressShow()
            
            /** ログイン処理 */
            Auth.auth().signIn(withEmail: mailAddress, password: password) { user, error in
                
                /** HUD削除 */
                progressDismiss()
                
                if let error = error {
                    
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    alertOk("サインインに失敗しました。", target)
                } else {
                    printDebag("ログインに成功しました。")
                    
                    /** 画面を閉じてViewControllerに戻る */
                    target.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    /**
     * アカウント作成処理
     */
    func doCreateAcount( _ target: UIViewController, _ mailAddress: String?, _ password: String?, _ displayName: String?){
        
        if let address = mailAddress,
            let password = password,
            let displayName = displayName {
            
            /** アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない */
            if address.isEmpty || password.isEmpty || displayName.isEmpty {
                
                alertOk("必要項目を入力して下さい", target)
                return
            }
            
            /** HUD表示 */
            progressShow()
            
            /** アドレスとパスワードでユーザー作成。ユーザー作成に成功すると、自動的にログインする */
            Auth.auth().createUser(withEmail: address, password: password) { user, error in
                
                /** エラー処理 */
                if let error = error {
                    printDebag(error.localizedDescription)
                    return
                }
                printDebag("ユーザー作成に成功しました。")
                
                /** 表示名を設定する */
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { error in
                        if let error = error {
                            printDebag(error.localizedDescription)
                        }
                        printDebag("[displayName = \(String(describing: user.displayName))]の設定に成功しました。")
                        
                        /** HUD削除 */
                        progressDismiss()
                        
                        /** 画面を閉じてViewControllerに戻る */
                        target.dismiss(animated: true, completion: nil)
                    }
                } else {
                    printDebag("displayNameの設定に失敗しました。")
                }
            }
        }
    }
    
}
