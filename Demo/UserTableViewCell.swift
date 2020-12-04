//
//  UserTableViewCell.swift
//  Demo
//
//  Created by Vu Vuong on 12/2/20.
//  Copyright © 2020 jerryvuong. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {

  @IBOutlet weak var avatarImgView: UIImageView!
  @IBOutlet weak var birthdayLbl: UILabel!
  @IBOutlet weak var usernameLbl: UILabel!
  @IBOutlet weak var avatar: UIView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = 5
  }
  
  
  func fillData(user: User) {
    usernameLbl.text = user.name
    birthdayLbl.text = user.age
    avatarImgView.sd_setImage(with: URL(string: user.avatar ?? ""), placeholderImage: nil, options: [.continueInBackground], context: nil)
  }
}
