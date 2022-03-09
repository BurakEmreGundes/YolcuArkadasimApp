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

    
    var chosenLatitude: Double!
    var chosenLongitude: Double!
    
    var chosenAnnotations = [MKAnnotation]()
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
            chosenLatitude=touchedCoordinates.latitude
            chosenLongitude=touchedCoordinates.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate=touchedCoordinates
            
            chosenAnnotations.append(annotation)
            
            if titleTextField.text != "" && carNameTextField.text != "" && fromTextField.text != "" && toTextField.text != "" {
                annotation.title=titleTextField.text
                self.mapView.addAnnotation(annotation)
               
            }
           
        }
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func makeAlert(titleInput:String,messageInput:String){
        let alert=UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        if titleTextField.text == "" || carNameTextField.text=="" || toTextField.text == "" || fromTextField.text == "" {
            makeAlert(titleInput: "Error", messageInput: "Lütfen alanların hepsini doldurunuz.")
        }else if chosenLatitude == nil || chosenLongitude == nil{
            makeAlert(titleInput: "Error", messageInput: "Lütfen haritadan yolculuğa başlayacağınız alanı işaretleyiniz")
        }else{
            let fireStoreDatabase = Firestore.firestore()
            
            var fireStoreReferance: DocumentReference?=nil
            
            let fireStorePost=["travelTitle":titleTextField.text!,"postedBy":Auth.auth().currentUser!.email!,"travelCar":carNameTextField.text!,"travelTo":toTextField.text!,"travelFrom":fromTextField.text!, "date":FieldValue.serverTimestamp(),"travelLatitude":chosenLatitude!,"travelLongitude":chosenLongitude!,"likes":0] as [String : Any]
            
            fireStoreReferance=fireStoreDatabase.collection("Travels").addDocument(data: fireStorePost,completion: { (error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.carNameTextField.text=""
                    self.fromTextField.text=""
                    self.toTextField.text=""
                    self.titleTextField.text=""
                    self.chosenLatitude=nil
                    self.chosenLongitude=nil
                    self.mapView.removeAnnotations(self.chosenAnnotations)
                    self.tabBarController?.selectedIndex=0
                }
            })
            
            
        }
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
 
