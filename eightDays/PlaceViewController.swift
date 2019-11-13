//
//  PlaceViewController.swift
//  
//
//  Created by minsoo kim on 2019/11/10.
//

import UIKit
import UIKit
import FirebaseFirestore
import SDWebImage

class PlaceViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
   
    //컴파일을 위해 일단 죄다 주석했습니다.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Firestore 관련 코드 in viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        contentTableView.dataSource = self
        contentTableView.delegate = self
        // Do any additional setup after loading the view.
    }
//
//    //MARK : TableView 관련 코드
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//           return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.table
//           return cell
//    }
    
    // MARK : Firestore 관련 코드
    var db: Firestore!
    var places : [Place]?
    var place : Place?{
        didSet{
            //Place가 넘어오면, 그대로 셀을 채웁니다.
            print("Place가 잘 넘어왔습니다.")
        }
    }
    var smallPlace : SmallPlace?{
        didSet{
            //smallPlace가 넘어오면 Referenece로 firestore를 찌릅니다.
            print("smallPlace가 잘 넘어왔습니다.")
        }
    }
    
    func getMainPlace(byId title : String){
            //MARK : place 콜렉션에서 가장 score 높은 것 하나만 뽑는다.
            print("getDocument")
        let placeRef = db.collection("place")
//            placeRef.order(by: "score", descending: true).limit(to: 1)
        placeRef.whereField("title_eng", isEqualTo: title)
            placeRef.getDocuments(){(querySnapshot, err) in

                if let err = err{
                    print("Error getting documents: \(err)")
                }else{
                    let models = querySnapshot!.documents.map{
                        (document) -> Place in if let model = Place(dictionary: document.data()){
                            return model
                        } else {
                            fatalError("Unable to initialize type \(Place.self) with dictionary")
                        }
                    }
                    print(models)
                    self.places = models
                }
                print("done")
//                self.tableView.reloadData()
            }
        }
    func getMainPlace(byTitle: String){
//        print("")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (place?.hasOpDescription ?? false){
            // opDescription이 따로 있다면, 그 내용을 위한 Row를 하나 늘린다.
            return 5
        }else{
            // 그 외에는 비우는 경우 없이 채운다.
            return 4
        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (place?.hasOpDescription ?? false){
            print("운영 값이 있는 경우는 Model부터 새로 짜야 해ㅜ")
            let cell = getPlaceMainTableViewCell(indexPath: indexPath)
            return cell
        }else{
            switch indexPath.row {
            case 0:
                let cell = getPlaceMainTableViewCell(indexPath: indexPath)
                return cell
                
            default:
                let cell = getPlaceMainTableViewCell(indexPath: indexPath)
                return cell
            }
        }
    }
    func getPlaceMainTableViewCell(indexPath: IndexPath)->PlaceMainTableViewCell{
        //PlaceMainTableViewCell을 만들어 주는 코드입니다.
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "placeMainTableViewCell", for: indexPath) as! PlaceMainTableViewCell
        if let place_ = self.place {
            cell.populate(place:place_)
        }
        // 여기까지가 데이터를 입히는 코드
        // 이 밑에는 그라데이션 넣는 코드
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.brightCyan.cgColor, UIColor.darkSkyBlue.cgColor]
        gradient.locations = [0.0 , 0.5]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width:  self.view.frame.size.width,
                                height: self.view.frame.size.height)
        cell.layer.insertSublayer(gradient, at: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return CGFloat(461.3)
        }else{
            return CGFloat(349.7) // 여긴 수정 필요함
        }
    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0{
//            return CGFloat(461.3)
//        }else{
//            return CGFloat(349.7) // 여긴 수정 필요함
//        }
//    }
    
    
    @IBOutlet weak var contentTableView: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
