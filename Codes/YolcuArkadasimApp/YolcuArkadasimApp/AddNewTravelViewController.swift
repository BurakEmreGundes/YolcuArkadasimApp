//
//  AddNewTravelViewController.swift
//  YolcuArkadasimApp
//
//  Created by Burak Emre gündeş on 8.03.2022.
//

import UIKit
import MapKit
import FirebaseAuth
import Firebase
import CoreLocation

class AddNewTravelViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var carNameTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    
    var locationManager=CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate=self
        locationManager.delegate=self
        
        
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        //hideKeyboard Recognizer
        let keyboardRecognizer=UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(keyboardRecognizer)
        
        //mapView Recognizer
        let mapViewRecognizer=UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(mapViewRecognizer:)))
        mapViewRecognizer.minimumPressDuration=3
        mapView.addGestureRecognizer(mapViewRecognizer)
    }
    
    @objc func chooseLocation(mapViewRecognizer:UILongPressGestureRecognizer){
        if mapViewRecognizer.state == .began{
            let touchedPoint=mapViewRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint,toCoordinateFrom:self.mapView)
          
            let annotation = MKPointAnnotation()
            annotation.coordinate=touchedCoordinates
            
            if titleTextField.text != "" {
                annotation.title=titleTextField.text
                self.mapView.addAnnotation(annotation)
            }
           
        }
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            // Enlem Boylam veriyoruz
            let location = CLLocationCoordinate2D(latitude:locations[0].coordinate.latitude,longitude: locations[0].coordinate.longitude)
            // Zomlanacak olan spani oluşturuyoruz
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
    }
    

}
 
