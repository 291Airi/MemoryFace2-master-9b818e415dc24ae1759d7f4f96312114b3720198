//
//  ChoiceViewController.swift
//  MemoryFace2
//
//  Created by 福井　愛梨 on 2020/07/16.
//  Copyright © 2020 福井　愛梨. All rights reserved.
//

import UIKit
import RealmSwift

class ChoiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var todoItem: Results<personArray>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // 永続化されているデータを取りだす
        let persons = List<personArray>()
        
        do{
            let realm = try Realm()
            todoItem = realm.objects(personArray.self)
            
            //tableView.reloadData()
            super.viewDidLoad()
        }catch{

        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return todoItem.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
             
            
              let object = todoItem[indexPath.row]

              cell.textLabel?.text = object.textFieldString
              return cell
 
          }
    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
        
        // TableViewのCellの削除を行った際に、Realmに保存したデータを削除する
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            if(editingStyle == UITableViewCell.EditingStyle.delete) {
                do{
                    let realm = try Realm()
                    try realm.write {
                        realm.delete(self.todoItem[indexPath.row])
                    }
                    tableView.deleteRows(at: [(indexPath as IndexPath)], with: UITableView.RowAnimation.fade)
                }catch{
                }
                tableView.reloadData()
            }
            }
    
        }

