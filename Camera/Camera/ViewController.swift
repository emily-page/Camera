//
//  ViewController.swift
//  Camera
//
//  Created by ios6 on 2/22/17.
//  Copyright © 2017 ios6. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIVideoEditorControllerDelegate
{
    let picker = UIImagePickerController()
    var photos: [UIImage] = []
    var count: Int = 0
    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
        count = 0
        picker.allowsEditing = true
        photos.append(UIImage(named: "water")!)
        myImageView.image = photos[0]
    }
    
    func animateImage()
    {
        if photos.count > 0
        {
            if count < photos.count - 1
            {
                count += 1
            }
            else
            {
                count = 0
            }
        }
        myImageView.image = photos[self.count]
    }
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem)
    {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:
            { (action) in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
            }))
        present(sheet, animated: true, completion: nil)
    }
    
    @IBAction func shootPhoto(_ sender: UIBarButtonItem)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        }
        else
        {
            noCamera()
        }
//        if UIVideoEditorController.canEditVideoAtPath("Video")
//        {
//            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum("Library")
//        }
    }
    
    func noCamera()
    {
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        picker.dismiss(animated: true)
        {
            self.photos.append(info[UIImagePickerControllerEditedImage] as! UIImage)
            //self.myImageView.image = self.photos[self.count - 1]
        }
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImageView.contentMode = UIViewContentMode.scaleAspectFit
        myImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
