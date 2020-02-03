//
//  SettingTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/10.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func populate(setting:Setting){
        print("populate 동작 시작!")
        print(setting)
        self.settingTitle.text = setting.title
        if setting.havePage{
            self.moveButton.isHidden = false
            self.versionDescription.isHidden = true
        }else{
            self.moveButton.isHidden = true
            self.versionDescription.isHidden = false
            self.versionDescription.text =  (setting.currentVersion ?? "0") + "/" + (setting.recentVersion ?? "0")
        }
    }

    
    
    var settingTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .charcoalGrey
        lbl.font = .systemFont(ofSize: CGFloat(24))
        return lbl
    }()
    var versionDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkSkyBlueThree
        lbl.font = .systemFont(ofSize: CGFloat(18))
        return lbl
    }()
    var moveButton : MoveButton = {
        var button = MoveButton()
        button.frame = CGRect(x: 30, y: 30, width: 7, height: 24)
        button.layer.cornerRadius = button.frame.height / 2.0
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(moveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func moveButtonTapped(_ sender: Any) {

    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("Init은 되었다?")
        self.addSubview(settingTitle)
        self.addSubview(versionDescription)
        self.addSubview(moveButton)
        settingTitle.anchor(left: leftAnchor, right: nil, centerY: self.centerYAnchor,  paddingLeft: 42,  paddingRight: 0, width: 200, height: 29, enableInsets: false)
        moveButton.anchor(left: nil, right: rightAnchor, centerY: self.centerYAnchor,  paddingLeft: 0,  paddingRight: 20, width: 10, height: 24, enableInsets: false)
        //TODO : 버전 위치가 이상하긴 함ㅜ
        versionDescription.anchor(left: nil, right: rightAnchor, centerY: self.centerYAnchor,  paddingLeft: 0,  paddingRight: 20, width: 182, height: 21, enableInsets: false)
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
}

class MoveButton : UIButton{
    
    
    override func draw(_ rect: CGRect) {

        let linePath = UIBezierPath()
        linePath.lineWidth = 2.5
        
        // - 선을 그립니다.
        linePath.move(to: CGPoint(
            x: 0,
            y: 0))

        linePath.addLine(to: CGPoint(
            x: bounds.width - CGFloat(0.3),
            y: (bounds.height / 2)))

        linePath.addLine(to: CGPoint(
                x: 0,
                y: bounds.height))
        UIColor.gunmetal.setStroke()
        linePath.stroke()
    }
}
