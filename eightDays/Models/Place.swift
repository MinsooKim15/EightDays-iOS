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
    var exchange : Exchange?
    var cellCount : Int // 노출해야 하는 Cell의 개수 = 데이터의 개수를 세는 Counter입니다.
    
    
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
    var listOfUsefulData : [Any]?
    
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
        var cellCount : Int = 0
        var listOfUsefulData : [Any] = []
        if let weatherDictionary = dictionary["weather"] as? [String:Any]{
            weather = Weather(dictionary : weatherDictionary)
            if let realWeather = weather as? Weather{
                //Weather Init 실패도 있음
                cellCount += 1
                listOfUsefulData.append(weather)
            }
        }else{
            weather = nil
        }
        var hotel : Hotel?
        if let hotelDictionary = dictionary["hotel"] as? [String:Any]{
            hotel = Hotel(dictionary : hotelDictionary)
            if let realHotel = hotel as? Hotel{
                //Weather Init 실패도 있음
                cellCount += 1
                listOfUsefulData.append(hotel)
            }
        }else{
            hotel = nil
        }
        var flight : Flight?
        if let flightDictionary = dictionary["flight"] as? [String:Any]{
            flight = Flight(dictionary : flightDictionary)
            if let realFlight = flight as? Flight{
                //Flight Init 실패도 있음
                cellCount += 1
                listOfUsefulData.append(flight)
            }
        }else{
            flight = nil
        }
        var exchange : Exchange?
        if let exchangeDictionary = dictionary["exchange"] as? [String:Any]{
            exchange = Exchange(dictionary: exchangeDictionary)
            if let realExchange = exchange as? Exchange{
                cellCount += 1
                listOfUsefulData.append(exchange)
            }
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
                      flight : flight,
                      exchange : exchange,
                      cellCount : cellCount,
                      listOfUsefulData : listOfUsefulData
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




// TODO: 일단 원래 데이터형을 손대기 싫어서 SmallPlace라는 임시 자료형을 만들었음.
// TODO: 후에 conditional 잘 써서 합칩시다.

struct SmallPlace {
    var title_kor : String
    var subtitle : String
    var img_url : String
    var score : Int
    var place_id : String
    
    var dictionary: [String: Any]{
        return [
            "title_kor" : title_kor,
            "subtitle" : subtitle,
            "img_url" : img_url,
            "score" : score,
            "place_id" : place_id]
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
        let place_id = dictionary["place_id"] as? String
            else{return nil}
        self.init(title_kor : title_kor,
//                      title_eng : title_eng,
                      subtitle : subtitle,
//                      description : description,
                      img_url : img_url,
                      score : score,
                      place_id : place_id
//                      reference : reference,
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
