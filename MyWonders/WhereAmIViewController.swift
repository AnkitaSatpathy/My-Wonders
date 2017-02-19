//
//  WhereAmIViewController.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 09/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class WhereAmIViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {

    @IBOutlet weak var wondernameField: UITextField!
    @IBOutlet weak var confLabel: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       confLabel.alpha = 0
       wondernameField.delegate = self
        
       manager = CLLocationManager()
       manager.delegate = self
       manager.desiredAccuracy = kCLLocationAccuracyBest
       manager.requestWhenInUseAuthorization()
       manager.startUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let myLocation :CLLocation = locations[0]
        
        let myLat : CLLocationDegrees = myLocation.coordinate.latitude
        let myLong : CLLocationDegrees = myLocation.coordinate.longitude
        
        let myDelLet : CLLocationDegrees = 0.01
        let myDelLong: CLLocationDegrees = 0.01
        
        let mySpan : MKCoordinateSpan = MKCoordinateSpanMake(myDelLet, myDelLong)
        let myCurLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLat, myLong)
        let myReg: MKCoordinateRegion = MKCoordinateRegionMake(myCurLocation, mySpan)
        
        mapview.setRegion(myReg, animated: true)
        
        manager.startUpdatingLocation()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = myCurLocation
        annotation.title = "You are here!"
        mapview.addAnnotation(annotation)
        
        latLabel.text = "\(myLat)"
        longLabel.text = "\(myLong)"
        
        CLGeocoder().reverseGeocodeLocation(myLocation, completionHandler: {(placemarks, error) -> Void in
            if (error != nil) {
                print("Error \(error)")
            }
            else {
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark!)
                
                var subThoroughfare = ""
                var thoroughfare = ""
                var subLocality = ""
                var subAdminArea = ""
                var postalCode = ""
                var country = ""
                
                if(p.subThoroughfare != nil){
                    subThoroughfare = p.subThoroughfare!
                }
                
                if(p.thoroughfare != nil){
                    thoroughfare = p.thoroughfare!
                }
                
                if(p.subLocality != nil){
                    subLocality = p.subLocality!
                }
                
                if(p.subAdministrativeArea != nil){
                    subAdminArea = p.subAdministrativeArea!
                }
                
                if(p.postalCode != nil){
                    postalCode = p.postalCode!
                }
                
                if(p.country != nil){
                    country = p.country!
                }
                self.addressLabel.text = "\(subThoroughfare) \(thoroughfare) \n \(subLocality) \(subAdminArea)\n \(postalCode) \(country)"
            }
            
            }
        )
        }
    
    
    @IBAction func findmePressed(_ sender: Any) {
        
        manager.requestWhenInUseAuthorization()
        mapview.removeAnnotations(mapview.annotations)
        manager.startUpdatingLocation()
    }
    
    @IBAction func savePressed(_ sender: Any) {
        
        //wonderName = wondernameField.text!
        if wondernameField.text!.isEmpty {
            showAlert(alertTitle: "Invalid Wonder Name", alertMsg: "Wonder name can not be blank")
        }
        else{
            
        let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.persistentContainer.viewContext
        let newWonder = NSEntityDescription.insertNewObject(forEntityName: "Wonders", into: context) as! Wonders
        
        newWonder.wonderName = wondernameField.text!

        newWonder.wonderLatitude = Double(latLabel.text!) ?? 0
        newWonder.wonderLongitude = Double(longLabel.text!) ?? 0
        newWonder.wonderNotes = addressLabel.text!
        newWonder.wonderShow = true
        newWonder.wonderType = "MY"
        
        do{
            try context.save()
            confLabel.alpha = 1
            confLabel.text = "Saved "
        }
        catch {
            confLabel.alpha = 1
            print("could not save \(error)")
            confLabel.text = "error "
        }
    }
        
}
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        wondernameField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showAlert(alertTitle: String , alertMsg: String){
        
        let alert = UIAlertController(title: alertTitle, message: "\(alertMsg)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.dismiss(animated: true, completion: nil)
        self.present(alert, animated: true, completion: nil)
        }
    }
    

