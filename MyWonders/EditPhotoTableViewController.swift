//
//  EditPhotoTableViewController.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 16/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit
import CoreData

let appdel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
let context :  NSManagedObjectContext = appdel.persistentContainer.viewContext
let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")

class EditPhotoTableViewController: UITableViewController {

    var photos = [Photo]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchReq.predicate = NSPredicate(format: "wonderName = %@", selectedName)
        
        
        do{
            let results = try context.fetch(fetchReq) as! [Photo]
            photos = results
        }
        catch {
            print("error fetching results")
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let photo = photos[indexPath.row]
        
        
        if let imageView = cell.viewWithTag(100) as? UIImageView {
            imageView.image = UIImage(data: photo.wonderPhoto as! Data )
        }

        return cell
    }
    

    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            context.delete(photos[indexPath.row] as Photo)
            let error : NSError!
            
            do{
            try context.save()
            }
            
            catch  let err as NSError{
                error = err
                print("error \(error)" )
                }
            
            photos.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }  
    }
    

   

}
