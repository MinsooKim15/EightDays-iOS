//
//  Flight.swift
//  eightDays
//
//  Created by minsoo kim on 2019/10/27.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import Foundation
import Firebase


struct Flight{
    var title : String
    var description : String
    var monthAgoAverage : Int?
    var monthAgoMinimum : Int?
    var todayAverage : Int
    var todayMinimum : Int
//    var dictionary: [String: Any]{
//        return [
//            "title" : title,
//            "description" : description,
//            "monthAgoAverage" : monthAgoAverage,
//            "monthAgoMinimum" : monthAgoMinimum,
//            "todayAverage" : todayAverage,
//            "todayMinimum" : todayMinimum
//        ]
//    }
}

extension Flight{
    init?(dictionary: [String:Any]){
            guard let title =  dictionary["flightTitle"] as? String,
            let description =  dictionary["flightDescription"] as? String,
//            let monthAgoAverage =  dictionary["month_ago_average"] as? Int,
//            let monthAgoMinimum =  dictionary["month_ago_minimum"] as? Int,
            let todayAverage =  dictionary["todayAverage"] as? Int,
            let todayMinimum =  dictionary["todayMinimum"] as? Int
            else {print("Flight 유입은 되었는데, Init 실패")
                        return nil}
                self.init(title : title,
                          description : description,
//                          monthAgoAverage : monthAgoAverage,
//                          monthAgoMinimum : monthAgoMinimum,
                          todayAverage: todayAverage,
                          todayMinimum : todayMinimum
        )
            }
}
