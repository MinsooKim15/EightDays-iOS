//
//  CurationCollectionViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/03.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class CurationCollectionViewCell: UICollectionViewCell {
    override class func awakeFromNib() {
        super.awakeFromNib()

    }
    func populate(smallPlace: SmallPlace){
        self.curationPlaceTitle.text = smallPlace.title_kor
        self.curationPlaceSubTitle.text = smallPlace.subtitle
        self.score.text = String(smallPlace.score) + "%"
        let image_ = URL(string: smallPlace.img_url)!
        let placeholderImage = UIImage(named: "boracay")!
        curationImageView.af_setImage(withURL: image_, placeholderImage : placeholderImage)
        curationImageView.contentMode = .scaleAspectFill
//        curationImageView.clipsToBounds = true
        curationImageView.layer.masksToBounds = true
        
    }
    
    
    @IBOutlet weak var curationImageView: UIImageView!
    @IBOutlet weak var curationPlaceTitle: UILabel!
    @IBOutlet weak var curationPlaceSubTitle: UILabel!
    @IBOutlet weak var score: UILabel!
}

