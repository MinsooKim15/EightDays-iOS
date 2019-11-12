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

class PlaceViewController: UIViewController {
   
    //컴파일을 위해 일단 죄다 주석했습니다.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Firestore 관련 코드 in viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
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
    var place : Place?
    
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
