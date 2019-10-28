//
//  place.swift
//  eightDays
//
//  Created by minsoo kim on 2019/10/27.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Place {
    var title_kor : String
    var title_eng : String
    var subtitle : String
    var description : String
    var img_url : String
    var score : Int
    
    var weather : Weather?
    var hotel : Hotel?
    var flight : Flight?
    
    var dictionary: [String: Any]{
        return [
            "title_kor" : title_kor,
            "title_eng" : title_eng,
            "subtitle" : subtitle,
            "description" : description,
            "img_url" : img_url,
            "score" : score,]
    }
    //TODO : document -> init 이슈가 있다면 여기부터 고쳐보자
    
}

extension Place {
    init?(dictionary: [String:Any]){
            guard let title_kor =  dictionary["title_kor"] as? String,
        let title_eng =  dictionary["title_eng"] as? String,
        let subtitle =  dictionary["subtitle"] as? String,
        let description =  dictionary["description"] as? String,
        let img_url =  dictionary["img_url"] as? String,
        let score =  dictionary["score"] as? Int
        else {
                    return nil}


//            self.title_kor = title_kor
//            self.title_eng = title_eng
//            self.subtitle = subtitle
//            self.description = description
//            self.img_url = img_url
//            self.score = score
            self.init(title_kor : title_kor,
                      title_eng : title_eng,
                      subtitle : subtitle,
                      description : description,
                      img_url : img_url,
                      score : score
        )
        }
}
    //TODO : document -> init 이슈가 있다면 여기부터 고쳐보자ㅜ documentSerializable이 없는 type이라 이거 구현하다가 뭔지 알아보는거 포기하고, struct안에 init?을 하나 만들었음.
//extension Place: DocumentSerializable {
//    init?(dictionary: [String:Any]){
//        guard let title_kor =  dictionary["title_kor"] as? String,
//            let title_eng =  dictionary["title_eng"] as? String,
//            let subtitle =  dictionary["subtitle"] as? String,
//            let description =  dictionary["description"] as? String,
//            let img_url =  dictionary["img_url"] as? String,
//            let score =  dictionary["title_eng"] as? Int else {return nil}
//        self.init(title_kor : title_kor,
//                  title_eng : title_eng,
//                  subtitle : subtitle,
//                  description : description,
//                  img_url : img_url,
//                  score : score)
//    }
//}
