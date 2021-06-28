//
//  CameraViewController.swift
//  Demo
//
//  Created by TrivialWorks on 31/12/19.
//  Copyright © 2019 TrivialWorks. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var showImageView: UIImageView!
    var imagePicker = UIImagePickerController()
    var itemImage:UIImage?
    var galleryPic = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showImageView.layer.cornerRadius = showImageView.frame.height/2
        imagePicker.delegate = self
    }

    @IBAction func updateBtnAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let settingsActionSheet: UIAlertController = UIAlertController(title:"Option for choose image", message:nil, preferredStyle:UIAlertController.Style.actionSheet)
        settingsActionSheet.addAction(UIAlertAction(title:"Camera", style:UIAlertAction.Style.default, handler:{ action in
            self.takePictureThroughCamera()
        }))
        settingsActionSheet.addAction(UIAlertAction(title:"Photo Gallery", style:UIAlertAction.Style.default, handler:{ action in
            self.selectPictureThroughPhotoGallery()
        }))
        settingsActionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertAction.Style.cancel, handler:nil))
        if UIDevice.current.userInterfaceIdiom == .phone{
            self.present(settingsActionSheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtbnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Take image through Camera
    func takePictureThroughCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        }else {
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    //MARK:- Select image from photo Gallery
    func selectPictureThroughPhotoGallery()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil{
            itemImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
            galleryPic = true
            showImageView.image = itemImage
        }
        picker.dismiss(animated: true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }

}
