//
//  AppDelegate.swift
//  Demo
//
//  Created by Vu Vuong on 11/26/20.
//  Copyright © 2020 jerryvuong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    openDataBaseFromSQL()
    setupRootView()
    return true
  }
  
  func setupRootView() {
    let rootVC = LoginViewController()
    
    window = UIWindow.init(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: rootVC)
    window?.makeKeyAndVisible()
  }
  
  func getDatabaseFolderPath() -> String {
      let kDatabaseName = "user"
      let kDatabaseExtension = "db"
      let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true)[0]
      return documentPath + "/" + kDatabaseName + "." + kDatabaseExtension
  }
  
  // 1.Copy database
  func openDataBaseFromSQL() {
      let fileManager = FileManager.default

      let kDatabaseName = "user"
      let kDatabaseExtension = "db"
      let bundlePath = Bundle.main.path(forResource: kDatabaseName, ofType: kDatabaseExtension)
      // 2. Get document path
      let documentPath = self.getDatabaseFolderPath()
      
      // 3. Check if file exist
      if !fileManager.fileExists(atPath: documentPath)
      {
          // 4. copy from bundlePath to documentPath
          do{
              //print(String(describing: bundlePath) + String(documentPath))
              try fileManager.copyItem(atPath: bundlePath!, toPath: documentPath)
          } catch {
              print(error)
          }
      }
  }
}

