//
//  MainTableViewController.swift
//  eightDays
//
//  Created by minsoo kim on 2019/10/27.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SDWebImage

class MainTableViewController: UITableViewController, MyCustomCellDelegator {
    
    //TODO: 스크롤할때마다 메소드들이 우수수 재실행됨..
    //TODO: 갑자기 getdocument 실행 없이 cell들이 실행되어서, places가 빈값이 되어버림 해결하자
    var db: Firestore!
    
    // MARK : View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        getMainPlace()
        setNavigationBar()
        getCuration()
        self.tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none

    }
    
    //Navigation Bar 기본 설정을 위한 메소드
    func setNavigationBar(){
        //여기부터 밑에는 navigation controller와 관련된 무엇인가를 테스트해보는 곳 입니다.
        self.navigationItem.title = "8 Days"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        
        //네비게이션 바 밑의 선을 없애기 위한 코드
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
//        //TODO : Search Button이 들어와야 할 자리임.
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(searchTapped))
        // 일단 없앱니다. -> 고도화시 검색 기능 추가하기
        //TODO : Setting Button이 들어와야 할 자리임.
//        self.view.addSubview(backButton)
//        self.navigationItem.rightBarButtonItem.target
//        UIBarButtonItem(barButtonSystemItem: NavButton, target: self, action: #selector(settingTapped))
        //TODO : 개선 시점에 아래 코드 주석 해제
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationController?.navigationBar.barTintColor = .brightCyan
        self.navigationController?.navigationBar.isTranslucent = false
    }
    //Cell에서 요청하는 Segueway처리
    func callSegueFromCell(myData dataobject: Any?) {
        print("controller로 잘 넘어옴")
        self.performSegue(withIdentifier: "ContentSegue", sender: dataobject)
    }
    
    lazy var backButton: NavButton = {
//        let button = NavButton(frame: CGRect(x: 0, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: 100))
        let button = NavButton()
        button.addTarget(self, action: #selector(settingTapped), for: .touchUpInside)
        return button
    }()

    //Navigation Bar Button 클릭시 세그웨이
    @objc
    func searchTapped(sender:UIBarButtonItem){
        performSegue(withIdentifier: "SearchSegue", sender: sender)
    }
    @objc
    func settingTapped(sender:UIBarButtonItem){
        print("Setting Tapped")
        performSegue(withIdentifier: "SettingSegue", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ContentSegue"){
            if let senderPlace = sender as? Place {
                let destView = segue.destination as! PlaceViewController
                destView.place = senderPlace
            }else if let senderSmallPlace = sender as? SmallPlace{
                let destView = segue.destination as! PlaceViewController
                destView.smallPlace = senderSmallPlace
            }
        }
    }
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue){
        
    }
    
    
    override func viewDidAppear(_ animated:Bool){
        super.viewDidAppear(animated)
        //        getDocument()
        //        observeQuery()
        // 막상 필요가 없네
    }
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        //        stopObserving()
    }
    
    
    //MARK: Firestore Query
    
    
    private var places: [Place] = []
    private var documents : [DocumentSnapshot] = []
    private var curations : [Curation] = []
    
    func addDocument(){
        print("add Document")
        db.collection("place").addDocument(data: [
            "first": "Alan",
            "middle": "Mathison",
            "last": "Turing",
            "born": 1912
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
            }
        }
    }
    @IBAction func unwindMainTableViewController1 (segue : UIStoryboardSegue) {}
    
    func getMainPlace(){
        //MARK : place 콜렉션에서 가장 score 높은 것 하나만 뽑는다.
        print("getDocument")
        let placeRef = db.collection("place")
        placeRef.order(by: "score", descending: true).limit(to: 1).getDocuments(){(querySnapshot, err) in
            if let err = err{
                print("Error getting documents: \(err)")
            }else{
                for item in querySnapshot!.documents{
                    print(item.data()["titleKor"])
                    print(item.data()["score"])
                    print(item.data()["weather"])
                    print(item.data()["flight"])
                    print(item.data()["exchange"])
                }
//                print(querySnapshot!.documents[0].data()["titleKor"])
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
            self.tableView.reloadData()
        }
    }
    func getCuration(){
        print("getCurations")
        let curationRef = db.collection("curation")
        curationRef.order(by:"rank", descending: false).limit(to:1)
        curationRef.getDocuments(){(querySnapshot, err) in
            
            if let err = err{
                print("Error getting documents: \(err)")
            }else{
                print("==================")
                print(querySnapshot!.documents[0].data())
                print("==================")
                let models = querySnapshot!.documents.map{
                    (document) -> Curation in if let model = Curation(dictionary: document.data()){
                        return model
                    }else{
                        fatalError("Unable to initialize type \(Curation.self) with dictionary")
                    }
                }
                print(models)
                self.curations = models
                self.curations = self.getRandomCuration(from: self.curations, get: 5)

                // for 문으로 nsarray를 place화
                for (index,_) in self.curations.enumerated() {
                    self.curations[index].arrayToSmallPlace()
                }
                print("변환 결과")
                print(self.curations[0].placeList!)
                print(self.curations[0].hasConverted)

            }
        }
    }
    func getRandomCuration(from curations:[Curation], get limits:Int) -> [Curation]{
        print("Random Number")
        let sequence = 0 ..< self.curations.count
        let shuffledSequence = sequence.shuffled()
        var result: [Curation] = []
        for i in shuffledSequence[0...(limits - 1)]{
            result.append(curations[i])
        }
        return result
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // curation list 개수와 고정으로 하나있는 main table view cell
        return (curations.count + 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //아직 안 만들었는데, 요거 좋은 거 같아 한 줄로 데이터 밀어 넣고, 실제 데이터 받아내는 메소드는 cell에서 구현하기
        //        print("안녕 프린트는 잘 된단다")
        print(places.count)
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: indexPath) as! MainTableViewCell
            // 아래는 첫 셀에 gradient를 입히는 코드입니다.
            // 이것도 따로 메소드화 해야 하는데, cell이 이 내부에만 정의되는 것이어서, 어떻게 해야 할지 감이 없네요.
            let gradient: CAGradientLayer = CAGradientLayer()
            
            gradient.colors = [UIColor.brightCyan.cgColor, UIColor.darkSkyBlue.cgColor]
            gradient.locations = [0.0 , 0.5]
            gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width,
                                    height: self.view.frame.size.height)
            
            cell.layer.insertSublayer(gradient, at: 0)
            // 이 위까지요.
            cell.delegate = self
            print(indexPath.row)
            if let place_ = places[0] as? Place{
                cell.place = place_
                print(cell.place?.title_kor)
            }
//            cell.populate(place:place)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "curationTableViewCell", for : indexPath) as! CurationTableViewCell
            let curation_ = curations[indexPath.row - 1]
            
            cell.curation = curation_

//            cell.populate(curation:curation)
            cell.delegate = self
            cell.curationCollectionView.reloadData()
            return cell
        }
        
    }
    func makeGradient(){
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return CGFloat(400)
//            return CGFloat(461.3)
        }else{
            return CGFloat(349.7)
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}



