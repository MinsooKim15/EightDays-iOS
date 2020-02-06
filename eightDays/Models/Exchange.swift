//
//  Exchange.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/16.
//  Copyright © 2019 minsoo kim. All rights reserved.

//TODO : Exchange 자료형 규격은 Client가 최신임. 서버가 맞추어 수정 필요

import Foundation
import Firebase


struct Exchange{
    var title : String
    var description : String
    var exchangeRates : [Int]?
    var todayRate : Int
    var weekAgoRate : Int
    var monthAgoRate : Int
//    var dictionary: [String: Any]{
//        return [
//            "title" : title,
//            "description" : description,
//            "exchangeRates" : exchangeRates,
//            "todayRate" : todayRate,
//    ㄴ        "weekAgoRate" : weekAgoRate,
//            "monthAgoRate" : monthAgoRate
//        ]
//    }
}

extension Exchange{
    init?(dictionary: [String:Any]){
        guard let title =  dictionary["rateTitle"] as? String,
            let description =  dictionary["rateDescription"] as? String,
//            let exchangeRates =  dictionary["exchangeRates"] as? [Int],
            let todayRate =  dictionary["todayRate"] as? Double,
            let weekAgoRate =  dictionary["weekAgoRate"] as? Double,
            let monthAgoRate =  dictionary["monthAgoRate"] as? Double
            else {print("Exchange 유입은 되었는데, Init 실패")
                return nil}
        print("일단 여기까지는 옴")
//        print(Int("일단 여기까지도 잘 옴"))
        print(Int(weekAgoRate))
        print(Int(todayRate))
        print(Int(monthAgoRate))
        self.init(title : title,
                  description : description,
                  todayRate : Int(todayRate),
                  weekAgoRate : Int(weekAgoRate),
                  monthAgoRate : Int(monthAgoRate)
        )
    }
}
