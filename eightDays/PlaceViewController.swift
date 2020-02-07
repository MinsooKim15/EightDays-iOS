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
    // TODO : 코드가 이해가 잘 안 된다ㅜ
    // 항상 안정적인 Place를 호출해야 한다.
    // Place 호출 시점은 속도가 가장 안 느려지는 시점을 찾자.
    // 임시 변수 다 날려
    
    //임시용 변수입니다. Firebase에 제대로 데이터 들어가면 삭제 필요함.
    var temp_exchange : Exchange?
    
    func makeTempRate()-> [Int]{
        //임시로 3달 기간 동안의 환율을 보여주는 가짜 데이터 리스트를 만들었습니다.
        // 매일 10원씩 오릅니다.(미쳤지요)
        // 하지만 한국을 믿으니 2500을 넘지 않아요
        var result:[Int] = []
        var counter = 1100
        for _ in 1...10 {
            result.append(counter)
            if counter <= 2500{
                counter += 10
            }
        }
        return result
    }
    //컴파일을 위해 일단 죄다 주석했습니다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //임시용 변수입니다. Firebase에 제대로 데이터 들어가면 삭제 필요함.
        let tempRate = makeTempRate()
        temp_exchange = Exchange(
            title: "환율이 치솟고 있어요.",
            description: "많이 비싼 상태에요. 환율이 계속 오르고 있어요.",
            exchangeRates: tempRate,
            todayRate: 3200,
            weekAgoRate: 2100,
            monthAgoRate: 1100
        )
        self.contentTableView.register(PlaceExchangeTableViewCell.self, forCellReuseIdentifier: "placeExchangeTableViewCell")
        self.contentTableView.register(PlaceFlightTableViewCell.self, forCellReuseIdentifier: "placeFlightTableViewCell")
        self.contentTableView.register(PlaceHotelTableViewCell.self, forCellReuseIdentifier: "placeHotelTableViewCell")
        //MARK: Firestore 관련 코드 in viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        contentTableView.dataSource = self
        contentTableView.delegate = self
        self.view.addSubview(closeButton)
        closeButton.anchor(top: self.view.topAnchor, left: nil, bottom: nil, right: self.view.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 17, width: 32, height: 32, enableInsets: false)
        print("Yeah")
        self.view.backgroundColor = .brightCyan
        print("Place 데이터 확인")
        print(place?.cellCount)
        print(place?.listOfUsefulData)
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
    
    var closeButton : CloseButton = {
        var button = CloseButton()
        button.frame = CGRect(x: 30, y: 30, width: 32, height: 32)
        button.backgroundColor = .gunmetal
        button.layer.cornerRadius = button.frame.height / 2.0
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc func closeButtonTapped(sender: UIButton!){
        performSegue(withIdentifier: "unwindToMainTableViewController", sender: sender)
    }
    
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
        print("너는 몇번 호출되니?")
        return (place?.cellCount ?? 0)+1 // 미리 Model에서 Cell에 필요한 데이터 개수를 카운트해둠.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row) == 0{
            let cell = getPlaceMainTableViewCell(indexPath: indexPath)
            return cell
        }else{
            switch (place?.listOfUsefulData?[indexPath.row - 1]){
            case is(Flight):
                let cell = getPlaceFlightTableViewCell(indexPath: indexPath)
                return cell
            case is(Exchange):
                let cell = getPlaceExchangeTableViewCell(indexPath: indexPath)
                return cell
            case is(Weather):
                let cell = getPlaceWeatherTableViewCell(indexPath: indexPath)
                return cell
            default:
                let cell = getPlaceWeatherTableViewCell(indexPath: indexPath)
                return cell
            }
            print("!!!!!!!!!!")
            print(indexPath.row)
            print(place?.listOfUsefulData?[indexPath.row])
            
        }
    }
    func getPlaceMainTableViewCell(indexPath: IndexPath)->PlaceMainTableViewCell{
        //PlaceMainTableViewCell을 만들어 주는 코드입니다.
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "placeMainTableViewCell", for: indexPath) as! PlaceMainTableViewCell
        if let place_ = self.place {
//            cell.populate(place:place_)
            cell.place = place_
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
    
    func getPlaceWeatherTableViewCell(indexPath:IndexPath)-> PlaceWeatherTableViewCell{
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "placeWeatherTableViewCell", for: indexPath) as! PlaceWeatherTableViewCell
        if let weather_ = self.place?.weather{
            //            cell.populate(weather:weather_)
            cell.weather = weather_
        }
        return cell
    }
    
    
    func getPlaceExchangeTableViewCell(indexPath: IndexPath) ->  PlaceExchangeTableViewCell{
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "placeExchangeTableViewCell", for: indexPath) as! PlaceExchangeTableViewCell
        print("printExchangeViewCell 호출")
        //TODO : populate 구현 후 해제
        print(self.place?.exchange)
        if let exchange_ = self.place?.exchange {
            print("일단 Exchange 데이터는 잘 들어있음")
            //            cell.populate(exchange:exchange_)
            cell.exchange = exchange_
            //            self.contentTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        }
        //        if let exchange_  = self.temp_exchange{
        //            cell.populate(exchange: exchange_)
        //        }
        return cell
    }
    func getPlaceFlightTableViewCell(indexPath: IndexPath) ->  PlaceFlightTableViewCell{
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "placeFlightTableViewCell", for: indexPath) as! PlaceFlightTableViewCell
        print("placeFlightTableViewCell실행")
        print(self.place?.flight)
        if let flight_  = self.place?.flight{
            //                cell.populate(flight: flight)
            cell.flight = flight_
        }
        return cell
    }
    func getPlaceHotelTableViewCell(indexPath: IndexPath) ->  PlaceHotelTableViewCell{
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "placeHotelTableViewCell", for: indexPath) as! PlaceHotelTableViewCell
        print("printHotelViewCell 호출")
        // TODO : populate 구현 후 해제
        //        if let exchange_ = self.place?.exchange{
        //            cell.populate(exchange:exchange_)
        //        }
        if let hotel  = self.place?.hotel{
            cell.populate(hotel: hotel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row) == 0{
            return CGFloat(461.3)
        }else{
            switch (place?.listOfUsefulData?[indexPath.row - 1]){
            case is(Flight):
                return CGFloat(220.0)
            case is(Exchange):
                return CGFloat(220.0)
            case is(Weather):
                return CGFloat(220.0)
            default:
                return CGFloat(220.0)
            }
            print("!!!!!!!!!!")
            print(indexPath.row)
            print(place?.listOfUsefulData?[indexPath.row])
            
        }
//        switch indexPath.row{
//        case 0:
//
//        case 1:
//            return
//        case 2:
//            return CGFloat(220.0)
//        case 3:
//            return CGFloat(330.0)
//        case 4:
//            return CGFloat(240.0)
//        default:
//            return CGFloat(220.0)
//        }
        
    }
    //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        if indexPath.row == 0{
    //            return CGFloat(461.3)
    //        }else{
    //            return CGFloat(349.7) // 여긴 수정 필요함
    //        }
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.barTintColor = .brightCyan
        self.navigationController?.navigationBar.isTranslucent = false
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        //        //First Visible Item
        //        print("처음은")
        //        print(self.contentTableView.indexPathsForVisibleRows?.first)
        if self.contentTableView.indexPathsForVisibleRows?.first != Optional([0,0]) && !self.closeButton.isBlack {
            print("어둡게")
            closeButton.isBlack = true
        }else if self.contentTableView.indexPathsForVisibleRows?.first == Optional([0,0]) && self.closeButton.isBlack{
            print("밝게")
            closeButton.isBlack = false
        }
        //        //Last visible item
        //        print("마지막은")
        //        print(self.contentTableView.indexPathsForVisibleRows?.last)
    }
    
    
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

