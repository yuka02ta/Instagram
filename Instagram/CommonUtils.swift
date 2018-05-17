//
//  CommonUtils.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/16.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import SVProgressHUD

/**
 * HUDで処理中表示
 */
func progressShow(){
    
    //SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskTypeBlack)
    SVProgressHUD.show()
}

/**
 * HUD削除
 */
func progressDismiss(){
    
    SVProgressHUD.dismiss()
}

/**
 * メッセージボックス
 */
func alertOk(_ msg: String, _ tar: UIViewController) {
    
    let alert = UIAlertController(title: msg, message: nil, preferredStyle: .alert)
    let myOkAction = UIAlertAction(title: "OK", style: .default)
    alert.addAction(myOkAction)
    tar.present(alert, animated: true, completion: nil)
}

/**
 * デバック用
 */
func printDebag(_ errorMsg: String){
    
    print("DEBUG_PRINT: " + errorMsg)
}

/**
 * Date→String
 */
func dateToString(_ date:Date) -> String{
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    
    let dateString:String = formatter.string(from: date)
    
    return dateString
}

