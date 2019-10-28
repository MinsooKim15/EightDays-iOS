//
//  MainTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/10/27.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    func populate(place : Place){
        title.text = place.title_eng
        score.text = String(place.score)
        cellDescription.text = place.description
        //TODO : String -> URL -> Image 이슈는 나중에 풀자 ㅜㅜ
//        let image_ = URL(from: place.img_url)
//        cellImageView.sd_setImage(with:image_)
    }
}
