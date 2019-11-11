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
    var month_ago_average : Int
    var month_ago_minimum : Int
    var today_average : Int
    var today_minimum : Int
    var dictionary: [String: Any]{
        return [
            "title" : title,
            "description" : description,
            "month_ago_average" : month_ago_average,
            "month_ago_minimum" : month_ago_minimum,
            "today_average" : today_average,
            "today_minimum" : today_minimum
        ]
    }
}

extension Flight{
    init?(dictionary: [String:Any]){
            guard let title =  dictionary["title"] as? String,
            let description =  dictionary["description"] as? String,
            let month_ago_average =  dictionary["month_ago_average"] as? Int,
            let month_ago_minimum =  dictionary["month_ago_minimum"] as? Int,
            let today_average =  dictionary["today_average"] as? Int,
            let today_minimum =  dictionary["today_minimum"] as? Int
            else {print("Flight 유입은 되었는데, Init 실패")
                        return nil}
                self.init(title : title,
                          description : description,
                          month_ago_average : month_ago_average,
                          month_ago_minimum : month_ago_minimum,
                          today_average : today_average,
                          today_minimum : today_minimum
        )
            }
}
