//
//  SuccessViewController.swift
//  Demo
//
//  Created by TrivialWorks on 30/12/19.
//  Copyright © 2019 TrivialWorks. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    //MARK:- Outlets & variables
    @IBOutlet weak var resultTypeLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    var userEmail = ""
    var userName = ""
    var socialType = ""
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLbl.text = userEmail
        usernameLbl.text = userName
        resultTypeLbl.text = "---Result (\(socialType))---"
    }

    //MARK:- Button Action
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
