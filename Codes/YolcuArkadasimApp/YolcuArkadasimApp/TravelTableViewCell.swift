//
//  TravelTableViewCell.swift
//  YolcuArkadasimApp
//
//  Created by Burak Emre gündeş on 8.03.2022.
//

import UIKit

class TravelTableViewCell: UITableViewCell {

    @IBOutlet weak var travelTitleLabel: UILabel!
    @IBOutlet weak var travelCarLabel: UILabel!
    @IBOutlet weak var travelFromLabel: UILabel!
    @IBOutlet weak var travelToLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func seeDetailsClicked(_ sender: Any) {
        print("Detaylar Gösterilecek")
    }
    
}