//이 밑에 코드들은 snapshot과 listener를 사용하려다 실패한 내용들임.
//나중에 조금 더 realtime이 필요할때 다시 보자(그런 내용이 아닐 수도 있음)
//멍청하게 google-service-info.plist를 잘못 찍은 거 였어 이런 실수 아니었으면 됐을지도 모름.
//   private var listener: ListenerRegistration?
//
//    fileprivate func observeQuery(){
//        print("observe Query")
//        guard let query = query else {return}
//        stopObserving()
//        listener = query.addSnapshotListener {
//            [unowned self] (snapshot, error) in
//            guard let snapshot = snapshot else{
//                print("Error fetching snapshot results: \(error!)")
//                return
//            }
//            print("일단 요 안으로는 들어왔지")
//            let models = snapshot.documents.map{
//                (document) -> Place in if let model = Place(dictionary: document.data()){
//                return model
//            } else {
//                fatalError("Unable to initialize type \(Place.self) with dictionary")
//            }
//            }
//            print(self.places)
//            self.places = models
//            self.documents = snapshot.documents
//            //분명 쓸모가 있을 거야 그 때 주석해제 고민해보자 FriendlyEats에 있던 내용임.
////            if self.documents.count > 0 {
////                self.tableView.backgroundView = nil
////            }else{
////                self.tableView.backgroundView = self.backgroundView
////            }
//            self.tableView.reloadData()
//        }
//    }
//    func stopObserving(){
//        print("stopObserving")
//        listener?.remove()
//    }
//
//fileprivate var query: Query? {
//    didSet{
//        if let listener = listener{
//            listener.remove()
//            observeQuery()
//        }
//    }
//}
//fileprivate func baseQuery() -> Query{
//    print("baseQuery")
//    let firestore: Firestore = Firestore.firestore()
//    return firestore.collection("place").limit(to : 1)
//}
extension UIColor {
    
    @nonobjc class var orangeyRed: UIColor {
        return UIColor(red: 1.0, green: 59.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var warmBlue: UIColor {
        return UIColor(red: 88.0 / 255.0, green: 86.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var reddishPink: UIColor {
        return UIColor(red: 1.0, green: 45.0 / 255.0, blue: 85.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var tangerine: UIColor {
        return UIColor(red: 1.0, green: 149.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var robinSEgg: UIColor {
        return UIColor(red: 90.0 / 255.0, green: 200.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deepSkyBlue: UIColor {
        return UIColor(red: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var weirdGreen: UIColor {
        return UIColor(red: 76.0 / 255.0, green: 217.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var marigold: UIColor {
        return UIColor(red: 1.0, green: 204.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var paleGrey: UIColor {
        return UIColor(red: 239.0 / 255.0, green: 239.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var paleLilac: UIColor {
        return UIColor(red: 229.0 / 255.0, green: 229.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightBlueGrey: UIColor {
        return UIColor(red: 209.0 / 255.0, green: 209.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var blueGrey: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var brightCyan: UIColor {
        return UIColor(red: 91.0 / 255.0, green: 241.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var darkSkyBlue: UIColor {
        return UIColor(red: 78.0 / 255.0, green: 140.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var steel: UIColor {
        return UIColor(red: 126.0 / 255.0, green: 126.0 / 255.0, blue: 130.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var darkSkyBlueTwo: UIColor {
        return UIColor(red: 79.0 / 255.0, green: 143.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var charcoalGrey: UIColor {
        return UIColor(red: 68.0 / 255.0, green: 75.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var gunmetal: UIColor {
      return UIColor(red: 84.0 / 255.0, green: 85.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var veryLightPink80: UIColor {
      return UIColor(white: 242.0 / 255.0, alpha: 0.8)
    }
    @nonobjc class var greyishBrown: UIColor {
       return UIColor(red: 72.0 / 255.0, green: 58.0 / 255.0, blue: 58.0 / 255.0, alpha: 1.0)
     }
    @nonobjc class var lightBlueGreyTwo: UIColor {
      return UIColor(red: 207.0 / 255.0, green: 207.0 / 255.0, blue: 208.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var darkSkyBlueThree: UIColor {
      return UIColor(red: 79.0 / 255.0, green: 144.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0)
    }
}

