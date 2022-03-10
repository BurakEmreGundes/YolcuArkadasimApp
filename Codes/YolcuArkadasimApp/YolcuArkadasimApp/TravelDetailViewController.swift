//
//  TravelDetailViewController.swift
//  YolcuArkadasimApp
//
//  Created by Burak Emre gündeş on 9.03.2022.
//

import UIKit
import FirebaseFirestore
import MapKit
import CoreLocation

class TravelDetailViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{

    var documentIDForTravel:String!
    @IBOutlet weak var UserEmailLabel: UILabel!
    @IBOutlet weak var travelFromLavel: UILabel!
    @IBOutlet weak var travelToLabel: UILabel!
    @IBOutlet weak var carLabel: UILabel!
    var annotationLatitude: Double?
    var annotationLogitude: Double?
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager.delegate=self
        mapView.delegate=self
        
        
        getTravelDetail()
    }
    
    func getTravelDetail(){
        let db = Firestore.firestore()
        
    
        if let documentID = documentIDForTravel{
            let docRef = db.collection("Travels").document(documentID)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let dataDescription = document.data(){
                        
                        if let travelCar = dataDescription["travelCar"] as? String{
                            self.carLabel.text="Araç = \(travelCar)"
                        }
                        if let travelFrom = dataDescription["travelFrom"] as? String{
                            self.travelFromLavel.text="Nereden = \(travelFrom)"
                        }
                        if let travelTo = dataDescription["travelTo"] as? String{
                            self.travelToLabel.text="Nereye = \(travelTo)"
                        }
                        
                        let annotation = MKPointAnnotation()
                        
                        
                        if let latitude = dataDescription["travelLatitude"] as? Double{
                            self.annotationLatitude=latitude
                        }
                        if let longitude = dataDescription["travelLongitude"] as? Double{
                            self.annotationLogitude=longitude
                        }
                        
                        let coordinate=CLLocationCoordinate2D(latitude: self.annotationLatitude!, longitude: self.annotationLogitude!)
                        annotation.coordinate=coordinate
                        self.mapView.addAnnotation(annotation)
                        self.locationManager.stopUpdatingLocation()
                        
                        let span=MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        let region=MKCoordinateRegion(center: coordinate, span: span)
                        self.mapView.setRegion(region, animated: true)
  
                    }
                    
                    
                } else {
                    print("Document does not exist")
                }
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
