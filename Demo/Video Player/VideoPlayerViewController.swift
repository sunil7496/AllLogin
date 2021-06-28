//
//  VideoPlayerViewController.swift
//  Unlisted
//
//  Created by TrivialWorks on 06/11/19.
//  Copyright © 2019 trivialworks. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {

    //MARK:- Outlets and Variables
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    let smallVideoPlayerViewController = AVPlayerViewController()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ClassName ============== >>>>> \(String(describing: self))")
        bottomView.backgroundColor = UIColor.lightGray
        initializeVideoPlayerWithVideo()
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- AVPayer
    func initializeVideoPlayerWithVideo() {
        let videoUrl = Bundle.main.url(forResource: "small", withExtension: "mp4")
        smallVideoPlayerViewController.showsPlaybackControls = true
        smallVideoPlayerViewController.player = AVPlayer(url: videoUrl! as URL)
        videoPlayerView.addSubview(smallVideoPlayerViewController.view)
        smallVideoPlayerViewController.view.frame = videoPlayerView.bounds
        
        smallVideoPlayerViewController.player?.play()
    }
    
    @IBAction func fullScreenButton(_ sender: UIButton) {
//                let videoUrl = NSURL(string: "https://www.demonuts.com/Demonuts/smallvideo.mp4")
        let videoUrl = Bundle.main.url(forResource: "small", withExtension: "mp4")
        let player = AVPlayer(url: videoUrl! as URL)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    //MARK:- Button Action
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

