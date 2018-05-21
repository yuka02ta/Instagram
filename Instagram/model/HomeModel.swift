//
//  HomeModel.swift
//  Instagram
//
//  Created by KawasumiYuka on 2018/05/17.
//  Copyright © 2018年 y.kawa. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseDatabase

/**---------------------------------*
 * HomeModel
 *----------------------------------*/
class HomeModel{
    
    var postArray: [PostData] = []
    
    /** DatabaseのobserveEventの登録状態を表す */
    var observing = false
    
    /**
     * いいね処理
     */
    func doIine(_ indexPath: IndexPath?){

        // 配列からタップされたインデックスのデータを取り出す
        let postData = postArray[indexPath!.row]
        
        // Firebaseに保存するデータの準備
        if let uid = Auth.auth().currentUser?.uid {
            if postData.isLiked {
                // すでにいいねをしていた場合はいいねを解除するためIDを取り除く
                var index = -1
                for likeId in postData.likes {
                    if likeId == uid {
                        // 削除するためにインデックスを保持しておく
                        index = postData.likes.index(of: likeId)!
                        break
                    }
                }
                postData.likes.remove(at: index)
            } else {
                postData.likes.append(uid)
            }
            
            // 増えたlikesをFirebaseに保存する
            let postRef = Database.database().reference().child(Const.POST_PATH).child(postData.id!)
            let likes = ["likes": postData.likes]
            postRef.updateChildValues(likes)
        }
    }
    
    /**
     * 検索処理
     */
    func doInq( _ target: HomeViewController){
        
        if Auth.auth().currentUser != nil {
            if self.observing == false {
                // 要素が追加されたらpostArrayに追加してTableViewを再表示する
                let postsRef = Database.database().reference().child(Const.POST_PATH)
                postsRef.observe(.childAdded, with: { snapshot in
                    printDebag(".childAddedイベントが発生しました。")
                    
                    /** PostDataクラスを生成して受け取ったデータを設定する */
                    if let uid = Auth.auth().currentUser?.uid {
                        let postData = PostData(snapshot: snapshot, myId: uid)
                        self.postArray.insert(postData, at: 0)
                        
                        /** 保持している配列からidが同じものを探す */
                        var index: Int = 0
                        for post in self.postArray {
                            if post.id == postData.id {
                                index = self.postArray.index(of: post)!
                                break
                            }
                        }
                        
                        /** コメントリストの取得 */
                        postsRef.child(postData.id!).child("commentList").observe(.value, with: { snapshotSub in

                            for itemSnapShot in snapshotSub.children {

                                let commentData = CommentData(snapshot: itemSnapShot as! DataSnapshot)
                                postData.commentList.append(commentData)
                            }
                            /** 差し替えるため一度削除する */
                            self.postArray.remove(at: index)
                            
                            self.postArray.insert(postData, at: index)
                            /** TableViewを再表示する */
                            target.tableView.reloadData()
                            
                        })
                        
                    }
                })
                // 要素が変更されたら該当のデータをpostArrayから一度削除した後に新しいデータを追加してTableViewを再表示する
                postsRef.observe(.childChanged, with: { snapshot in
                    printDebag(".childChangedイベントが発生しました。")
                    
                    if let uid = Auth.auth().currentUser?.uid {
                        /** PostDataクラスを生成して受け取ったデータを設定する */
                        let postData = PostData(snapshot: snapshot, myId: uid)
                        
                        /** 保持している配列からidが同じものを探す */
                        var index: Int = 0
                        for post in self.postArray {
                            if post.id == postData.id {
                                index = self.postArray.index(of: post)!
                                break
                            }
                        }
                        
                        /** コメントリストの取得 */
                        postsRef.child(postData.id!).child("commentList").observe(.value, with: { snapshotSub in
                            
                            for itemSnapShot in snapshotSub.children {
                                
                                let commentData = CommentData(snapshot: itemSnapShot as! DataSnapshot)
                                postData.commentList.append(commentData)
                            }
                            
                            /** 差し替えるため一度削除する */
                            self.postArray.remove(at: index)
                            
                            /** 削除したところに更新済みのデータを追加する */
                            self.postArray.insert(postData, at: index)
                            
                            /** TableViewを再表示する */
                            target.tableView.reloadData()
                            
                        })
                    }
                })
                
                // DatabaseのobserveEventが上記コードにより登録されたため
                // trueとする
                observing = true
            }
        } else {
            if observing == true {
                // ログアウトを検出したら、一旦テーブルをクリアしてオブザーバーを削除する。
                // テーブルをクリアする
                postArray = []
                // TableViewを再表示する
                target.tableView.reloadData()

                // オブザーバーを削除する
                Database.database().reference().removeAllObservers()
                
                // DatabaseのobserveEventが上記コードにより解除されたため
                // falseとする
                observing = false
            }
        }
    }
    
    /**
     * いいね処理
     */
    func getPostList() -> [PostData]{
        return postArray
    }
    
}


