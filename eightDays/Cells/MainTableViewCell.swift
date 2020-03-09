//
//  MainTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/10/27.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit
import AlamofireImage
import MBCircularProgressBar
import Firebase

protocol MyCustomCellDelegator {
    func callSegueFromCell(myData dataobject: Any?)
    
}


class MainTableViewCell: UITableViewCell{
    var delegate : MyCustomCellDelegator!
    
    
    //190CGRect(x :, size: CGSize(width : CGFloat(100), height: CGFloat(100)))
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib 실행")
        // setGradientBackground()
        // 줄 바꿈은 단어 단위로..?( 더 해보고 변경 필요하면 바꾸자)
        setImageView()
        // let colorTop =  UIColor.brightCyan
        // let colorBottom = UIColor.darkSkyBlue
        //
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.frame = self.bounds
//        self.layer.insertSublayer(gradientLayer, at:0)
//
        // Label을 생성해서 cellImageView의 가운데에 두는 일은 아래의 메소드에서 합니다.
        adjustLabelToImage()
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        cellImageView.isUserInteractionEnabled = true
        cellImageView.addGestureRecognizer(tap)
        layoutIfNeeded()
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer){
        print("잘 탭되었어요")
        print(self.delegate)
//        if (self.delegate != nil){
            print("델리게이트도 정상")
            self.delegate.callSegueFromCell(myData: self.place!)
//        }
    }
    
    lazy private var scoreLabel: UILabel! = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: CGFloat(30))
        return lbl
    }()
    
    lazy private var titleEngLabel: UILabel! = {
        let lbl = UILabel()
        lbl.textAlignment = .center
//        lbl.text = "boracay"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: CGFloat(30))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    func adjustLabelToImage(){
        //TODO : font 변경해야 함.
        //mainViewOrigin은 어차피 constraint 설정 때문에 필요없을 것 같은데.. 일단 두자
        
        
        self.cellImageView.addSubview(titleEngLabel)

        
        //TODO : 일단 가운데에 두기는 했는데, 아직 이쁘지 않아 해결하자
        //TODO : 그래프로 감싸기
        
        //참고:  요 밑에 코드를 써서 가운데로 맞추려고 했는데, 실패했음ㅜ
        // label.centerXAnchor.constraint(equalTo: self.cellImageView.centerXAnchor).isActive = true
        // label.centerYAnchor.constraint(equalTo: self.cellImageView.centerYAnchor).isActive = true
        
    
        // 요 아래 코드의 의미를 알아야, imageView 안에 score를 넣을 텐데..
        // 요 위에 코드는 건들지 맙시다. 절대로(95% 성공전까지)
        
        
        
        
        
//        newLabel.backgroundColor = .black
        self.cellImageView.addSubview(scoreLabel)
        // 여기까지가 newLabel 정의 구간.
        
        
        let titleEngLabelCenterXConstraint = NSLayoutConstraint(item: titleEngLabel, attribute: .centerX, relatedBy: .equal, toItem: self.cellImageView, attribute: .centerX, multiplier: 1, constant: 0)
        let scoreLabelCenterXConstraint = NSLayoutConstraint(item: scoreLabel, attribute: .centerX, relatedBy: .equal, toItem: self.cellImageView, attribute: .centerX, multiplier: 1, constant: 0)
        
        
        let labelCenterYConstraint = NSLayoutConstraint(item: titleEngLabel, attribute: .centerY, relatedBy: .equal, toItem: self.cellImageView, attribute: .bottom, multiplier: 0.4, constant: 0)
        let scoreLabelcenterYConstraint = NSLayoutConstraint(item: scoreLabel, attribute: .centerY, relatedBy: .equal, toItem: self.cellImageView, attribute: .bottom, multiplier: 0.65, constant: 0)
        
        
        let labelWidthConstraint = NSLayoutConstraint(item: titleEngLabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        let scoreLabelwidthConstraint = NSLayoutConstraint(item: scoreLabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        
        let titleEngLabelHeightConstraint = NSLayoutConstraint(item: titleEngLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        let scoreLabelHeightConstraint = NSLayoutConstraint(item: scoreLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        

        self.cellImageView.addConstraints([
            titleEngLabelCenterXConstraint,
            labelCenterYConstraint,
            labelWidthConstraint,
            titleEngLabelHeightConstraint
        ])
        self.cellImageView.addConstraints([
            scoreLabelCenterXConstraint,
            scoreLabelcenterYConstraint,
            scoreLabelwidthConstraint,
            scoreLabelHeightConstraint
        ])
        self.cellImageView.layoutIfNeeded()
        
        
    
        
        // 요 아래의 전체 코드는 Hawai'i 센터 정렬이 정상 동작할 때 쓰던 코드입니다.
        // 코드에 손을 대다보니 이런 백업을 해두었는데, 급할 때 쓰세요.
        
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        let centerXConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self.cellImageView, attribute: .centerX, multiplier: 1, constant: 0)
//        let centerYConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self.cellImageView, attribute: .centerY, multiplier: 1, constant: 0)
//        let widthConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
//        let heightConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
//
//        self.cellImageView.addConstraints([centerXConstraint, centerYConstraint, widthConstraint, heightConstraint])
//        self.cellImageView.layoutIfNeeded()
//
        
        
    }
    
    
    func setImageView(){
        // 이미지 뷰의 사이즈를 fit하게 하고, 둥글게 만드는 코드 모음
        self.cellImageView.contentMode = .scaleAspectFill
        self.cellImageView.layer.cornerRadius = self.cellImageView.frame.size.width/2
        // 여기는 이미지를 조금 dim 처리하자
        let coverLayer = CALayer()
        coverLayer.frame = self.cellImageView.bounds;
        coverLayer.backgroundColor = UIColor.black.cgColor
        coverLayer.opacity = 0.2
        self.cellImageView.layer.addSublayer(coverLayer)
    
    }
    func setScoreRound () {
        
        // 아래의 코드를 쓰면, imageview 안에 동그라미를 채울 수 있고 쉽게 비율에 따라 조절도 가능하지만
        // 이미지 안을 채우게 되어서 조금 안 이쁨. 이미지 밖을 두를 수 있어야 하는데, 그건 나중에 하자
        // instagram 동그라미 그리는 법 찾으면 나올 것 같음.
        // round view
        
        // bezier path
        print("여기는 Cell")
        print(self)
        print("여기는 cellImageView")
        print(self.cellImageView)
        let circlePath = UIBezierPath(arcCenter: CGPoint (x: self.cellImageView.frame.size.width / 2, y: self.cellImageView.frame.size.height / 2),
                                      radius: self.cellImageView.frame.size.width / 2,
                                      startAngle: CGFloat(-0.5 * .pi),
                                      endAngle: CGFloat(1.5 * .pi),
                                      clockwise: true)
        // circle shape
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        circleShape.strokeColor = UIColor.white.cgColor
        circleShape.fillColor = UIColor.clear.cgColor
        circleShape.lineWidth = 10.0
        // set start and end values
        circleShape.strokeStart = 0.0
        circleShape.strokeEnd = CGFloat(CGFloat(self.place?.score ?? 0)/CGFloat(100))

        // add sublayer
        self.cellImageView.layer.addSublayer(circleShape)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setGradientBackground() {
//        let colorTop =  UIColor.brightCyan
//        let colorBottom = UIColor.darkSkyBlue
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.frame = self.bounds
//        self.layer.insertSublayer(gradientLayer, at:0)
//    }
    

    
    @IBOutlet weak var cellImageView: UIImageView!{
        didSet{
            print("실행")
        }
    }
    
    @IBOutlet weak var cellTitle: UILabel!
    var place : Place?{
        didSet{
//          self.scoreInt = place.score
            print("place var 실행")
            if cellImageView != nil{
                setScoreRound()
            }
            scoreLabel.text = String(place?.score ?? 0) + "%"
//            cellDescription.text = place?.description
            titleEngLabel.text = place?.title_eng
            titleEngLabel.adjustsFontSizeToFitWidth = true
            cellTitle.text = "베스트\n여행 점수"
//            cellTitle.adjustsFontSizeToFitWidth = true
            let placeholderImage = UIImage(named: "boracay")!
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let islandRef = storageRef.child(place?.img_url ?? "a.jpg")
            islandRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                            // Uh-oh, an error occurred!
                } else {
                            // Data for "images/island.jpg" is returned
                    self.cellImageView.image = UIImage(data: data!)
                    }
                }
        }
        
    }
    
    func populate(place : Place){
            }
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imageView?.image = UIImage(data: data)
//                self.
            }
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
