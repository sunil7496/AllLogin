//
//  TextImageViewController.swift
//  Demo
//
//  Created by TrivialWorks on 16/12/19.
//  Copyright © 2019 TrivialWorks. All rights reserved.
//

import UIKit

class TextImageViewController: UIViewController {

    @IBOutlet weak var showImg: UIImageView!
    
    var name = "SunilKumar"
    override func viewDidLoad() {
        super.viewDidLoad()
        name = String(name.prefix(8))
        let img = textToImage(drawText: "\(name)\nApproved" as NSString, inImage: UIImage(named:"tempImage")!, atPoint: CGPoint(x: 10, y: 10))
        showImg.backgroundColor = UIColor.white.withAlphaComponent(0.5)
               showImg.image = img
        print("create Image :  \(img)")
    }

    func textToImage(drawText: NSString, inImage: UIImage, atPoint: CGPoint) -> UIImage{
        let textColor = UIColor.black
            let textFont = UIFont(name: "HelloMozza", size: 140)!
            let scale = UIScreen.main.scale
            let shadowColor = UIColor.red
            let bgColor = UIColor.magenta
            let strokeWidth = CGFloat(5)
            
            let myShadow = NSShadow()
            myShadow.shadowBlurRadius = 10
            myShadow.shadowOffset = CGSize(width: 10, height: 10)
            myShadow.shadowColor = UIColor.white
     
            UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
            let textFontAttributes = [
                NSAttributedString.Key.font: textFont,
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.shadow : myShadow,
//                NSAttributedString.Key.underlineColor : shadowColor,
                NSAttributedString.Key.strokeWidth : strokeWidth,
//                NSAttributedString.Key.backgroundColor : bgColor
                ] as [NSAttributedString.Key : Any]

            inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
            let rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)
            drawText.draw(in: rect, withAttributes: textFontAttributes)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
    @IBAction func backBtbnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
