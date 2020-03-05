//
//  PlaceExchangeTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/16.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit



struct CellStyleConfig{


    var sizeTitle : CGSize
    var sizeDescription : CGSize
    var sizeValue : CGSize
    var sizeDesc : CGSize
    var fontColorTitle : UIColor
    var fontColorDescription : UIColor
    var fontColorValue : UIColor
    var fontColorValueDesc : UIColor
    var fontSizeTitle : CGFloat
    var fontSizeDescription : CGFloat
    var fontSizeValue : CGFloat
    var fontSizeValueDesc : CGFloat
    init(
        sizeTitle : CGSize = CGSize(width:295, height:29),
        sizeDescription : CGSize = CGSize(width:380, height:57),
        sizeValue : CGSize = CGSize(width: 48, height:24),
        sizeDesc : CGSize = CGSize(width:48, height:30),
        fontColorTitle : UIColor = .charcoalGrey,
        fontColorDescription : UIColor = .steel ,
        fontColorValue : UIColor = .charcoalGrey ,
        fontColorValueDesc : UIColor = .charcoalGrey,
        fontSizeTitle : CGFloat = CGFloat(24),
        fontSizeDescription : CGFloat = CGFloat(16),
        fontSizeValue : CGFloat = CGFloat(20),
        fontSizeValueDesc : CGFloat = CGFloat(12)
    ) {
        self.sizeTitle = sizeTitle
        self.sizeDescription = sizeDescription
        self.sizeValue = sizeValue
        self.sizeDesc = sizeDesc
        self.fontColorTitle = fontColorTitle
        self.fontColorDescription = fontColorDescription
        self.fontColorValue = fontColorValue
        self.fontColorValueDesc = fontColorValueDesc
        self.fontSizeTitle = fontSizeTitle
        self.fontSizeDescription = fontSizeDescription
        self.fontSizeValue = fontSizeValue
        self.fontSizeValueDesc = fontSizeValueDesc
    }
}

class PlaceExchangeTableViewCell: UITableViewCell {

