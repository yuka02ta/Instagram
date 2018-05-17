//
//  PostViewController.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/16.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit

/**---------------------------------*
 * PostViewController
 *----------------------------------*/
class PostViewController: UIViewController {
    
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    /** モデル */
    var model: PostModel = PostModel()

    /**
     * viewDidLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** 受け取った画像をImageViewに設定する */
        imageView.image = image
    }
    
    /**
     * didReceiveMemoryWarning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     * 投稿ボタンをタップしたときに呼ばれるメソッド
     */
    @IBAction func handlePostButton(sender: UIButton) {
        
        /** ImageViewから画像を取得する */
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.5)
        model.doPost(imageData, textField.text!)
        
        /** 完了msg */
        alertOk("投稿しました", self)
        
        /** 全てのモーダルを閉じる */
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    /**
     * キャンセルボタンをタップしたときに呼ばれるメソッド
     */
    @IBAction func handleCancelButton(_ sender: Any) {
        
        /** 画面を閉じる */
        dismiss(animated: false, completion: nil)
    }
}
