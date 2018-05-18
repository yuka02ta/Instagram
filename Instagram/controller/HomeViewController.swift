//
//  HomeViewController.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/16.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

/**---------------------------------*
 * HomeViewController
 *----------------------------------*/
class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentField: KeyBoard!
    
    var model: HomeModel = HomeModel()
    
    var postArray: [PostData] = []
    
    /**
     * viewDidLoad
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //commentField.isHidden = true
        
        /** テーブルセルのタップを無効にする */
        tableView.allowsSelection = false
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        // テーブル行の高さをAutoLayoutで自動調整する
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none

        // テーブル行の高さの概算値を設定しておく
        // 高さ概算値 = 「縦横比1:1のUIImageViewの高さ(=画面幅)」+「いいねボタン、キャプションラベル、その他余白の高さの合計概算(=100pt)」
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 200
    }
    
    /**
     * didReceiveMemoryWarning
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     * viewWillAppear
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        printDebag("viewWillAppear")
        
        /** 検索処理 */
        model.doInq(self)
    }
}

/**---------------------------------*
 * テーブル
 *----------------------------------*/
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    /**
     * tableView
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getPostList().count
    }
    
    /**
     * tableView
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /** セルを取得してデータを設定する */
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
        cell.setPostData(model.getPostList()[indexPath.row])
        
        /** セル内のボタンのアクションをソースコードで設定する */
        cell.likeButton.addTarget(self, action:#selector(handleButton(_:forEvent:)), for: .touchUpInside)
        cell.commentButton.addTarget(self, action:#selector(handleButtonComment(_:forEvent:)), for: .touchUpInside)
        
        return cell
    }
    
    /**
     * ヘッダーを消す
     */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    /**
     * いいね押下
     */
    @objc func handleButton(_ sender: UIButton, forEvent event: UIEvent) {
        
        /** タップされたセルのインデックスを求める */
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        /** いいね更新 */
        model.doIine(indexPath)
    }
    
    /**
     * コメント押下
     */
    @objc func handleButtonComment(_ sender: UIButton, forEvent event: UIEvent) {
        
        /** タップされたセルのインデックスを求める */
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
//        let commentCtrl:CommentViewController = segue.destination as! CommentViewController
//        commentCtrl.data = model.getPostList()[indexPath.row]
        
        /** ボタンが押されたらImageViewControllerをモーダルで表示する */
        let commentCtrl = self.storyboard?.instantiateViewController(withIdentifier: Const.STORYBOAD_COMMENT) as! CommentViewController
        commentCtrl.data = model.getPostList()[(indexPath?.row)!]
        self.present(commentCtrl, animated: true, completion: nil)
        
        /** キーボード呼び出し */
//        commentField.becomeFirstResponder()
        
        /** 飛んでく */
        
//        print(indexPath!.row)
        //alertOk("コメント", self)
        
        
    }
    
    @objc func test(){
        alertOk("wa-", self)
    }
}

