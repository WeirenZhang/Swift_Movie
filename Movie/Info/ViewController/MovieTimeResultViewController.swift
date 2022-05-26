//
//  MovieTimeResultViewController.swift
//  Movie
//
//  Created by Mac on 2022/3/31.
//
import Parchment
import UIKit
import SwiftSoup
import SwiftyJSON

let MovieTimeResultNotificationKey = "MovieTimeResult"

class MovieTimeResultViewController: UIViewController {
    
    var mid: String = ""
    
    let pagingViewController = PagingViewController()
    
    let MovieTimeResult = Notification.Name(rawValue: MovieTimeResultNotificationKey)
    
    var areas = Array<[String: String]>()
    
    // Required for deinit the observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    var timetablearray = [[String: [String]]]()
    
    var textField: UITextField = {
        let tl = UITextField()
        tl.textAlignment = .center
        tl.textColor = UIColor.white
        tl.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        return tl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
        }
        textField.delegate = self
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: date as Date)
        textField.text = str + " (點我查改天)"
        
        // Green
        NotificationCenter.default.addObserver(self, selector: #selector(update(notification:)), name: MovieTimeResult, object: nil)
        
        textField.isHidden = true
    }
    
    @objc func update(notification: NSNotification) {
        let dict:String = notification.userInfo?["date"] as? String ?? ""
        textField.text = dict + " (點我查改天)"
        
        ApiLoadingProvider.request(Api.movietimeresult_main(id:self.mid, date: dict)) {
            result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                let jsonString = try? response.mapString()
                message = jsonString ?? message
                
                do {
                    let json: JSON = try JSON(data: response.data)
                    let view: String = json["view"].string!
                    print("time " + view)
                    let doc: Document = try SwiftSoup.parse(view)
                    
                    let select_locations: Elements = try doc.select("select#select-location > option")
                    print("select_location " + String(select_locations.count))
                    if (select_locations.count > 0) {
                        
                        self.timetablearray.removeAll()
                        self.areas.removeAll()
                        
                        for select_location: Element in select_locations.array() {
                            
                            var area = [String: String]()
                            
                            let value: String = try select_location.attr("value")
                            print(value)
                            area["value"] = value
                            let location: String = try select_location.text()
                            print(location)
                            area["location"] = location
                            if (!location.contains("選擇")) {
                                self.areas.append(area)
                            }
                        }
                    }
                    
                    print("areas.count " + String(self.areas.count))
                    
                    let box: Elements = try doc.select("[id~=(?i)theater_id]")
                    print("MovieInTheaters " + String(box.count))
                    if (box.count > 0) {
                        
                        for title: Element in box.array() {
                            var theater_id_array = [String]()
                            var location_array = [String]()
                            var name_array = [String]()
                            var label_array = [String]()
                            var timelabel_array = [String]()
                            var movietheater_array = [String: [String]]()
                            
                            let id: String = try title.attr("id")
                            let ids = id.split(separator: "_")
                            let theater_id = String(ids[ids.count - 1])
                            print(theater_id)
                            theater_id_array.append(theater_id)
                            movietheater_array["theater_id"] = theater_id_array
                            
                            let location: String = try title.attr("data-location")
                            print(location)
                            location_array.append(location)
                            movietheater_array["location"] = location_array
                            
                            let name: String = try title.select("h2").text()
                            print(name)
                            name_array.append(name)
                            movietheater_array["name"] = name_array
                            
                            let _labels: Elements = try title.select(".timetable-label")
                            for _label: Element in _labels.array() {
                                let label: String = try _label.text()
                                print(label)
                                label_array.append(label)
                            }
                            movietheater_array["label"] = label_array
                            
                            let _timetables: Elements = try title.select("label")
                            for _timetable: Element in _timetables.array() {
                                let timelabel: String = try _timetable.text()
                                print(timelabel)
                                timelabel_array.append(timelabel)
                            }
                            movietheater_array["timelabel"] = timelabel_array
                            
                            self.timetablearray.append(movietheater_array)
                        }
                        print("timetablearray.count " + String(self.timetablearray.count))
                        self.pagingViewController.reloadData()
                        self.pagingViewController.select(index: 0)
                    }
                } catch Exception.Error(let type, let message) {
                    print(message)
                } catch {
                    print("error")
                }
            }
        }
    }
    
    convenience init(index: Int) {
        self.init(title: "View \(index)", content: "\(index)")
    }
    
    convenience init(title: String, id:  String) {
        self.init(title: title, content: id)
    }
    
    init(title: String, content: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.mid = content
        
        ApiProvider.request(Api.movietimeresult_main(id:content, date: "2022-05-07")) {
            result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                let jsonString = try? response.mapString()
                message = jsonString ?? message
                
                do {
                    let json: JSON = try JSON(data: response.data)
                    let view: String = json["view"].string!
                    print("time " + view)
                    let doc: Document = try SwiftSoup.parse(view)
                    
                    let select_locations: Elements = try doc.select("select#select-location > option")
                    print("select_location " + String(select_locations.count))
                    if (select_locations.count > 0) {
                        for select_location: Element in select_locations.array() {
                            
                            var area = [String: String]()
                            
                            let value: String = try select_location.attr("value")
                            print(value)
                            area["value"] = value
                            let location: String = try select_location.text()
                            print(location)
                            area["location"] = location
                            if (!location.contains("選擇")) {
                                self.areas.append(area)
                            }
                        }
                    }
                    
                    print("areas.count " + String(self.areas.count))
                    
                    let box: Elements = try doc.select("[id~=(?i)theater_id]")
                    print("MovieInTheaters " + String(box.count))
                    if (box.count > 0) {
                        
                        for title: Element in box.array() {
                            
                            var theater_id_array = [String]()
                            var location_array = [String]()
                            var name_array = [String]()
                            var label_array = [String]()
                            var timelabel_array = [String]()
                            var movietheater_array = [String: [String]]()
                            
                            let id: String = try title.attr("id")
                            let ids = id.split(separator: "_")
                            let theater_id = String(ids[ids.count - 1])
                            print(theater_id)
                            theater_id_array.append(theater_id)
                            movietheater_array["theater_id"] = theater_id_array
                            
                            let location: String = try title.attr("data-location")
                            print(location)
                            location_array.append(location)
                            movietheater_array["location"] = location_array
                            
                            let name: String = try title.select("h2").text()
                            print(name)
                            name_array.append(name)
                            movietheater_array["name"] = name_array
                            
                            let _labels: Elements = try title.select(".timetable-label")
                            for _label: Element in _labels.array() {
                                let label: String = try _label.text()
                                print(label)
                                label_array.append(label)
                            }
                            movietheater_array["label"] = label_array
                            
                            let _timetables: Elements = try title.select("label")
                            for _timetable: Element in _timetables.array() {
                                let timelabel: String = try _timetable.text()
                                print(timelabel)
                                timelabel_array.append(timelabel)
                            }
                            movietheater_array["timelabel"] = timelabel_array
                            
                            self.timetablearray.append(movietheater_array)
                        }
                        print("timetablearray.count " + String(self.timetablearray.count))
                        self.pagingViewController.dataSource = self
                        
                        //pagingViewController.menuItemSize = .fixed(width: UScreenWidth, height: 40)
                        self.pagingViewController.menuItemSize = .selfSizing(estimatedWidth: 0, height: 40)
                        // Make sure you add the PagingViewController as a child view
                        // controller and constrain it to the edges of the view.
                        self.addChild(self.pagingViewController)
                        self.view.addSubview(self.pagingViewController.view)
                        self.view.constrainToEdges_0(self.pagingViewController.view)
                        self.pagingViewController.didMove(toParent: self)
                        self.textField.isHidden = false
                    }
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

extension MovieTimeResultViewController: PagingViewControllerDataSource {
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return self.areas.count
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let area:String = self.areas[index]["value"]!
        return ContentViewController(areas: area, timetables: self.timetablearray)
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        return PagingIndexItem(index: index, title: self.areas[index]["location"]!)
    }
    
}

extension MovieTimeResultViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.textField {
            let newStr = textField.text?.replacingOccurrences(of: " (點我查改天)", with: "")
            print(newStr!)
            var dataSource = [String:String]()
            dataSource["date"] = newStr
            let name = Notification.Name(rawValue: MovieMainNotificationKey)
            NotificationCenter.default.post(name: name, object: nil,
                                            userInfo: dataSource)
            return false
        }
        
        return true
    }
}
