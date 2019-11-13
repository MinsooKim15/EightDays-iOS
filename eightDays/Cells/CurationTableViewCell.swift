//
//  curationTableViewCell.swift
//  eightDays
//
//  Created by minsoo kim on 2019/11/03.
//  Copyright © 2019 minsoo kim. All rights reserved.
//

import UIKit

class CurationTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    var delegate : MyCustomCellDelegator?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Collection View 구현을 위해 무조건 필요한
        self.curationCollectionView.dataSource = self
        self.curationCollectionView.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width:220, height:246)
        flowLayout.minimumLineSpacing = 5.0
//        flowLayout.minimumInteritemSpacing = 200.0
        self.curationCollectionView.collectionViewLayout = flowLayout
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
       }
    
    //Outlet 설정
   @IBOutlet weak var curationCollectionView: UICollectionView!
    
    @IBOutlet weak var curationTitle: UILabel!
    var placeList : [SmallPlace]?
    
    //TODO : populate 정의합시다.
    func populate(){
        // 테스트를 위한 populate이니, 잠시 유지했다가 삭제
        curationTitle.text = "특별한 여름을 위한 휴양지"
    }
    func populate(curation:Curation){
        self.curationTitle.text = curation.title
        self.placeList = curation.placeList! //밖에서 막을거야 없으면
    }
    
    
    // Collection View Delegate, Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.placeList?.count ?? 0
    }
    
    // TODO : 개수가 너무 적으면 좌우로 제대로 움직이지 않는 현상
    // TODO : 이미지는 마스크 밖으로 벗어나는 현상
    // TODO : 점수 사이즈 키우고 위치 조절하자
    // TODO : 제목과 콜렉션 뷰 그리드 시작 위치가 일치하도록 바꾸자
    
    //TODO : curation cell간 간격이 너무 좁아여.. 이거 수정해야 함.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "curationCollectionViewCell", for :indexPath) as! CurationCollectionViewCell
        if let placeList_  = self.placeList{
            cell.populate(smallPlace: placeList_[indexPath.row])
        }
        //코너 둥글게 만들기
        cell.clipsToBounds = true
        cell.layer.cornerRadius = min(cell.frame.size.height, cell.frame.size.width) / 10.0
        
//        /cell.layer.masksToBounds = true
        // 그림자를 만들자
//        cell.layer.cornerRadius = 15.0
//        cell.layer.borderWidth = 2.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false
        
        // Collection별로 Radius를 주자
        
        //Collection에 붙는
        cell.curationPlaceSubTitle.textColor = UIColor.steel
        cell.score.textColor = UIColor.darkSkyBlueTwo
        
        
        // 테스트를 위해 임시로 박아둔 백그라운드 컬러
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let placeList_  = self.placeList{
            print(self.delegate)
            self.delegate?.callSegueFromCell(myData: placeList_[indexPath.row])
        }
    }
}


class CollectionViewFlowLayout:UICollectionViewFlowLayout{
    override func prepare() {
        super.prepare()
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)
    }
}
