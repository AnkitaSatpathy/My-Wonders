//
//  AddWonderViewController.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 13/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit
import CoreData

class AddWonderViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var saveConfLabel: UILabel!
    @IBOutlet weak var wondernameField: UITextField!
    @IBOutlet weak var latitudeTextfield: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    @IBOutlet weak var wondernameTextview: UITextView!
    
    var wondername: String = ""
    var wonderLatitude : Double = 0.0
    var wonderLongitude : Double = 0.0
    var wonderNotes :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveConfLabel.alpha = 0
        wondernameTextview.text = ""
        wondernameField.delegate = self
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func savePressed(_ sender: Any) {
        
        wondername = wondernameField.text!
        wonderLatitude = Double(latitudeTextfield.text!) ?? 0.0
        wonderLongitude = Double(longitudeField.text!) ?? 0.0
        wonderNotes = wondernameTextview.text!
        
        let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.persistentContainer.viewContext
        let newWonder = NSEntityDescription.insertNewObject(forEntityName: "Wonders", into: context) as! Wonders
        
        newWonder.wonderName = wondername
        newWonder.wonderLatitude = wonderLatitude
        newWonder.wonderLongitude = wonderLongitude
        newWonder.wonderNotes = wonderNotes
        newWonder.wonderShow = true
        newWonder.wonderType = "MY"
        
        do{
            try context.save()
            saveConfLabel.alpha = 1
            saveConfLabel.text = "Saved :" + wondername
        }
        catch {
            saveConfLabel.alpha = 1
            print("could not save \(error)")
            saveConfLabel.text = "error :" + wondername
        }
        
        // dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPhoto" {
            let vc = segue.destination as! PhotosViewController
            vc.photosWondername = wondername
            vc.photosSourceType = "Photos"
        }
        if segue.identifier == "photosSegue" {
            let vc = segue.destination as! PhotosViewController
            vc.photosWondername = wondername
            vc.photosSourceType = "Photos"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        wondernameField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}
