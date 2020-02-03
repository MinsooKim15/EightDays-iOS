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
    var title_kor : String //이거는 수정을 못함 ㅜㅜ 변수명 변경의 영향이 파악도 안됨 ㅜㅜ
    var title_eng : String?
    var subtitle : String
    var description : String?
    var img_url : String?
    var score : Int
    
    var weather : Weather?
    var hotel : Hotel?
    var flight : Flight?
    
    var hasOpDescription = false
    // 요 아래의 dictionary의 정체를 발견하는 것이 첫번째 목표임 -> 필요 없는 듯
//    var dictionary: [String: Any]{
//        return [
//            "title_kor" : title_kor,
//            "title_eng" : title_eng,
//            "subtitle" : subtitle,
//            "description" : description,
//            "img_url" : img_url,
//            "score" : score,
//            "weather" : weather,
//            "hotel" : hotel,
//            "flight" : flight
//        ]
//    }
    //TODO : document -> init 이슈가 있다면 여기부터 고쳐보자
    
}

extension Place {
    init?(dictionary: [String:Any]){
        guard let titleKor =  dictionary["titleKor"] as? String,
        let titleEng =  dictionary["titleEng"] as? String,
        let subtitle =  dictionary["subtitle"] as? String,
//        let description =  dictionary["description"] as? String,
        
        let score =  dictionary["score"] as? Int
        else {
            print("메인데이터가 틀렸어")
            return nil}
        // 개별 Model은 있으면 그만 없어도 그만 임.
        // TODO: 근데 아예 해당 값이 없으면 바로 에러 테트림.. 이거 고쳐야 함.
        let description = dictionary["desctiption"] as? String
        let imgUrl =  dictionary["img_url"] as? String
        var weather : Weather?
        if let weatherDictionary = dictionary["weather"] as? [String:Any]{
            weather = Weather(dictionary : weatherDictionary)
        }else{
            weather = nil
        }
        var hotel : Hotel?
        if let hotelDictionary = dictionary["hotel"] as? [String:Any]{
            hotel = Hotel(dictionary : hotelDictionary)
        }else{
            hotel = nil
        }
        var flight : Flight?
        if let flightDictionary = dictionary["flight"] as? [String:Any]{
            flight = Flight(dictionary : flightDictionary)
        }else{
            flight = nil
        }

//            self.title_kor = title_kor
//            self.title_eng = title_eng
//            self.subtitle = subtitle
//            self.description = description
//            self.img_url = img_url
//            self.score = score
            self.init(title_kor : titleKor,
                      title_eng : titleEng,
                      subtitle : subtitle,
                      description : description,
                      img_url : imgUrl,
                      score : score,
                      weather : weather,
                      hotel : hotel,
                      flight : flight
        )
        }
    
}


// 요 바로 밑의 내용은 전체 Init 변경 전의 코드임. 망하면 살린다.
//extension Place {
//    init?(dictionary: [String:Any]){
//            guard let title_kor =  dictionary["title_kor"] as? String,
//        let title_eng =  dictionary["title_eng"] as? String,
//        let subtitle =  dictionary["subtitle"] as? String,
//        let description =  dictionary["description"] as? String,
//        let img_url =  dictionary["img_url"] as? String,
//        let score =  dictionary["score"] as? Int
//        else {
//                    return nil}
//        // 개별 Model은 있으면 그만 없어도 그만 임.
//        // TODO: 근데 아예 해당 값이 없으면 바로 에러 테트림.. 이거 고쳐야 함.
//        let weatherDictionary = dictionary["weather"] as? [String:Any]
//        let weather = Weather(dictionary : weatherDictionary!)
//        let hotelDictionary = dictionary["hotel"] as? [String:Any]
//        let hotel = Hotel(dictionary : hotelDictionary!)
//        let flightDictionary = dictionary["flight"] as? [String:Any]
//        let flight = Flight(dictionary : flightDictionary!)
//
////            self.title_kor = title_kor
////            self.title_eng = title_eng
////            self.subtitle = subtitle
////            self.description = description
////            self.img_url = img_url
////            self.score = score
//            self.init(title_kor : title_kor,
//                      title_eng : title_eng,
//                      subtitle : subtitle,
//                      description : description,
//                      img_url : img_url,
//                      score : score,
//                      weather : weather,
//                      hotel : hotel,
//                      flight : flight
//        )
//        }
//}



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
//    func arrayToSmallPlace(){
//        for i in self.placeList{
//            if let newArray = i as? Dictionary<String,AnyObject>{
//                print("뭔가를 성공했다.!!!!!")
//                print(newArray)
//            }
//            print("으으음??")
//        }
//    }
    
}
extension Curation {
    init?(dictionary: [String:Any]){
        guard let title = dictionary["title"] as? String,
            let placeListNS = dictionary["list_of_places"] as? NSArray,
            let rank = dictionary["rank"] as? Int
            else{return nil}
        self.init(title:title,
                  placeListNS : placeListNS,
                  rank: rank,
                  hasConverted : false
        )
    }
}

// TODO: 일단 원래 데이터형을 손대기 싫어서 SmallPlace라는 임시 자료형을 만들었음.
// TODO: 후에 conditional 잘 써서 합칩시다.

struct SmallPlace {
    var title_kor : String
    var subtitle : String
    var img_url : String
    var score : Int
    var reference : DocumentReference
    
    var dictionary: [String: Any]{
        return [
            "title_kor" : title_kor,
            "subtitle" : subtitle,
            "img_url" : img_url,
            "score" : score,
            "reference" : reference]
    }
    //TODO : document -> init 이슈가 있다면 여기부터 고쳐보자
}

extension SmallPlace {
    init?(dictionary: [String:Any]){
        guard let title_kor =  dictionary["title_kor"] as? String,
//        let title_eng =  dictionary["title_eng"] as? String,
        let subtitle =  dictionary["subtitle"] as? String,
//        let description =  dictionary["description"] as? String,
        let img_url =  dictionary["img_url"] as? String,
        let score =  dictionary["score"] as? Int,
        let reference = dictionary["reference"] as? DocumentReference
            else{return nil}
        self.init(title_kor : title_kor,
//                      title_eng : title_eng,
                      subtitle : subtitle,
//                      description : description,
                      img_url : img_url,
                      score : score,
                      reference : reference
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