    // 처음 코드만으로 완성한 Cell이에요 ㅜㅜ 감동
    //MARK : 이후의 코드들이 쓸 설정 값입니다.
    var style = CellStyleConfig()
    var mainViewOrigin = CGPoint(x: 0, y: 0)
    
    
    var exchange : Exchange? {
    didSet {
        self.placeTitle.attributedText = NSAttributedString(string:String(exchange?.title ?? ""))
        self.placeDescription.text = exchange?.description
        //TODO : 직접 너무 많은 설정을 해야해서, 설정이 흩어져 있는 것이 신경쓰입니다. 고치자
        self.todayExchangeValue.attributedText = NSAttributedString(string: String(exchange?.todayRate ?? 0) + "원", attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeValue)])
        self.weekExchangeValue.attributedText = NSAttributedString(string: String(exchange?.weekAgoRate ?? 0) + "원", attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeValue)])
        self.monthExchangeValue.attributedText = NSAttributedString(string: String(exchange?.monthAgoRate ?? 0) + "원", attributes: [.font:UIFont.boldSystemFont(ofSize: style.fontSizeValue)])
    }
    }
    
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
//        lbl.text = "하와이 호텔은 연평균 1박에 400만원으로 비싼 편이에요.2달 뒤에는 평소보다 조금 더 비싸구요.매일 조금씩 오르고 있어요."
        lbl.textAlignment = .left
        lbl.numberOfLines = 3
        lbl.textColor = style.fontColorDescription
        lbl.font = .systemFont(ofSize: style.fontSizeDescription)
        return lbl
    }()
    lazy private var todayExchangeValue: UILabel = {
        return makeValueLabel(style: style)
    }()
    lazy private var todayExchangeDesc: UILabel = {
        let lbl = makeDescLabel(style: style)
        lbl.text = "오늘 환율"
        return lbl
    }()
    lazy private var weekExchangeDesc: UILabel = {
        let lbl = makeDescLabel(style: style)
        lbl.text = "1주 전 환율"
        return lbl
    }()
    lazy private var weekExchangeValue: UILabel = {
        return makeValueLabel(style: style)
    }()
    lazy private var monthExchangeValue: UILabel = {
        return makeValueLabel(style: style)
    }()
    lazy private var monthExchangeDesc: UILabel = {
        let lbl = makeDescLabel(style: style)
        lbl.text = "1달 전 환율"
        return lbl
    }()
    
    lazy private var cautionMessage: UILabel! = {
        let lbl = UILabel()
        lbl.text = "환율이 오르면 호텔 값,여행 경비가 더 많이 들게 됩니다."
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.textColor = style.fontColorDescription
        lbl.font = .systemFont(ofSize: CGFloat(12))
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
        self.addSubview(todayExchangeValue)
        self.addSubview(todayExchangeDesc)
        self.addSubview(weekExchangeValue)
        self.addSubview(weekExchangeDesc)
        self.addSubview(monthExchangeValue)
        self.addSubview(monthExchangeDesc)
        self.addSubview(cautionMessage)
        
        //테스트 중 입니다.(타이틀만 모양잡기)
        placeTitle.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 18, paddingBottom: 0, paddingRight: 101, width: 295, height: 29, enableInsets: false)
        placeDescription.anchor(top: placeTitle.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 3, paddingLeft: 18, paddingBottom: 0, paddingRight: 16, width: 380, height: 57, enableInsets: false)
        todayExchangeValue.anchor(top: placeDescription.bottomAnchor, left: leftAnchor, bottom: nil, right: weekExchangeValue.leftAnchor, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 80, width: 74, height: 24, enableInsets: false)
        weekExchangeValue.anchor(top: placeDescription.bottomAnchor, left: todayExchangeValue.rightAnchor, bottom: nil, right: monthExchangeValue.leftAnchor, paddingTop: 12, paddingLeft: 80, paddingBottom: 0, paddingRight: 80, width: 74, height: 24, enableInsets: false)
        monthExchangeValue.anchor(top: placeDescription.bottomAnchor, left: weekExchangeValue.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 80, paddingBottom: 0, paddingRight: 13, width: 74, height: 24, enableInsets: false)
        //Desc는 Value의 중앙에 맞춘다.
        todayExchangeDesc.anchor(top: todayExchangeValue.bottomAnchor, bottom: nil, centerX: todayExchangeValue.centerXAnchor, paddingTop: 8, paddingBottom: 0, width: 70, height: 15, enableInsets: false)
        weekExchangeDesc.anchor(top: weekExchangeValue.bottomAnchor, bottom: nil, centerX: weekExchangeValue.centerXAnchor, paddingTop: 8, paddingBottom: 0, width: 70, height: 15, enableInsets: false)
        monthExchangeDesc.anchor(top: monthExchangeValue.bottomAnchor, bottom: nil, centerX: monthExchangeValue.centerXAnchor, paddingTop: 8, paddingBottom: 0, width: 70, height: 15, enableInsets: false)
        //cautionMessage는 중앙 맞춤 아님
        
        cautionMessage.anchor(top: todayExchangeDesc.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 20, paddingLeft: 18, paddingBottom: 17, paddingRight: 0, width: 296, height: 15, enableInsets: false)
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }

}




