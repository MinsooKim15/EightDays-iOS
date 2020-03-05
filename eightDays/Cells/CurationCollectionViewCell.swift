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
    var smallPlace : SmallPlace?{
        didSet{
            self.curationPlaceTitle.text = smallPlace?.title_kor
            self.curationPlaceSubTitle.text = smallPlace?.subtitle
            if let scoreInt = smallPlace?.score{
               self.score.text = String(scoreInt) + "%"
            }else{
                self.score.text = "0%"
            }
            // TODO : Place Holder 기능 추가하기
            // let placeholderImage = UIImage(named: "boracay")!
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let islandRef = storageRef.child(smallPlace?.img_url ?? "a.jpg")
//            self.curationImageView.place
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
                curationImageView.contentMode = .scaleAspectFill
            //        curationImageView.clipsToBounds = true
                    curationImageView.layer.masksToBounds = true
        }
    }
//    func populate(smallPlace: SmallPlace){
//        
//    }
    
    
    @IBOutlet weak var curationImageView: UIImageView!
    @IBOutlet weak var curationPlaceTitle: UILabel!
    @IBOutlet weak var curationPlaceSubTitle: UILabel!
    @IBOutlet weak var score: UILabel!
}

