//
//  Hotel.swift
//  eightDays
//
//  Created by minsoo kim on 2019/10/27.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import Foundation
import Firebase

struct Hotel {
    var title : String
    var description : String
    var luxury_average : Int
    var general_average : Int
    var hostel : Int
    var dictionary: [String: Any]{
        return [
            "title" : title,
            "description" : description,
            "luxury_average" : luxury_average,
            "general_average" : general_average,
            "hostel" : hostel
        ]
    }
}
extension Hotel{
    init?(dictionary: [String:Any]){
            guard let title =  dictionary["title"] as? String,
            let description =  dictionary["description"] as? String,
            let luxury_average =  dictionary["luxury_average"] as? Int,
            let general_average =  dictionary["general_average"] as? Int,
            let hostel =  dictionary["hostel"] as? Int
            else {print("Hotel 유입은 되었는데, Init 실패")
                        return nil}

                self.init(title : title,
                          description : description,
                          luxury_average : luxury_average,
                          general_average : general_average,
                          hostel : hostel
            )
            }
}
