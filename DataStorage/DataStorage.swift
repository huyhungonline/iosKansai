//
//  DataStorage.swift
//  Demo
//
//  Created by Vu Vuong on 12/4/20.
//  Copyright © 2020 jerryvuong. All rights reserved.
//

import Foundation
import NotificationBannerSwift


class BannerUtil {
  static let shared = BannerUtil()
  
  func showBanner() {
    let banner = NotificationBanner(title: "Show banner !!!!", subtitle: "show banner from datastorage", leftView: nil, rightView: nil, style: .danger, colors: nil)
    banner.show()
  }
}
