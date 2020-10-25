//
//  SeaveViewController.swift
//  MemoryFaceTests
//
//  Created by 福井　愛梨 on 2019/11/09.
//  Copyright © 2019 福井　愛梨. All rights reserved.
//

import UIKit
import RealmSwift
import AssetsLibrary

class personArray: Object{
       @objc dynamic var textFieldString: String = ""
       @objc dynamic var hint1: String = ""
       @objc dynamic var hint2: String = ""
       @objc dynamic var pictureurl: String = ""
   }


class SeaveViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate{
    
    var textFieldString = ""
    var hint1 = ""
    var hint2 = ""
    var  URL = ""
    private var realm: Realm!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var hint1TextField: UITextField!
    @IBOutlet weak var hint2TextField: UITextField!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        hint1TextField.delegate = self
        hint2TextField.delegate = self
        }
    
    
    
    
    @IBAction func albumButton(_ sender: Any) {
        //imagePickerCountrollerのインスタンスを作る
        let imagePickerCountroller: UIImagePickerController = UIImagePickerController()
        //フォットライブラリを使う設定をする
        imagePickerCountroller.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerCountroller.delegate = self
        imagePickerCountroller.allowsEditing = true
        //フォットライブラリを呼び出す
        self.present(imagePickerCountroller, animated: true, completion: nil)
    }

    
    
    
        //アルバム画面で写真を選択した時
           func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            //        //string型に変換、保存
            //        let Imageinfo = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            //
            //        //imageに選んだ画像を設定する
            //        let image = info[.originalImage] as? UIImage
            //        let imageUrl = info[UIImagePickerController.InfoKey.referenceURL] as? NSURL
            //        URL = (imageUrl?.absoluteString)!
            //        //imageをpictureImageViewに設定する
            //        pictureImageView.image = image
                    //フォトライブラリを閉じる
            
            // defer はブロックを抜ける時に defer 内の処理が実行されます
               defer {
                  picker.dismiss(animated: true, completion: nil)
               }
               // 選択した画像から PHAsset を取得
               // 画像ライブラリへのアクセスが許可されていない場合は nil が返ってきます
               guard let phAsset = info[.phAsset] as? PHAsset else { return }
            
               let options = PHContentEditingInputRequestOptions()
               phAsset.requestContentEditingInput(with: options) { (input, info) in
                   // fullSizeImageURL に選択した画像のURLが入っているのでアンラップします
                   guard let URL = input?.fullSizeImageURL else { return }

                   // これを Realm に保存するなりしてください
                   // Realm だと URL は保存できないと思うので、Stringに変換するといいかもしれないです
                
                //let imageUrl = /*Realmから読み込んだURLのStringだと思ってください*/
                let pictureurl = URL(string: urlString) {
                    do {
                        let data = try Data(contentsOf: url)

                        guard let pictureImageView = UIImage(data: data) else { return }
                        pictureImageView.image = image
                    } catch {
                        print(error)
                    }
                }
                   print(url.absoluteString)
               }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveButton(_ sender: Any) {
        let person1 = personArray()
        person1.textFieldString = nameTextField.text!
        person1.hint1  = hint1TextField.text!
        person1.hint2 = hint2TextField.text!
        person1.pictureurl = URL
        print("person1,textFieldString",person1.textFieldString)
        print("person1,hint1",person1.hint1)
        print("person1,hint2",person1.hint2)
        print("person1,pictureurl",person1.pictureurl)
        
        
        //personを格納するリストの作成
        let persons = List<personArray>()
        persons.append(person1)
        //print("person1",persons)
        
        // Realmのインスタンスを生成する
        let realm = try! Realm()
        
        // 書き込みトランザクション内でデータを追加する
        try! realm.write {
            realm.add(persons)
        }
        
        }
    
         func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             textField.resignFirstResponder()
             return true
             
         }
    }


