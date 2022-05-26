//
//  MovieSummaryViewController.swift
//  Movie
//
//  Created by Mac on 2022/3/31.
//

import UIKit
import SwiftSoup

class MovieSummaryViewController: UIViewController {
    
    private var comicList = [String]()
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.white
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        tw.register(
          UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        view.addSubview(tableView)
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
    }

    convenience init(title: String, id:  String) {
        self.init(title: title, content: id)
    }

    init(title: String, content: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        
        ApiProvider.request(Api.movieinfo_main(id:content)) {
            result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                let jsonString = try? response.mapString()
                message = jsonString ?? message
                
                do {
                    let doc: Document = try SwiftSoup.parse(message)
                    
                    let story: String = try doc.getElementById("story")!.html()
                    
                    //print(story)
                    self.comicList.append(story.replacingOccurrences(of: "<br>", with: "\n"))
                    
                    self.tableView.rowHeight = UITableView.automaticDimension
                    self.tableView.estimatedRowHeight = 44
                    
                    self.tableView.reloadData()
                    
                } catch Exception.Error(let type, let message) {
                    print(message)
                } catch {
                    print("error")
                }
            }
        }
        
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension MovieSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
              tableView.dequeueReusableCell(
                withIdentifier: "Cell", for: indexPath) as
                UITableViewCell
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.text = comicList[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24.0)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
