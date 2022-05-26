//
//  TheaterListController.swift
//  Movie
//
//  Created by Mac on 2022/4/1.
//

import UIKit

class TheaterListController: UIViewController {
    
    private var comicList = [[String:String]]()
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.white
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        tw.register(cellType: theaterCell.self)
        return tw
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
    }
    
    convenience init(area: String ,comicList: [[String:String]]) {
        self.init()
        title = area
        self.comicList = comicList
        print(self.comicList.count)
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

extension TheaterListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: theaterCell.self)
        let dict:Dictionary = comicList[indexPath.row]
        cell.titleLabel.text = dict["name"]
        cell.subTitleLabel.text = dict["tel"]
        cell.descLabel.text = dict["adds"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TheaterResultController(dict: comicList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
