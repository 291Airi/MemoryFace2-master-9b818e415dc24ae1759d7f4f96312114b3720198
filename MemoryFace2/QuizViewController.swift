//
//  QuizViewController.swift
//  MemoryFace2
//
//  Created by 福井　愛梨 on 2019/11/09.
//  Copyright © 2019 福井　愛梨. All rights reserved.
//

import UIKit
import RealmSwift

class QuizViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nextquiz: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var pictureImageView1: UIImageView!
    @IBOutlet weak var nameTextField1: UITextField!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var hint1Button: UIButton!
    @IBOutlet weak var hint2Button: UIButton!
    @IBOutlet weak var ansewrButton: UIButton!
    @IBOutlet weak var mistake: UIButton!
    
    var timer: Timer!
    var textFieldString = ""
    
    var num: Int!
    
    private var realm: Realm!
    
    override func viewDidLoad() {
        
        // (1)Realmのインスタンスを生成する
            let realm1 = try! Realm()
        // (2)全データの取得
            let results = realm1.objects(personArray.self)
        // (3)取得データの確認
            print(results)
        
        // 取得件数の表示
        print("results\(results.count)")
        num = Int.random(in: 0...results.count - 1)
        
        print("ランダムな数\(num)")
        print(results[num].pictureurl)
    
        pictureImageView1.image = UIImage(named: results[num].pictureurl)
       
        print("あああああ")
        print("画像\(results[num].pictureurl)")
        
        image.isHidden = true
        nextquiz.isHidden = true
        hintLabel.isHidden = true
        hint1Button.isHidden = false
        hint2Button.isHidden = false
        ansewrButton.isHidden = false
        mistake.isHidden = false
        
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func hint1Button(_ sender: Any) {
        // (1)Realmのインスタンスを生成する
            let realm1 = try! Realm()
        // (2)全データの取得
            let results = realm1.objects(personArray.self)
        // (3)取得データの確認
            print(results)
        
        hintLabel.text = results[num].hint1
        hintLabel.isHidden = false
        print("クイズヒント１",results[num].hint1)
        }
    


    @IBAction func hint2Button(_ sender: Any) {
        // (1)Realmのインスタンスを生成する
        let realm1 = try! Realm()
        // (2)全データの取得
        let results = realm1.objects(personArray.self)
        // (3)取得データの確認
        print(results)
              
        hintLabel.text = results[num].hint2
        hintLabel.isHidden = false
        print("クイズヒント2",results[num].hint2)
    }


    @IBAction func mistake(_ sender: Any) {
        // TextFieldから文字を取得
            textFieldString = nameTextField1.text!
        //もし、textfieldとrealmが一致したら
                // (1)Realmのインスタンスを生成する
                let realm1 = try! Realm()
                // (2)全データの取得
                let results = realm1.objects(personArray.self)
                // (3)取得データの確認
                print(results)
        
        answerLabel.text = results[num].textFieldString
        
        self.image.image = UIImage(named: "mark_batsu.png")
        image.isHidden = false
        let image = UIImage(named: "mark_maru.png")
        nextquiz.isHidden = false
        hint1Button.isHidden = true
        hint2Button.isHidden = true
        hintLabel.isHidden = true
        ansewrButton.isHidden = true
        mistake.isHidden = true
    }

    @IBAction func ansewrButton(_ sender: Any) {
    // TextFieldから文字を取得
        textFieldString = nameTextField1.text!
    //もし、textfieldとrealmが一致したら
            // (1)Realmのインスタンスを生成する
            let realm1 = try! Realm()
            // (2)全データの取得
            let results = realm1.objects(personArray.self)
            // (3)取得データの確認
            print(results)
               
         if results[num].textFieldString == textFieldString{
               answerLabel.text = results[num].textFieldString
               self.image.image = UIImage(named: "mark_maru.png")
                image.isHidden = false
                textFieldString = ""
                nextquiz.isHidden = false
                hintLabel.isHidden = true
                hint1Button.isHidden = true
                hint2Button.isHidden = true
                ansewrButton.isHidden = true
                mistake.isHidden = true
            
                }else{
                    self.image.image = UIImage(named: "mark_batsu.png")
                    image.isHidden = false
                    hintLabel.isHidden = true
                    timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: {(t)in
                   self.image.isHidden = true
                    })
                    textFieldString = ""
          }
   }

    @IBAction func nextquiz(_ sender: Any) {
        // (1)Realmのインスタンスを生成する
            let realm1 = try! Realm()
        // (2)全データの取得
            let results = realm1.objects(personArray.self)
        // (3)取得データの確認
            print(results)
        // 取得件数の表示
        print("results\(results.count)")
        
        num = Int.random(in: 0...(results.count - 1))
       
        print("ランダムな数\(num)")
        
        pictureImageView1.image = UIImage(named: results[num].pictureurl)
        
        print("あああああ")
        print("画像\(results[num].pictureurl)")
        
        nameTextField1.text = ""
        hint1Button.isHidden = false
        hint2Button.isHidden = false
        ansewrButton.isHidden = false
        mistake.isHidden = false
        nextquiz.isHidden = true
        answerLabel.text = "この人誰だ？"
        answerLabel.isHidden = false
        hintLabel.isHidden = true
        image.isHidden = true
        }
}
