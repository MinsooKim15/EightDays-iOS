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
//            "weekAgoRate" : weekAgoRate,
//            "monthAgoRate" : monthAgoRate
//        ]
//    }
}

extension Exchange{
    init?(dictionary: [String:Any]){
        guard let title =  dictionary["rateTitle"] as? String,
            let description =  dictionary["rateDescription"] as? String,
//            let exchangeRates =  dictionary["exchangeRates"] as? [Int],
            let todayRate =  dictionary["todayRate"] as? Int,
            let weekAgoRate =  dictionary["weekAgoRate"] as? Int,
            let monthAgoRate =  dictionary["monthAgoRate"] as? Int
            else {print("Exchange 유입은 되었는데, Init 실패")
                return nil}
        self.init(title : title,
                  description : description,
                  todayRate : todayRate,
                  weekAgoRate : weekAgoRate,
                  monthAgoRate : monthAgoRate
        )
    }
}
