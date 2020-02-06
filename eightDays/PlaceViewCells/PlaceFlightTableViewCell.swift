//
//  PlaceFlightTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/24.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class PlaceFlightTableViewCell: UITableViewCell {

    // 처음 코드만으로 완성한 Cell이에요 ㅜㅜ 감동
    //MARK : 이후의 코드들이 쓸 설정 값입니다.
    var style = CellStyleConfig()
    var mainViewOrigin = CGPoint(x: 0, y: 0)
    
    func makeValueLabel(style:CellStyleConfig) -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = style.fontColorValue
        label.font = .systemFont(ofSize: style.fontSizeValue)
        label.text = "320만 \n 3,120원"
        label.numberOfLines = 2
        return label
    }
    
    func makeDescLabel(style:CellStyleConfig) -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = style.fontColorValueDesc
        label.numberOfLines = 2
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
    
//    lazy private var monthAgoAverageValue: UILabel = {
//        return makeValueLabel(style: style)
//    }()
//    lazy private var monthAgoAverageDesc: UILabel = {
//        let lbl = makeDescLabel(style: style)
//        lbl.text = "한 달 전 \n 평균 왕복 비행기 값"
//        return lbl
//    }()
    lazy private var monthAgoMinimumValue: UILabel = {
        return makeValueLabel(style: style)
    }()
    lazy private var monthAgoMinimumDesc: UILabel = {
        let lbl = makeDescLabel(style: style)
        lbl.text = "한 달 전 \n 최저 비행기 값"
        return lbl
    }()
    lazy private var todayAverageValue: UILabel = {
        return makeValueLabel(style: style)
    }()
    lazy private var todayAverageDesc: UILabel = {
        let lbl = makeDescLabel(style: style)
        lbl.text = "오늘 평균 \n 왕복 비행기 값"
        return lbl
    }()
    lazy private var todayMinimumValue: UILabel = {
        return makeValueLabel(style: style)
    }()
    lazy private var todayMinimumDesc: UILabel = {
        let lbl = makeDescLabel(style: style)
        lbl.text = "오늘 최저 \n 왕복 비행기 값"
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
        self.addSubview(todayAverageValue)
        self.addSubview(todayAverageDesc)
        self.addSubview(todayMinimumValue)
        self.addSubview(todayMinimumDesc)
//        self.addSubview(monthAgoAverageValue)
//        self.addSubview(monthAgoAverageDesc)
//        self.addSubview(monthAgoMinimumValue)
//        self.addSubview(monthAgoMinimumDesc)
        
        //테스트 중 입니다.(타이틀만 모양잡기)
        placeTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 18, paddingBottom: 0, paddingRight: 101, width: 295, height: 29, enableInsets: false)
        placeDescription.anchor(top: placeTitle.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 3, paddingLeft: 18, paddingBottom: 0, paddingRight: 16, width: 380, height: 57, enableInsets: false)
        todayAverageValue.anchor(top: placeDescription.bottomAnchor, left: leftAnchor, bottom: nil, right: todayMinimumValue.leftAnchor, paddingTop: 12, paddingLeft: 47, paddingBottom: 0, paddingRight: 72, width: 120, height: 50, enableInsets: false)
//        monthAgoAverageValue.anchor(top: placeDescription.bottomAnchor, left: todayAverageValue.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 72, paddingBottom: 0, paddingRight: 40, width: 120, height: 50, enableInsets: false)
        // averageDesc와 minimumDesc/Value는 averageValue의 중앙에 맞춘다.
        todayAverageDesc.anchor(top: todayAverageValue.bottomAnchor, bottom: nil, centerX: todayAverageValue.centerXAnchor, paddingTop: 8, paddingBottom: 0, width: 103, height: 30, enableInsets: false)
//        monthAgoAverageDesc.anchor(top: monthAgoAverageValue.bottomAnchor, bottom: nil, centerX: monthAgoAverageValue.centerXAnchor, paddingTop: 8, paddingBottom: 0, width: 103, height: 30, enableInsets: false)

        //minimumValue는 centerX 정렬은 같은데, top padding 값을 늘린다.
        todayMinimumValue.anchor(top: placeDescription.bottomAnchor, left:todayAverageValue.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 47, paddingBottom: 0, paddingRight: 40, width: 120, height: 50, enableInsets: false)
//        monthAgoMinimumValue.anchor(top: monthAgoAverageDesc.bottomAnchor, bottom: nil, centerX: monthAgoAverageValue.centerXAnchor, paddingTop: 20, paddingBottom: 0, width: 120, height: 50, enableInsets: false)

        //minimumDesc는 averageDesc와 같음.
        todayMinimumDesc.anchor(top: todayMinimumValue.bottomAnchor, bottom: nil, centerX: todayMinimumValue.centerXAnchor, paddingTop: 8, paddingBottom: 0, width: 103, height: 30, enableInsets: false)
//        monthAgoMinimumDesc.anchor(top: monthAgoMinimumValue.bottomAnchor, bottom: nil, centerX: monthAgoAverageValue.centerXAnchor, paddingTop: 8, paddingBottom: 0, width: 103, height: 30, enableInsets: false)

        
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    func populate(flight:Flight){
        self.placeTitle.text = flight.title
        self.placeDescription.text = flight.description
        //TODO : 직접 너무 많은 설정을 해야해서, 설정이 흩어져 있는 것이 신경쓰입니다. 고치자
        self.todayAverageValue.attributedText = NSAttributedString(string:intToString(flight.todayAverage), attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeValue)])
        self.todayMinimumValue.attributedText = NSAttributedString(string:intToString(flight.todayMinimum), attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeValue)])
//        self.monthAgoAverageValue.attributedText = NSAttributedString(string:intToString(flight.monthAgoAverage), attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeValue)])
//        self.monthAgoMinimumValue.attributedText = NSAttributedString(string:intToString(flight.monthAgoMinimum), attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeValue)])
    }
    func intToString(_ int:Int)->String{
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
