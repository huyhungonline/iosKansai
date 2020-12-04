//
//  DetailViewController.swift
//  Demo
//
//  Created by Vu Vuong on 12/4/20.
//  Copyright © 2020 jerryvuong. All rights reserved.
//

import UIKit
import Alamofire
import NotificationBannerSwift
import AVFoundation
import AVKit

class DetailViewController: UIViewController {
    
  @IBOutlet weak var videoContainer: UIView!
  var userModel: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = userModel?.name ?? ""
    }
    
  func passData(user: User) {
    userModel = user
  }
  
  func getUserFromAPI() {
    Alamofire.request("https://kansaibook.com/api/list-user", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
      if let data = response.value as? [[String: Any]] {
        BannerUtil.shared.showBanner()
      }
    }
  }
  
  func loadVideo() {
    let player = AVPlayer(url: URL(string: "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4")!)
    let videoPlayerController = AVPlayerViewController()
    videoPlayerController.player = player
    navigationController?.present(videoPlayerController, animated: true, completion: nil)
  }
  
  @IBAction func fetchData(_ sender: Any) {
      
      let vc = ModalViewController()
      vc.modalTransitionStyle = .crossDissolve
      vc.modalPresentationStyle = .overFullScreen
      present(vc, animated: true, completion: nil)
  }
}
