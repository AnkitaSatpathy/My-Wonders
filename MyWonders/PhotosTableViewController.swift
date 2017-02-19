//
//  PhotosTableViewController.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 15/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit
import  CoreData

class PhotosTableViewController: UITableViewController {

    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        let appdel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context :  NSManagedObjectContext = appdel.persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath)
            //as! PhotoCell

        // Configure the cell...
        let photo = photos[indexPath.row]
        
        if let nameLabel = cell.viewWithTag(101) as? UILabel {
            nameLabel.text  = photo.wonderName
            
        }
        if let imageView = cell.viewWithTag(100) as? UIImageView {
            imageView.image = UIImage(data: photo.wonderPhoto as! Data ) 
        }
        
        
        // cell.nameLabel.text = photo.wonderName
         //cell.imageview.image = UIImage(data: photo.wonderPhoto as! Data)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    

}
