//
//  SettingViewController.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/10.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var settingList : [Setting] = {
//
//        return settingList
//    }()
    var settingList : [Setting]?{
        didSet{
            loadViewIfNeeded()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.delegate = self
        settingTableView.dataSource = self
        print("settingViewController생성")
        self.settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "settingTableViewCell")
        populateSettingList()
    }
    
    //TODO : 릴리즈 된 후에는 최신 버전을 받을 수 있는 방법을 알아 보자
    //TODO : 자료형식을 정리해서 더 model로 보낼 수 없을까?
    
    func populateSettingList(){
        settingList = [
                    Setting(title: "공지사항", havePage: true),
                    Setting(
                        title: "앱 버전",
                        havePage: false,
                        currentVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                        recentVersion: "2.3.444"),
                    Setting(title: "오픈소스 라이선스", havePage: true),
                    Setting(title: "개인정보처리방침",havePage:true),
                    Setting(title: "개발자 정보", havePage: true)
                ]
    }
    
    
    @IBOutlet weak var settingTableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let settingList = settingList {
            print(settingList.count)
            print("얘는 왜 여러번 호출될까")
            return settingList.count
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("height For Row at")
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("얘는 왜 호출되지 않는가")
        if let settingList = settingList {
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "settingTableViewCell", for: indexPath) as! SettingTableViewCell
            let setting = settingList[indexPath.row]
            cell.populate(setting:setting)
            print("cell 동작!")
            print(indexPath.row)
            return cell
        }else{
            let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "settingTableViewCell", for: indexPath) as! SettingTableViewCell
//            let setting = settingList[indexPath.row]
//            cell.populate(setting:setting)
            print("cell 동작!")
            print(indexPath.row)
            return cell
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


struct Setting {
    var title : String
    var havePage: Bool
    var currentVersion : String?
    var recentVersion : String?
}
