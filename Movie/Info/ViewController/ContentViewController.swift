import UIKit

final class ContentViewController: UIViewController {
    
    var timetablearray = [[String: [String]]]()
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.white
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        //tw.rowHeight = UITableView.automaticDimension
        tw.register(cellType: MovieTimeResultCell.self)
        return tw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
    }
    
    convenience init(areas: String, timetables: [[String: [String]]]) {
        self.init(area: areas, timetable: timetables)
    }
    
    init(area: String, timetable: [[String: [String]]]) {
        super.init(nibName: nil, bundle: nil)
        //self.title = area["location"]
        
        for int in 0..<timetable.count {
            let _timetable:[String: [String]] = timetable[int]
            
            if (area == _timetable["location"]![0]) {
                //print(area["value"]! + " " + _timetable["location"]![0])
                self.timetablearray.append(_timetable)
            }
        }
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timetablearray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict:[String: [String]] = self.timetablearray[indexPath.row]
        print(dict["theater_id"]![0])
        print(dict["name"]![0])
        
        var comicLis = [String: String]()
        comicLis["href"] = dict["theater_id"]![0]
        comicLis["name"] = dict["name"]![0]
        comicLis["tel"] = ""
        comicLis["adds"] = ""
        let vc = TheaterResultController(dict: comicLis)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieTimeResultCell.self)
        
        let dict:[String: [String]] = self.timetablearray[indexPath.row]
        
        cell.titleLabel.text = dict["name"]![0]
        
        //下面这两个语句一定要添加，否则第一屏显示的collection view尺寸，以及里面的单元格位置会不正确
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        
        cell.setCell(tapbox_cells: dict["label"]!, theater_times_cells: dict["timelabel"]!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
