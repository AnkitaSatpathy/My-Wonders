//
//  PhotosViewController.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 14/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit
import  CoreData
import AVFoundation
import MobileCoreServices

class PhotosViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate
{
    @IBOutlet weak var addImageLabel: UILabel!
    @IBOutlet weak var imageSwitchLabel: UISwitch!
    @IBOutlet weak var confLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    var photosWondername = ""
    var photosSourceType = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        addImageLabel.text = photosWondername
        imageSwitchLabel.alpha = 0
        confLabel.alpha = 0
        
        accessCamOrPhotolibrary()
    }

    @IBAction func plusClicked(_ sender: Any) {
        accessCamOrPhotolibrary()
    }
    
    @IBAction func switchedOn(_ sender: Any) {
        
        addImageToCoredata()
        
    }
    
    func addImageToCoredata(){
        
        let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        if imageSwitchLabel.isOn {
            
            let imageData = UIImageJPEGRepresentation(imageview.image!, 1)
            let newPhoto = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as! Photo
            
            newPhoto.wonderName = photosWondername
            newPhoto.wonderPhoto = imageData as NSData?
            
            do{
                try context.save()
                confLabel.alpha = 1
                confLabel.text = "Saved :" + photosWondername
            }
            catch {
                confLabel.alpha = 1
                print("could not save \(error)")
                confLabel.text = "error :" + photosWondername
            }
        }
    }
    
    func accessCamOrPhotolibrary(){
        let picker = UIImagePickerController()
        picker.delegate = self
        
        if photosSourceType == "Photos" {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary ){
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                picker.mediaTypes = [kUTTypeImage as NSString as String]
                present(picker, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        let mediatype = info[UIImagePickerControllerMediaType] as! NSString
        if mediatype.isEqual(to: kUTTypeImage as NSString as String){
            let  image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            imageview.image = image
            imageview.contentMode = .scaleAspectFit
            
            imageSwitchLabel.alpha = 1
            confLabel.alpha = 0
            imageSwitchLabel.setOn(true, animated: true)
            // addImageLabel.alpha = 0
            addImageToCoredata()

           }
        }
    }


