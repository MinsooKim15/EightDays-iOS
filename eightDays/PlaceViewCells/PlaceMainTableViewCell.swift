//
//  PlaceMainTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/10.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class PlaceMainTableViewCell: UITableViewCell {
    //TODO: 얘도 다 코드로 바꾸자(Storyboard 남기지 말기)
    //TODO : 이거 Populate를 Place로 바꾸고 있고, 특히 Score 다루기가 깔끔하게 안되고 있음 해결해보자
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cellDescription.lineBreakMode = .byWordWrapping
        self.cellDescription.textColor = .white
        print("awakeFromNib 실행")
        setImageView()
        adjustLabelToImage()
        if let _ = self.scoreInt{
            setScoreRound()
        }

    }
    var place : Place? {
        didSet{
            print("place didSet 실행")

//            self.scoreInt = place.score
            print("Place가 시작되었나")
            self.scoreLabel.text = String(place?.score ?? 0) + "%"
            setScoreRound()
            // MainTableView에서는 Place를 잘 들고 있는게 중요했지만, 얘는 아닙니다.
                    //            self.place = place
            cellDescription.text = place?.description
            titleEngLabel.text = place?.title_eng
            let placeholderImage = UIImage(named: "boracay")!
            // 아래는 만약 URL이 비어있을 때 특정 PlaceHolder를 채우기 위한 코드입니다.
            if let imageUrl  = place?.img_url as? String {
                let image_ = URL(string: imageUrl)
                print(image_)
                print("이미지 불러오기 시작")
                            
                cellImageView.af_setImage(withURL: image_!, placeholderImage : placeholderImage)
            }else{
                cellImageView = UIImageView(image:placeholderImage)
            }
//            setScoreRound()
        }
    }
    
    lazy private var scoreLabel: UILabel! = {
        let score = UILabel()
        score.textAlignment = .center
        score.text = "95%"
        score.textColor = .white
        score.translatesAutoresizingMaskIntoConstraints = false
        score.font = .systemFont(ofSize: CGFloat(30))
        return score
    }()
    
    lazy private var titleEngLabel : UILabel! = {
        let lbl = UILabel()
//        lbl = UILabel()
//        label = UILabel(frame: CGRect(origin: mainViewOrigin, size: CGSize(width: 100, height: 100)))
        lbl.textAlignment = .center
        lbl.text = "boracay"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: CGFloat(30))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    func adjustLabelToImage(){
        //TODO : font 변경해야 함.
        //mainViewOrigin은 어차피 constraint 설정 때문에 필요없을 것 같은데.. 일단 두자

        
                
        
        //TODO : 일단 가운데에 두기는 했는데, 아직 이쁘지 않아 해결하자
        //TODO : 그래프로 감싸기
        
        //참고:  요 밑에 코드를 써서 가운데로 맞추려고 했는데, 실패했음ㅜ
        // label.centerXAnchor.constraint(equalTo: self.cellImageView.centerXAnchor).isActive = true
        // label.centerYAnchor.constraint(equalTo: self.cellImageView.centerYAnchor).isActive = true
        
        
        // 요 아래 코드의 의미를 알아야, imageView 안에 score를 넣을 텐데..
        // 요 위에 코드는 건들지 맙시다. 절대로(95% 성공전까지)
    
//        let newLabel = UILabel(frame: CGRect(origin: mainViewOrigin, size: CGSize(width:100, height : 100)))
//        newLabel.textAlignment = .center
//        newLabel.text = "95%"
//        newLabel.textColor = .white
//        newLabel.translatesAutoresizingMaskIntoConstraints = false
//        newLabel.font = .systemFont(ofSize: CGFloat(30))
        //        newLabel.backgroundColor = .black
        
        // 여기까지가 newLabel 정의 구간.
        self.cellImageView.addSubview(scoreLabel)
        self.cellImageView.addSubview(titleEngLabel)

        
        let titleEngCenterXConstraint = NSLayoutConstraint(item: titleEngLabel, attribute: .centerX, relatedBy: .equal, toItem: self.cellImageView, attribute: .centerX, multiplier: 1, constant: 0)
        let scoreCenterXConstraint = NSLayoutConstraint(item: scoreLabel, attribute: .centerX, relatedBy: .equal, toItem: self.cellImageView, attribute: .centerX, multiplier: 1, constant: 0)
        
        
        let titleEngCenterYConstraint = NSLayoutConstraint(item: titleEngLabel, attribute: .centerY, relatedBy: .equal, toItem: self.cellImageView, attribute: .bottom, multiplier: 0.4, constant: 0)
        let scoreCenterYConstraint = NSLayoutConstraint(item: scoreLabel, attribute: .centerY, relatedBy: .equal, toItem: self.cellImageView, attribute: .bottom, multiplier: 0.65, constant: 0)
        
        
        let titleEngWidthConstraint = NSLayoutConstraint(item: titleEngLabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        let scoreWidthConstraint = NSLayoutConstraint(item: scoreLabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        
        let titleEngHeightConstraint = NSLayoutConstraint(item: titleEngLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        let scoreHeightConstraint = NSLayoutConstraint(item: scoreLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        
        self.cellImageView.addConstraints([
            titleEngCenterXConstraint,
            titleEngCenterYConstraint,
            titleEngWidthConstraint,
            titleEngHeightConstraint
        ])
        self.cellImageView.addConstraints([
            scoreCenterXConstraint,
            scoreCenterYConstraint,
            scoreWidthConstraint,
            scoreHeightConstraint
        ])
        
        
        self.cellImageView.layoutIfNeeded()
    
        
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
        // 얘는 혼자 View didload가 아니라, scoreInt가 didSet시점에 부릅니다.
        
        // 아래의 코드를 쓰면, imageview 안에 동그라미를 채울 수 있고 쉽게 비율에 따라 조절도 가능하지만
        // 이미지 안을 채우게 되어서 조금 안 이쁨. 이미지 밖을 두를 수 있어야 하는데, 그건 나중에 하자
        // instagram 동그라미 그리는 법 찾으면 나올 것 같음.
        // round view
        print("setScoreRound 시작")
        // bezier path
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
    
    //MARK : 변수 몰아서 정의
    var scoreInt : Int?{
        didSet{
            print("scoreInt설정됨")
            setScoreRound()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
//    func populate(place : Place){
//        self.scoreInt = place.score
//        // MainTableView에서는 Place를 잘 들고 있는게 중요했지만, 얘는 아닙니다.
//        //            self.place = place
//        cellDescription.text = place.description
//        label.text = place.title_eng
//        let placeholderImage = UIImage(named: "boracay")!
//        // 아래는 만약 URL이 비어있을 때 특정 PlaceHolder를 채우기 위한 코드입니다.
//        if let imageUrl  = place.img_url as? String {
//                let image_ = URL(string: imageUrl)
//                print(image_)
//                print("이미지 불러오기 시작")
//
//                cellImageView.af_setImage(withURL: image_!, placeholderImage : placeholderImage)
//        }else{
//            cellImageView = UIImageView(image:placeholderImage)
//        }
////        cellImageView.setIm
//        //        self.layoutSubviews()
//        //        cellImageView.downloaded(from: place.img_url)
//    }
    
    //TODO : Weak를 삭제했음 자동 dealloc을 해결하려고 - 문제 있을지 보자
    @IBOutlet var cellImageView: UIImageView!
    @IBOutlet weak var cellDescription: UILabel!
    
    
    
    
}
