//
//  LoginViewController.swift
//  Demo
//
//  Created by Vu Vuong on 11/26/20.
//  Copyright © 2020 jerryvuong. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Toast_Swift

class LoginViewController: UIViewController {
    
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var usernameTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        print("Show Login in viewdidload")
    }
  
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      print("Show Login in viewWillAppear")
    }
      
    func setupView() {
      loginButton.layer.cornerRadius = 10
    }
  
    func login() {
      SVProgressHUD.show()
      let username = usernameTF.text ?? ""
      let password = passwordTF.text ?? ""
      print("Username:", username)
      print("Password:", password)
      let bodyParam = ["user_name": username, "password": password]
      Alamofire.request("https://kansaibook.com/api/login", method: .post, parameters: bodyParam, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        SVProgressHUD.dismiss()
        if let body = response.value as? [String: Any] {
          if let statusCode = body["status_code"] as? Int, statusCode == 200 {
            self.view.makeToast("Login thanh cong!")
            let vc = MainTwoViewController()
            self.navigationController?.pushViewController(vc, animated: true)
          } else {
            print("Login that bai")
          }
        }
      }
    }
  
  @IBAction func loginTap(_ sender: Any) {
    login()
  }
}
