//
//  TravelDetailViewController.swift
//  YolcuArkadasimApp
//
//  Created by Burak Emre gündeş on 9.03.2022.
//

import UIKit
import FirebaseFirestore

class TravelDetailViewController: UIViewController {

    var documentIDForTravel:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getTravelDetail()
    }
    
    func getTravelDetail(){
        let db = Firestore.firestore()
        
    
        if let documentID = documentIDForTravel{
            let docRef = db.collection("Travels").document(documentID)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    
                    print("Document data: \(dataDescription)")
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
