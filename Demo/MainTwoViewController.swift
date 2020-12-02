//
//  MainTwoViewController.swift
//  Demo
//
//  Created by Vu Vuong on 11/26/20.
//  Copyright © 2020 jerryvuong. All rights reserved.
//

import UIKit
import FMDB

struct User {
  var name: String?
  var birthday: String?
  
  init(data: [String: Any]) {
    name = data["name"] as? String
    birthday = data["birthday"] as? String
  }
  
  init() {
    
  }
}

class MainTwoViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  private var listUser: [User] = []
  
  override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        inserUser()
  }
  
  func makeData() {
    
    let data = [["name": "TOm", "birthday": "21/02/1999"],
                ["name": "Jerry", "birthday": "14/08/1992"],
                ["name": "Ducky", "birthday": "26/02/1992"],
                ["name": "Micky", "birthday": "21/02/1999"]]
    listUser = data.map({ (data) -> User in
      return User(data: data)
    })
    tableView.reloadData()
  }
  
  func inserUser() {
    let name = "User123"
    let birthday = "22/02/2002"
    let db = FMDatabase.init(path: getDatabaseFolderPath())
    db.open()
    do {
      if db.open() {
        let result = try db.executeUpdate("INSERT INTO user VALUES (?, ?, ?)", withArgumentsIn: [3, name, birthday])
        if result {
          connectSQL()
        }
      }
      
    }
  }
  
  func connectSQL() {
    var listUser: [User] = []
    let db = FMDatabase.init(path: getDatabaseFolderPath())
    db.open()
    
    do {
      let user = try db.executeQuery("SElECT * FROM user", values: nil)
      while user.next() {
        
        let name = user.string(forColumn: "name")
        let birthday = user.string(forColumn: "birthday")
        var userModel = User()
        userModel.name = name
        userModel.birthday = birthday
        listUser.append(userModel)
      }
    } catch {
      
    }
    
    print(listUser)
    self.listUser = listUser
    tableView.reloadData()
  }
  
  func getDatabaseFolderPath() -> String {
      let kDatabaseName = "user"
      let kDatabaseExtension = "db"
      let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true)[0]
      return documentPath + "/" + kDatabaseName + "." + kDatabaseExtension
  }

}

extension MainTwoViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listUser.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell {
      let user = listUser[indexPath.row]
      cell.fillData(user: user)
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
}
