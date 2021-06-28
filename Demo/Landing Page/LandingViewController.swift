//
//  LandingViewController.swift
//  Demo
//
//  Created by TrivialWorks on 31/12/19.
//  Copyright © 2019 TrivialWorks. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let dataArray = ["login","camera","video player","text to Img","admob Banner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "labelTableViewCell", bundle: nil), forCellReuseIdentifier: "labelTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelTableViewCell", for: indexPath) as! labelTableViewCell
        cell.namelbl.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = AppleSignInViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1{
            let vc = CameraViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2{
            let vc = VideoPlayerViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 3{
            let vc = TextImageViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 4{
            let vc = AdmobViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
    }
}
