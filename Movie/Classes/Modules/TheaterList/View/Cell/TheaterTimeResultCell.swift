//
//  TheaterTimeResultCell.swift
//  Movie
//
//  Created by User on 2024/10/9.
//

import Reusable
import Kingfisher

class TheaterTimeResultCell: TableViewCell, Reusable {
    
    var TypesDataSource = [TypesModel]()
    
    var ReleaseFoto: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        iw.clipsToBounds = true
        return iw
    }()
    
    var TheaterListName: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.black
        return tl
    }()
    
    var Length: UILabel = {
        let sl = UILabel()
        sl.textColor = UIColor.gray
        sl.font = UIFont.systemFont(ofSize: 14)
        return sl
    }()
    
    var Icon: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        iw.clipsToBounds = true
        return iw
    }()
    
    public lazy var CollectionView: UICollectionView = { [weak self] in
        // 设置collectionView的布局
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        //flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        // 这里定义flowLayout的预估大小
        flowLayout.estimatedItemSize = CGSize(width: (.screenWidth - 130), height: 1)
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
    
    public var item: TheaterTimeResultModel? {
        
        didSet {
            
            guard let item else { return }
            separatorInset = .zero
            
            //backgroundColor = UIColor.white
            
            contentView.addSubview(ReleaseFoto)
            ReleaseFoto.snp.makeConstraints {
                $0.left.equalToSuperview().offset(10)
                $0.top.equalToSuperview().offset(10)
                $0.width.equalTo(100)
                $0.height.equalTo(143)
            }
            KF.url(URL(string: item.release_foto))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in  }
                .onSuccess { result in  }
                .onFailure { error in }
                .set(to: ReleaseFoto)
            
            contentView.addSubview(TheaterListName)
            TheaterListName.snp.makeConstraints {
                $0.left.equalTo(ReleaseFoto.snp.right).offset(10)
                $0.right.equalToSuperview().offset(-10)
                //$0.height.equalTo(30)
                $0.top.equalTo(10)
            }
            TheaterListName.text = item.theaterlist_name
            
            contentView.addSubview(Length)
            Length.snp.makeConstraints {
                $0.left.equalTo(ReleaseFoto.snp.right).offset(10)
                $0.right.equalToSuperview().offset(-10)
                //$0.height.equalTo(20)
                $0.top.equalTo(TheaterListName.snp.bottom).offset(10)
            }
            Length.text = item.length
            
            contentView.addSubview(Icon)
            Icon.snp.makeConstraints {
                $0.left.equalTo(ReleaseFoto.snp.right).offset(10)
                $0.width.equalTo(45)
                $0.height.equalTo(45)
                $0.top.equalTo(Length.snp.bottom).offset(10)
            }
            KF.url(URL(string: item.icon))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .onProgress { receivedSize, totalSize in  }
                .onSuccess { result in  }
                .onFailure { error in }
                .set(to: Icon)
            
            //CollectionView.backgroundColor = UIColor.orange
            //CollectionView.delegate = self
            //CollectionView.dataSource = self
            contentView.addSubview(CollectionView)
            
            CollectionView.snp.makeConstraints {
                $0.left.equalTo(ReleaseFoto.snp.right).offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.top.equalTo(Icon.snp.bottom).offset(10)
                $0.width.equalTo(.screenWidth - 130)
                $0.bottom.equalToSuperview().offset(-10)
            }
            
            self.TypesDataSource = item.types
        }
    }
}

extension TheaterTimeResultCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TypesDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TypesCell
        
        cell.style = "Theater"
        cell.item = TypesDataSource[indexPath.row]
        return cell
    }
}

