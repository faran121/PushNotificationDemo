//
//  NotificationViewController.swift
//  VideoContentExtension
//
//  Created by Maliks on 10/09/2023.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import AVKit

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        preferredContentSize.height = 300
        
        let content = notification.request.content
        if let aps = content.userInfo["aps"] as? [String: AnyHashable],
           let videoURLString = aps["video_url"] as? String {
            if let url = URL(string: videoURLString) {
                playVideo(url: url)
            }
        }
    }
    
    private func playVideo(url: URL) {
        let playerViewController = AVPlayerViewController()
        let player = AVPlayer()
        
        playerViewController.player = player
        playerViewController.view.frame = self.videoView.bounds
        
        self.videoView.addSubview(playerViewController.view)
        addChild(playerViewController)
        playerViewController.didMove(toParent: self)
        
        player.play()
    }

}
