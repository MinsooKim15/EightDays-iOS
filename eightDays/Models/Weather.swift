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
    //TODO : 어떤거는 Float이고, 어떤 거는 Double인게 조금 못생겼어요 ㅜ 통일할지 고민합시다.
    var title : String
    var description : String
    var averageTemp : Double
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
        //위 4 개의 값이 비면, Weather 안 보여줄것
            guard let title =  dictionary["weatherTitle"] as? String,
        let description =  dictionary["weatherDescription"] as? String,
        let averageTemp = dictionary["placeAverage"] as? Double,
        let raindays =  dictionary["rainDays"] as? Float
        
        else {print("Weather 유입은 되었는데, Init 실패")
                    return nil}
        
//        print(averageTemp)
        print(dictionary["placeAverage"])
        
//        let averageTemp =  ( as? NSString)?.floatValue
//        print(dictionary["])
//        var averageTemp:Float = 0.0
//        if let average_ = dictionary["placeAverage"]{
//            averageTemp = average_ as? Double ?? 0.0
//        }
//
        let seoulTemp =  dictionary["seoulToday"] as? Float
        
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
                      seoulTemp : seoulTemp!
        )
        }
}
