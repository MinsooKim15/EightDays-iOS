//
//  SettingTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/10.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func populate(setting:Setting){
        self.settingTitle.text = setting.title
        if setting.havePage{
            self.moveButton.isHidden = false
            self.versionDescription.isHidden = true
        }else{
            self.moveButton.isHidden = true
            self.versionDescription.isHidden = false
            self.versionDescription.text =  (setting.currentVersion ?? "0") + "/" + (setting.recentVersion ?? "0")
        }
    }
    
    @IBOutlet weak var versionDescription: UILabel!
    
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var settingTitle: UILabel!
    @IBAction func buttonClicked(_ sender: Any) {
    }
}
