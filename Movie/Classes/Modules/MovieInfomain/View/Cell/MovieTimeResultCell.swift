//
//  TheaterTimeResultCell.swift
//  Movie
//
//  Created by User on 2024/10/9.
//

import Reusable
import Kingfisher

class MovieTimeResultCell: TableViewCell, Reusable {
    
    var TypesDataSource = [TypesModel]()
    
    var TheaterName: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.darkGray
        tl.font = UIFont.systemFont(ofSize: 18)
        return tl
    }()
    
    public lazy var CollectionView: UICollectionView = { [weak self] in
        // 设置collectionView的布局
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        //flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        // 这里定义flowLayout的预估大小
        flowLayout.estimatedItemSize = CGSize(width: (.screenWidth - 20), height: 1)
        //flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize;
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TypesCell.self, forCellWithReuseIdentifier: "Cell")
        
        return collectionView
    }()
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        CollectionView.layoutIfNeeded()
        let collectionH = CollectionView.collectionViewLayout.collectionViewContentSize.height
        let height = size.height + collectionH
        return CGSize(width: size.width, height: height)
    }
    
    public var item: MovieTimeResultModel? {
        
        didSet {
            
            guard let item else { return }
            separatorInset = .zero
            
            //backgroundColor = UIColor.white
            
            contentView.addSubview(TheaterName)
            TheaterName.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.height.equalTo(30)
                $0.top.equalTo(10)
            }
            TheaterName.text = item.theater
            
            //CollectionView.backgroundColor = UIColor.orange
            //CollectionView.delegate = self
            //CollectionView.dataSource = self
            contentView.addSubview(CollectionView)
            
            CollectionView.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.top.equalTo(TheaterName.snp.bottom).offset(10)
                $0.width.equalTo(.screenWidth - 20)
                $0.bottom.equalToSuperview().offset(-10)
            }
            
            self.TypesDataSource = item.types
        }
    }
}

extension MovieTimeResultCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TypesDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TypesCell
        
        cell.style = "Movie"
        cell.item = TypesDataSource[indexPath.row]
        return cell
    }
}


