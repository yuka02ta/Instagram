//
//  SettingViewController.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/16.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit
import ESTabBarController

/**---------------------------------*
 * SettingViewController
 *----------------------------------*/
class SettingViewController: UIViewController {
    
    @IBOutlet weak var displayNameTextField: UITextField!
    
    /** モデル */
    var model: SettingModel = SettingModel()

    /**
     * viewDidLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /**
     * didReceiveMemoryWarning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     * 表示名変更ボタン押下
     */
    @IBAction func handleChangeButton(_ sender: Any) {
 
        /** 入力チェック */
        let msg = model.chkDisName(displayNameTextField.text!)
        if !msg.isEmpty{
            alertOk(msg, self)
            return
        }
        
        /** 表示名変更 */
        model.doUpdateDisName(self, displayNameTextField.text!)
    
        /** キーボードを閉じる */
        self.view.endEditing(true)
    }
    
    /**
     * ログアウトボタン押下
     */
    @IBAction func handleLogoutButton(_ sender: Any) {
        
        /** ログアウト処理 */
        model.doLogout()
        
        /** ログイン画面を表示する */
        let loginViewCtrl = self.storyboard?.instantiateViewController(withIdentifier: Const.STORYBOAD_LOGIN)
        self.present(loginViewCtrl!, animated: false, completion: nil)
        
        // ログイン画面から戻ってきた時のためにホーム画面（index = 0）を選択している状態にしておく
        let tabBarCtrl = parent as! ESTabBarController
        tabBarCtrl.setSelectedIndex(0, animated: false)
    }
    
    /**
     * 画面表示毎処理
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /** 表示名を取得してTextFieldに設定する */
        displayNameTextField.text = model.getDispUserName()!
    }
}
