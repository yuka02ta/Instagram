//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/16.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit
import CLImageEditor

/**---------------------------------*
 * ImageSelectViewController
 *----------------------------------*/
class ImageSelectViewController: UIViewController, UINavigationControllerDelegate {

    let imgPickerCtrl = UIImagePickerController()
    let pickerCtrl = UIImagePickerController()
    
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
     * ライブラリ押下
     */
    @IBAction func handleLibraryButton(_ sender: Any) {
        
        /** ライブラリ（カメラロール）を指定してピッカーを開く */
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            pickerCtrl.delegate = self
            pickerCtrl.sourceType = .photoLibrary
            self.present(pickerCtrl, animated: false, completion: nil)
        }
    }
    
    /**
     * カメラ押下
     */
    @IBAction func handleCameraButton(_ sender: Any) {
        
        /** カメラを指定してピッカーを開く */
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            imgPickerCtrl.delegate = self
            imgPickerCtrl.sourceType = .camera
            self.present(imgPickerCtrl, animated: false, completion: nil)
        }
    }
    
    /**
     * キャンセル押下
     */
    @IBAction func handleCancelButton(_ sender: Any) {
        
        /** 画面を閉じる */
        self.dismiss(animated: true, completion: nil)
    }
}

/**---------------------------------*
 * カメラ
 *----------------------------------*/
 extension ImageSelectViewController: UIImagePickerControllerDelegate, CLImageEditorDelegate{
    
    /**
     * 写真を撮影/選択したときに呼ばれる
     */
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if info[UIImagePickerControllerOriginalImage] != nil {
            /** 撮影/選択された画像を取得する */
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            /** あとでCLImageEditorライブラリで加工する */
            printDebag("image = \(image)")
            
            /** CLImageEditorにimageを渡して、加工画面を起動する */
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            picker.pushViewController(editor, animated: false)
            
        }
    }
    
    /**
     * 閉じるCLImageEditorで加工終了時
     */
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        
        /** 投稿の画面を開く */
        let postViewCtrl = self.storyboard?.instantiateViewController(withIdentifier: Const.STORYBOAD_POST) as! PostViewController
        
        /** 写真をセット */
        postViewCtrl.image = image!
        editor.present(postViewCtrl, animated: true, completion: nil)
    }
    
    /**
     * 閉じる
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        /** 閉じる */
        picker.dismiss(animated: false, completion: nil)
    }
}

