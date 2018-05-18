//
//  KeyBoard.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/18.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit

/**---------------------------------*
 * KeyBoardView
 *----------------------------------*/
class KeyBoard: UITextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /**
     * 完了。キャンセルボタンの付いたキーボード作成
     */
    private func commonInit(){
        
        /** ツールバー作成 */
        let tools = UIToolbar()
        tools.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        
        /** ツールバー作成 */
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let closeButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(closeButtonTapped))
        let cancelButton = UIBarButtonItem(title: "キャンセル", style: .done, target: self, action: #selector(cancelButtonTapped))

        tools.items = [spacer, closeButton, cancelButton]
    }
    
    /**
     * 完了ボタン押下
     */
    @objc func closeButtonTapped(){
        
        self.endEditing(true)
        self.resignFirstResponder()
    }
    
    /**
     * キャンセルボタン押下
     */
    @objc func cancelButtonTapped(){
        
        self.endEditing(true)
        self.resignFirstResponder()
    }
    
//    func setView(){
//        /** 枠のカラー */
//        self.layer.borderColor = UIColor.lightText.cgColor
//
//        /** 枠の幅 */
//        self.layer.borderWidth = 1.0
//
//        /** 枠を角丸にする場合 */
//        self.layer.cornerRadius = 10.0
//        self.layer.masksToBounds = true
//    }
}
