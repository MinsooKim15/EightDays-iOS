//
//  CurationCollectionViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/03.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit
import Firebase

class CurationCollectionViewCell: UICollectionViewCell {

    override class func awakeFromNib() {
        super.awakeFromNib()

    }
//    var smallPlace : SmallPlace?{
//        didSet{
//            
//        }
//    }
    func populate(smallPlace: SmallPlace){
        self.curationPlaceTitle.text = smallPlace.title_kor
        self.curationPlaceSubTitle.text = smallPlace.subtitle
        self.score.text = String(smallPlace.score) + "%"
        let placeholderImage = UIImage(named: "boracay")!
        let image_ = URL(string: smallPlace.img_url)!
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let islandRef = storageRef.child(smallPlace.img_url)
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
          if let error = error {
            print(error)
            // Uh-oh, an error occurred!
          } else {
            // Data for "images/island.jpg" is returned
            self.curationImageView.image = UIImage(data: data!)
          }
        }

//        curationImageView.af_setImage(withURL: image_, placeholderImage : placeholderImage)
        curationImageView.contentMode = .scaleAspectFill
//        curationImageView.clipsToBounds = true
        curationImageView.layer.masksToBounds = true

    }
    
    
    @IBOutlet weak var curationImageView: UIImageView!
    @IBOutlet weak var curationPlaceTitle: UILabel!
    @IBOutlet weak var curationPlaceSubTitle: UILabel!
    @IBOutlet weak var score: UILabel!
}

