//
//  LoginViewController.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/16.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

/**---------------------------------*
 * LoginViewController
 *----------------------------------*/
class LoginViewController: UIViewController {
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    var model: LoginModel = LoginModel()
    var msg: String = ""

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
     * ログインボタン押下
     */
    @IBAction func handleLoginButton(_ sender: Any) {
        
        /** ログイン処理 */
        model.doLogin(self, mailAddressTextField.text, passwordTextField.text)
    }
    
    /**
     * アカウント作成ボタン押下
     */
    @IBAction func handleCreateAcountButton(_ sender: Any) {
        
        /** アカウント作成処理 */
        model.doCreateAcount(self, mailAddressTextField.text, passwordTextField.text, displayNameTextField.text)
    }
}