class CloseButton : UIButton{
    
    var isBlack = false {
        didSet{
            print("바뀜!!")
            setNeedsDisplay()
            //            if self.isBlack{
            //                self.backgroundColor = .gunmetal
            //                self.line
            //            }else{
            //                self.backgroundColor = .veryLightPink80
            //            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        var path = UIBezierPath(ovalIn: rect)
        
        if isBlack {
            UIColor.gunmetal.setFill()
        }else{
            UIColor.veryLightPink80.setFill()
        }
        
        path.fill()
        let lineWidth: CGFloat = min(bounds.width, bounds.height) * 0.4
        let linePath = UIBezierPath()
        linePath.lineWidth = 2.5
        
        // - 선을 그립니다.
        linePath.move(to: CGPoint(
            x: (bounds.width / 2) - (lineWidth / 2),
            y: (bounds.height / 2) - (lineWidth / 2)))
        
        linePath.addLine(to: CGPoint(
            x: (bounds.width / 2) + (lineWidth / 2),
            y: (bounds.height / 2) + (lineWidth / 2)))
        
        linePath.move(to: CGPoint(
            x: (bounds.width / 2) - (lineWidth / 2),
            y: (bounds.height / 2) + (lineWidth / 2)))
        
        linePath.addLine(to: CGPoint(
            x: (bounds.width / 2) + (lineWidth / 2),
            y: (bounds.height / 2) - (lineWidth / 2)))
        if isBlack {
            UIColor.lightBlueGreyTwo.setStroke()
        }else{
            UIColor.greyishBrown.setStroke()
        }
        linePath.stroke()
    }
}
