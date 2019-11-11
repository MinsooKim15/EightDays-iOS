//
//  PlaceTextOnlyTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/10.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class PlaceTextOnlyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var textOnlyTitle: UILabel!
    @IBOutlet weak var textOnlyDescription: UILabel!
    func populate (){
        //TODO: 주입할 Model만 정해지면 여기 구현하기
    }
}
