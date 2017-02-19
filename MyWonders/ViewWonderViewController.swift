//
//  ViewWonderViewController.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 13/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import CoreData

class ViewWonderViewController: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var wonderNameLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var photoLabel: UIButton!
    
    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        
        super.viewDidLoad()

        wonderNameLabel.text = selectedName
        let latDbl: Double = selectedLat as Double!
        let latStr: String = String(format: "%.6f", latDbl)
        let longDbl: Double = selectedLong as Double!
        let longStr: String = String(format: "%.6f", longDbl)
        
        latLabel.text = latStr
        longLabel.text = longStr
        
        textview.text = selectedText
        
        
        let lat: CLLocationDegrees = selectedLat
        let long: CLLocationDegrees = selectedLong
        
        let delLat:CLLocationDegrees = 0.01
        let delLong:CLLocationDegrees = 0.01
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(delLat, delLong)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        
        let region : 	MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapview.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = selectedName
        mapview.addAnnotation(annotation)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        
//        let appdel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context :  NSManagedObjectContext = appdel.persistentContainer.viewContext
//        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
//        fetchReq.predicate = NSPredicate(format: "wonderName = %@", selectedName)
//        
//        var photos = [Photo]()
//        
//        
//        do{
//            let results = try context.fetch(fetchReq) as! [Photo]
//            photos = results
//        }
//        catch {
//            print("error fetching results")
//        }
//        
//        
//        }
//
//    }
}


