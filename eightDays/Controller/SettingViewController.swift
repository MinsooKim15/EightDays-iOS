//
//  SettingViewController.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/10.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var settingList = [Setting]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.settingTableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingTableViewCell
        let setting = settingList[indexPath.row]
        cell.populate(setting:setting)
        return cell
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
