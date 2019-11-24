//
//  PlaceHotelTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/24.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class PlaceHotelTableViewCell: UITableViewCell {

    //MARK : 이후의 코드들이 쓸 설정 값입니다.
    var style = CellStyleConfig()
    
    func makeValueLabel(style:CellStyleConfig) -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = style.fontColorValue
        label.font = .systemFont(ofSize: style.fontSizeValue)
        
        return label
    }
    
    func makeDescLabel(style:CellStyleConfig) -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = style.fontColorValueDesc
        label.font = .boldSystemFont(ofSize: style.fontSizeValueDesc)
//        label.text = "1달 전 환율"
        return label
    }
    
    lazy private var placeTitle: UILabel = {
        let lbl = UILabel()
//       CGRect(origin:self.contentView.,size:style.sizeTitle)
        lbl.attributedText = NSAttributedString(string: "네 이렇게 하니 나오네요", attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeTitle)])
        lbl.textAlignment = .left
        lbl.textColor = style.fontColorTitle
        return lbl
    }()
    lazy private var placeDescription: UILabel = {
        let lbl = UILabel()
        lbl.text = "하와이 호텔은 연평균 1박에 400만원으로 비싼 편이에요.2달 뒤에는 평소보다 조금 더 비싸구요.매일 조금씩 오르고 있어요."
        lbl.textAlignment = .left
        lbl.numberOfLines = 3
        lbl.textColor = style.fontColorDescription
        lbl.font = .systemFont(ofSize: style.fontSizeDescription)
        return lbl
    }()
    lazy private var luxuryHotelValue: UILabel = {
        return makeValueLabel(style: style)
    }()
    lazy private var luxuryHotelDesc: UILabel = {
        let lbl = makeDescLabel(style: style)
        lbl.text = "4,5성급 \n 호텔 1박 평균"
        return lbl
    }()
    
    lazy private var generalHotelValue: UILabel = {
        return makeValueLabel(style: style)
    }()
    
    lazy private var generalHotelDesc: UILabel = {
        let lbl = makeDescLabel(style: style)
        lbl.text = "1~3성급 \n 호텔 1박 평균"
        return lbl
    }()

    lazy private var hostelValue: UILabel = {
        return makeValueLabel(style: style)
    }()
    lazy private var hostelDesc: UILabel = {
        let lbl = makeDescLabel(style: style)
        lbl.text = "호스텔 \n 호텔 1박 평균"
        return lbl
    }()
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Init은 되었다?")
        self.addSubview(placeTitle)
        self.addSubview(placeDescription)
        self.addSubview(luxuryHotelValue)
        self.addSubview(luxuryHotelDesc)
        self.addSubview(generalHotelValue)
        self.addSubview(generalHotelDesc)
        self.addSubview(hostelValue)
        self.addSubview(hostelDesc)
        
        //테스트 중 입니다.(타이틀만 모양잡기)
        placeTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 18, paddingBottom: 0, paddingRight: 101, width: 295, height: 29, enableInsets: false)
        placeDescription.anchor(top: placeTitle.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 3, paddingLeft: 18, paddingBottom: 0, paddingRight: 16, width: 380, height: 57, enableInsets: false)
        
        luxuryHotelValue.anchor(top: placeDescription.bottomAnchor, left: leftAnchor, bottom: nil, right: generalHotelValue.leftAnchor, paddingTop: 12, paddingLeft: 25, paddingBottom: 0, paddingRight: 26, width: 110, height: 48, enableInsets: false)
        generalHotelValue.anchor(top: placeDescription.bottomAnchor, left: luxuryHotelValue.rightAnchor, bottom: nil, right: hostelValue.leftAnchor, paddingTop: 12, paddingLeft: 26, paddingBottom: 0, paddingRight: 26, width: 110, height: 48, enableInsets: false)
        hostelValue.anchor(top: placeDescription.bottomAnchor, left: generalHotelValue.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 26, paddingBottom: 0, paddingRight: 26, width: 110, height: 48, enableInsets: false)
        //Desc는 Value의 중앙에 맞춘다.
        luxuryHotelDesc.anchor(top: luxuryHotelValue.bottomAnchor, bottom: nil, centerX: luxuryHotelValue.centerXAnchor, paddingTop: 8, paddingBottom: 0, width: 73, height: 30, enableInsets: false)
        generalHotelDesc.anchor(top: generalHotelValue.bottomAnchor, bottom: nil, centerX: generalHotelValue.centerXAnchor, paddingTop: 8, paddingBottom: 0, width: 73, height: 30, enableInsets: false)
        hostelDesc.anchor(top: hostelValue.bottomAnchor, bottom: nil, centerX: hostelValue.centerXAnchor, paddingTop: 8, paddingBottom: 0, width: 73, height: 30, enableInsets: false)
        
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    func populate(hotel:Hotel){
        self.placeTitle.text = hotel.title
        self.placeDescription.text = hotel.description
        //TODO : 직접 너무 많은 설정을 해야해서, 설정이 흩어져 있는 것이 신경쓰입니다. 고치자
        self.luxuryHotelValue.attributedText = NSAttributedString(string: intToString(hotel.luxuryAverage), attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeValue)])
        self.generalHotelValue.attributedText = NSAttributedString(string: intToString(hotel.generalAverage), attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeValue)])
        self.hostelValue.attributedText = NSAttributedString(string:intToString(hotel.hostel), attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeValue)])
    }
    func intToString(_ int:Int)->String{
        print("intToString 유입")
        print(int)
        let manWon = int / 10000
        let won = int % 10000
        //만과 나머지 사이에는 항상 줄바꿈이 있어야 합니다.
        if won == 0{
            return (String(manWon) + "만 원")
        }else{
            return (String(manWon) + "만" + "\n" + String(won) + "원")
        }
    }
}
