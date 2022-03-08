//
//  SettingsTableViewCell.swift
//  YolcuArkadasimApp
//
//  Created by Burak Emre gündeş on 8.03.2022.
//

import UIKit
import FirebaseAuth

class SettingsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addTravelButtonClicked(_ sender: Any) {
        
    }
    @IBAction func listSelfTravelsButtonClicked(_ sender: Any) {
    }
    @IBAction func profileButtonClicked(_ sender: Any) {
    }
    @IBAction func logoutButtonClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            
        }catch{
            print("hatalı işlem")
        }
    }
    
}
