//
//  Curation.swift
//  eightDays
//
//  Created by minsoo kim on 2020/03/04.
//  Copyright © 2020 minsoo kim. All rights reserved.
//

import Foundation

struct Curation {
    var title : String
    var placeListNS : NSArray
    var placeList : [SmallPlace]?
    var rank : Int
    var dictionary : [String: Any]{
        return [
            "title": title,
            "rank" : rank,
            "placeListNS": placeListNS
        ]
    }
    var hasConverted : Bool
    
    mutating func arrayToSmallPlace(){
        for i in self.placeListNS{
            print("뭔가를 성공했다?")
            if let newArray = i as? Dictionary<String,AnyObject>{
                if let newArrayToString = newArray as? [String:Any]{
                    print(newArrayToString)
                    print("일단 형태를 대충 바꿨으니, 이제 place로 바꿀 수 있나")
                    guard let smallPlace = SmallPlace(dictionary: newArrayToString) else { print("변환 실패"); return }
                    print("이것도 해내었나?")
                    if self.placeList == nil {
                        self.placeList = [SmallPlace]()
                    }
                    placeList!.append(smallPlace)
                    self.hasConverted = true //하나라도 컨버팅했으면 true.
                    print("성공했습니다. 변환")
                }
            }
            print("으으음??")
        }
    }
}
extension Curation {
    init?(dictionary: [String:Any]){
        guard let title = dictionary["title"] as? String,
            let placeListNS = dictionary["list_of_places"] as? NSArray
            
            else{return nil}
        let rank = dictionary["rank"] as? Int
        self.init(title:title,
                  placeListNS : placeListNS,
                  rank: rank ?? 1,
                  hasConverted : false
        )
    }
}
