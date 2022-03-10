//
//  LastTravelViewController.swift
//  YolcuArkadasimApp
//
//  Created by Burak Emre gündeş on 4.03.2022.
//

import UIKit
import FirebaseFirestore

class LastTravelViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    
    @IBOutlet weak var tableView: UITableView!
    var travels=[Travel]()
    var documentIDForTravelDetails:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate=self
        tableView.dataSource=self
        
        DispatchQueue.main.async {
            self.getDataFromFirestore()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TravelTableViewCell
        cell.travelCarLabel.text="Araç = \(String(travels[indexPath.row].travelCar))"
        cell.travelFromLabel.text="Nereden = \(String(travels[indexPath.row].travelFrom))"
        cell.travelToLabel.text="Nereye = \(String(travels[indexPath.row].travelTo))"
        cell.travelTitleLabel.text=travels[indexPath.row].travelTitle
        return cell
    }
    func makeAlert(titleInput:String,messageInput:String){
        let alert=UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        documentIDForTravelDetails=travels[indexPath.row].travelID
        self.performSegue(withIdentifier: "toTravelDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTravelDetailVC"{
            let destination=segue.destination as! TravelDetailViewController
            destination.documentIDForTravel=documentIDForTravelDetails
        }
    }
    
    func getDataFromFirestore(){
        let db = Firestore.firestore()
        
        db.collection("Travels").order(by: "date",descending: true).addSnapshotListener { snapshot, error in
            if error != nil{
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Veriler Getirilemedi")
                print(error?.localizedDescription ?? "hata")
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.travels.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        
                        let travel = Travel()
                        travel.travelID=document.documentID
                        
                        if let travelTitle = document.get("travelTitle") as? String{
                            travel.travelTitle=travelTitle
                        }
                        if let travelCar = document.get("travelCar") as? String{
                            travel.travelCar=travelCar
                        }
                        if let travelTo=document.get("travelTo") as? String{
                            travel.travelTo=travelTo
                        }
                        if let travelFrom = document.get("travelFrom") as? String{
                            travel.travelFrom=travelFrom
                        }
                        if let travelLikes=document.get("likes") as? Int{
                            travel.travelLikes=travelLikes
                        }
                        if let postedBy=document.get("postedBy") as? String{
                            travel.postedBy=postedBy
                        }
                        if let travelAnnotationLatitude=document.get("annotationLatitude") as? Double{
                            travel.travelLatitude=travelAnnotationLatitude
                        }
                        if let travelAnnotationLongitude=document.get("annotationLongitude") as? Double{
                            travel.travelLongitude=travelAnnotationLongitude
                        }
                        
                        self.travels.append(travel)
                        self.tableView.reloadData()

                    }
                }
            }
        }
    }
    
    
    


}
