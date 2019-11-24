//
//  Weather.swift
//  eightDays
//
//  Created by minsoo kim on 2019/10/27.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import Foundation
import Firebase

struct Weather{
    var title : String
    var description : String
    var averageTemp : Float
    var raindays : Float
    var seoulTemp : Float
    var dictionary: [String: Any]{
        return [
            "title" : title,
            "description" : description,
            "averageTemp" : averageTemp,
            "raindays" : raindays,
            "seoulTemp" : seoulTemp
        ]
    }
}

extension Weather {
    init?(dictionary: [String:Any]){
            guard let title =  dictionary["title"] as? String,
        let description =  dictionary["description"] as? String,
        let averageTemp =  dictionary["averageTemp"] as? Float,
        let raindays =  dictionary["raindays"] as? Float,
        let seoulTemp =  dictionary["seoulTemp"] as? Float
        else {print("Weather 유입은 되었는데, Init 실패")
                    return nil}


//            self.title_kor = title_kor
//            self.title_eng = title_eng
//            self.subtitle = subtitle
//            self.description = description
//            self.img_url = img_url
//            self.score = score
            self.init(title : title,
                      description : description,
                      averageTemp : averageTemp,
                      raindays : raindays,
                      seoulTemp : seoulTemp
        )
        }
}
