//
//  WondersViewController.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 09/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit
import CoreData


var selectedName : String = ""
var selectedLat : Double = 0.0
var selectedLong: Double = 0.0
var selectedText : String = ""

var editselectedName : String = ""
var editselectedLat : Double = 0.0
var editselectedLong: Double = 0.0
var editselectedText : String = ""

var editSelectedRow: Int = 0

class WondersViewController: UITableViewController {
    
    var wonders = [Wonders]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {
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
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wonders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wonderCell", for: indexPath)

       let wonder = wonders[indexPath.row]
        cell.textLabel!.text = wonder.wonderName
        
        let latDbl: Double = wonder.wonderLatitude as Double!
        let latStr: String = String(format: "%.6f", latDbl)
        
        let longDbl: Double = wonder.wonderLongitude as Double!
        let longStr: String = String(format: "%.6f", longDbl)
        
        cell.detailTextLabel?.text = "Lat:" + latStr + "  Long:" + longStr

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wonder = wonders[indexPath.row]
        
        selectedName = wonder.wonderName!
        selectedLat = wonder.wonderLatitude as Double
        selectedLong = wonder.wonderLongitude as Double
        selectedText = wonder.wonderNotes!
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let wonder = wonders[indexPath.row]
        editSelectedRow = indexPath.row
        editselectedName = wonder.wonderName!
        editselectedLat = wonder.wonderLatitude as Double
        editselectedLong = wonder.wonderLongitude as Double
        editselectedText = wonder.wonderNotes!
    }
    
    //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let appdel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context :  NSManagedObjectContext = appdel.persistentContainer.viewContext
           context.delete(wonders[indexPath.row] as Wonders)
            do{
                try context.save()
            }
            catch{
                print("could not save \(error)")
            }
            wonders.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
