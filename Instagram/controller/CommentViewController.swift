//
//  CommentViewController.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/18.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit

/**---------------------------------*
 * CommentViewController
 *----------------------------------*/
class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentView: UITextView!
    
    var data: PostData?
    var model: CommentModel = CommentModel()
    
    /**
     * viewDidLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** キーボード開く */
        commentView.becomeFirstResponder()
    }
    
    /**
     * didReceiveMemoryWarning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     * 完了押下
     */
    @IBAction func handleDoneButton(_ sender: Any) {
        
        model.doCommentPost(data, commentView.text)
        
        /** 画面を閉じる */
        self.dismiss(animated: true, completion: nil)
    }
    
    /**
     * キャンセル押下
     */
    @IBAction func handleCancelButton(_ sender: Any) {
        
        /** 画面を閉じる */
        self.dismiss(animated: true, completion: nil)
    }
}
