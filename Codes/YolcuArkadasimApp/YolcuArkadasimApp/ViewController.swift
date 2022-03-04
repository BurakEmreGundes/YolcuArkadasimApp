//
//  ViewController.swift
//  YolcuArkadasimApp
//
//  Created by Burak Emre gündeş on 4.03.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Hatalı İşlem")
                }else{
                    self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                }
            }
        }else{
            self.makeAlert(title: "Hata", message: "Lütfen boş olan bırakmayınız")
        }
    }
    
    func makeAlert(title:String,message:String){
        let alert=UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton=UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated:true,completion: nil)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(title: "OK", message: error?.localizedDescription ?? "Hatalı İşlem")
                }else{
                    self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                }
            }
            
        }else{
            self.makeAlert(title: "Error", message: "Lütfen alanları boş bırakmayınız")
        }
    }
    


}

