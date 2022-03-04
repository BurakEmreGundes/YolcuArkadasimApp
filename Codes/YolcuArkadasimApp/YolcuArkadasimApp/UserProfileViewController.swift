//
//  UserProfileViewController.swift
//  YolcuArkadasimApp
//
//  Created by Burak Emre gündeş on 4.03.2022.
//

import UIKit
import FirebaseAuth

class UserProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewControllerAfterLogout", sender: nil)
        }catch{
            print("hatalı işlem")
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