import UIKit
extension UIView {
    //Anchor를 한 번에 맞추는 메소드
    //첫번째는 좌우상하 padding값을 받아서 조정합니다.
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
//        if centerX = centerX {
//
//        }
        
    }
    //얘는 좌우 대신 centerX를 받습니다. desc를 위한 메소드
    func anchor (top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, centerX : NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingBottom: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
            var topInset = CGFloat(0)
            var bottomInset = CGFloat(0)
            
            if #available(iOS 11, *), enableInsets {
                let insets = self.safeAreaInsets
                topInset = insets.top
                bottomInset = insets.bottom
                
                print("Top: \(topInset)")
                print("bottom: \(bottomInset)")
            }
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
            }
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
            }
            if height != 0 {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
            if width != 0 {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
        }
    func anchor (left: NSLayoutXAxisAnchor?,right: NSLayoutXAxisAnchor?,centerY : NSLayoutYAxisAnchor?, paddingLeft: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool){
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}


// 환율 그래프를 그리기 위해 만들었는데, 출시 시점에는 못그렸음 ㅜㅜ 이건 나중에 다시 그릴 예정
class GraphView: UIView {

    var data: [CGFloat] = [2, 6, 12, 4, 5,100, 7, 5, 6, 6, 3,5,5,5,5,6,7,8] {
        didSet {
            setNeedsDisplay()
        }
    }

    func coordYFor(index: Int) -> CGFloat {
        return bounds.height - bounds.height * data[index] / (data.max() ?? 0)
    }

    override func draw(_ rect: CGRect) {

        let path = quadCurvedPath()

        UIColor.black.setStroke()
        path.lineWidth = 1
        path.stroke()
    }

    func quadCurvedPath() -> UIBezierPath {
        let path = UIBezierPath()
        let step = bounds.width / CGFloat(data.count - 1)

        var p1 = CGPoint(x: 0, y: coordYFor(index: 0))
        path.move(to: p1)

        drawPoint(point: p1, color: UIColor.red, radius: 3)

        if (data.count == 2) {
            path.addLine(to: CGPoint(x: step, y: coordYFor(index: 1)))
            return path
        }

        var oldControlP: CGPoint?

        for i in 1..<data.count {
            let p2 = CGPoint(x: step * CGFloat(i), y: coordYFor(index: i))
            drawPoint(point: p2, color: UIColor.red, radius: 3)
            var p3: CGPoint?
            if i < data.count - 1 {
                p3 = CGPoint(x: step * CGFloat(i + 1), y: coordYFor(index: i + 1))
            }

            let newControlP = controlPointForPoints(p1: p1, p2: p2, next: p3)

            path.addCurve(to: p2, controlPoint1: oldControlP ?? p1, controlPoint2: newControlP ?? p2)

            p1 = p2
            oldControlP = antipodalFor(point: newControlP, center: p2)
        }
        return path;
    }

    /// located on the opposite side from the center point
    func antipodalFor(point: CGPoint?, center: CGPoint?) -> CGPoint? {
        guard let p1 = point, let center = center else {
            return nil
        }
        let newX = 2 * center.x - p1.x
        let diffY = abs(p1.y - center.y)
        let newY = center.y + diffY * (p1.y < center.y ? 1 : -1)

        return CGPoint(x: newX, y: newY)
    }

    /// halfway of two points
    func midPointForPoints(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2);
    }

    /// Find controlPoint2 for addCurve
    /// - Parameters:
    ///   - p1: first point of curve
    ///   - p2: second point of curve whose control point we are looking for
    ///   - next: predicted next point which will use antipodal control point for finded
    func controlPointForPoints(p1: CGPoint, p2: CGPoint, next p3: CGPoint?) -> CGPoint? {
        guard let p3 = p3 else {
            return nil
        }

        let leftMidPoint  = midPointForPoints(p1: p1, p2: p2)
        let rightMidPoint = midPointForPoints(p1: p2, p2: p3)

        var controlPoint = midPointForPoints(p1: leftMidPoint, p2: antipodalFor(point: rightMidPoint, center: p2)!)

        if p1.y.between(a: p2.y, b: controlPoint.y) {
            controlPoint.y = p1.y
        } else if p2.y.between(a: p1.y, b: controlPoint.y) {
            controlPoint.y = p2.y
        }


        let imaginContol = antipodalFor(point: controlPoint, center: p2)!
        if p2.y.between(a: p3.y, b: imaginContol.y) {
            controlPoint.y = p2.y
        }
        if p3.y.between(a: p2.y, b: imaginContol.y) {
            let diffY = abs(p2.y - p3.y)
            controlPoint.y = p2.y + diffY * (p3.y < p2.y ? 1 : -1)
        }

        // make lines easier
        controlPoint.x += (p2.x - p1.x) * 0.1

        return controlPoint
    }

    func drawPoint(point: CGPoint, color: UIColor, radius: CGFloat) {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: point.x - radius, y: point.y - radius, width: radius * 1.5, height: radius * 1.5))
        color.setFill()
        ovalPath.fill()
    }

}

extension CGFloat {
    func between(a: CGFloat, b: CGFloat) -> Bool {
        return self >= Swift.min(a, b) && self <= Swift.max(a, b)
    }
}

