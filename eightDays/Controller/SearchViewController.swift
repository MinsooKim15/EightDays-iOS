//
//  SearchViewController.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/10.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

// 검색 화면을 구현하는 Controller 입니다.

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 요 것도 메소드로 뺄 수 있는지 보자
        self.searchTextField.delegate = self
        // Do any additional setup after loading the view.
        settingTextField()
    }
    func settingTextField(){
        self.searchTextField.becomeFirstResponder()
        self.searchTextField.text = "가고 싶은 곳을 찾아보세요."
        self.searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    //TODO : FireStore 검색기 만듭시다. 이거 어려울 것 같은데..
    
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    @IBAction
    func textFieldDidChange(_ textField:UITextField){
        print(textField.text ?? "없음")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return 키 누름 성공")
        textField.resignFirstResponder()
        print("dismiss성공")
        return true
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
