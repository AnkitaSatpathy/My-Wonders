//
//  EditWonderViewController.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 13/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit
import CoreData

class EditWonderViewController: UIViewController , UITextFieldDelegate {
    @IBOutlet weak var saveConfLabel: UILabel!

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var latField: UITextField!
    @IBOutlet weak var longField: UITextField!
    @IBOutlet weak var notesField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.nameField.delegate = self
        self.latField.delegate = self
        self.longField.delegate = self
      
        
        saveConfLabel.alpha = 0
        nameField.text = editselectedName
        
        let latDbl: Double = editselectedLat as Double!
        let latStr: String = String(format: "%.6f", latDbl)
        
        let longDbl: Double = editselectedLong as Double!
        let longStr: String = String(format: "%.6f", longDbl)
        
        latField.text = latStr
        longField.text = longStr
        
        notesField.text = editselectedText
    }

    @IBAction func savePressed(_ sender: Any) {
        var wonders = [Wonders]()
        
        let appdel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context :  NSManagedObjectContext = appdel.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Wonders")
        fetchReq.predicate = NSPredicate(format: "wonderShow = %@", true as CVarArg)
        fetchReq.sortDescriptors = [NSSortDescriptor(key: "wonderName" ,  ascending:  true)]
        
        do{
            let results = try context.fetch(fetchReq) as! [Wonders]
            wonders = results
        }
        catch {
            print("error fetching results")
        }
       
        let wonder = wonders[editSelectedRow]
        
        wonder.wonderName = nameField.text!
        wonder.wonderLatitude = Double(latField.text!) ?? 0
        wonder.wonderLongitude = Double(longField.text!) ?? 0
        wonder.wonderNotes = notesField.text!
        
        do{
            try context.save()
            saveConfLabel.text = "saved"
            saveConfLabel.alpha = 1

        }
        catch{
            print("could not save \(error)")
            saveConfLabel.text = "error"
            saveConfLabel.alpha = 1
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPhoto"{
            
            let vc = segue.destination as! PhotosViewController
            vc.photosWondername = editselectedName
            vc.photosSourceType = "Photos"
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        latField.resignFirstResponder()
        longField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}
