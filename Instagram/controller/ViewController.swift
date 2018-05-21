//
//  ViewController.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/16.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth

/**---------------------------------*
 * ViewController
 *----------------------------------*/
class ViewController: UIViewController {

    /**
     * 起動時処理
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /** ログインチェック */
        if Auth.auth().currentUser == nil {
            
            /** ログイン画面遷移（モーダル） */
            let loginViewCtrl = self.storyboard?.instantiateViewController(withIdentifier: Const.STORYBOAD_LOGIN)
            self.present(loginViewCtrl!, animated: false, completion: nil)
        }
    }
    
    /**
     * viewDidLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTab()
    }
    
    /**
     * didReceiveMemoryWarning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

/**---------------------------------*
 * タブ
 *----------------------------------*/
extension ViewController{
    /**
     * タブセット
     */
    func setupTab() {
        
        /** 画像のファイル名を指定してESTabBarControllerを作成する */
        let tabBarCtrl: ESTabBarController! = ESTabBarController(tabIconNames: [Const.IMG_HOME, Const.IMG_CAMERA, Const.IMG_SETTING])
        
        /** 背景色、選択時の色、選択インジケーターの高さを設定する */
        tabBarCtrl.selectedColor = UIColor(red: 1.0, green: 102/255, blue: 242/255, alpha: 1)
        tabBarCtrl.buttonsBackgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        tabBarCtrl.selectionIndicatorHeight = 3
        
        /** 作成したESTabBarControllerを親のViewController（＝self）に追加する */
        addChildViewController(tabBarCtrl)
        
        /** 制約をセット */
        let tabBarView = tabBarCtrl.view!
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)
        //let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tabBarView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ])
        tabBarCtrl.didMove(toParentViewController: self)
        
        /** ボタン押下時設定 */
        setTapBtn(tabBarCtrl)
    }
    
    /**
     * ボタン押下時設定
     */
    func setTapBtn(_ tabBarCtrl: ESTabBarController){
        
        /** タブをタップした時に表示するViewControllerを設定する */
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Const.STORYBOAD_HOME)
        let settingViewController = storyboard?.instantiateViewController(withIdentifier: Const.STORYBOAD_SETTING)
        
        tabBarCtrl.setView(homeViewController, at: 0)
        tabBarCtrl.setView(settingViewController, at: 2)
        
        /** 真ん中のタブはボタンとして扱う */
        tabBarCtrl.highlightButton(at: 1)
        tabBarCtrl.setAction({
            /** ボタンが押されたらImageViewControllerをモーダルで表示する */
            let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: Const.STORYBOAD_IMAGE_SELECT)
            self.present(imageViewController!, animated: true, completion: nil)
        }, at: 1)
    }
}
