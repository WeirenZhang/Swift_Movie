import Parchment
import UIKit
import DateTimePicker
import SQLite
import Toast_Swift

// This is the simplest use case of using Parchment. We just create a
// bunch of view controllers, and pass them into our paging view
// controller. FixedPagingViewController is a subclass of
// PagingViewController that makes it much easier to get started with
// Parchment when you only have a fixed array of view controllers. It
// will create a data source for us and set up the paging items to
// display the view controllers title.
let MovieMainNotificationKey = "MovieMain"

class MovieMainViewController: UIViewController, DateTimePickerDelegate {
    
    private var comicList = [String:String]()
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        //title = picker.selectedDateString
    }
    
    // Required for deinit the observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    let MovieMain = Notification.Name(rawValue: MovieMainNotificationKey)
    
    @objc func update(notification: NSNotification) {
        let dict:String = notification.userInfo?["date"] as? String ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_Hant_TW") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:dict)!
        
        picker.selectedDate = date
        picker.show()
    }
    
    private var id: String = ""
    
    convenience init(dict: [String:String]) {
        self.init()
        self.comicList = dict;
        self.id = comicList["ahref"]!
        self.title = comicList["release_movie_name"]!
    }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        print(comicList["ahref"]!)
        print(comicList["release_movie_name"]!)
        print(comicList["imgsrc"]!)
        print(comicList["en"]!)
        print(comicList["release_movie_time"]!)
        
        do {
            let count = try db?.scalar(movie.filter(ahref == comicList["ahref"]!).count)
            
            if (count! == 0) {
                let rowid = try db?.run(movie.insert(ahref <- comicList["ahref"]!, imgsrc <- comicList["imgsrc"]!, release_movie_name <- comicList["release_movie_name"]!, en <- comicList["en"]!, release_movie_time <- comicList["release_movie_time"]!))
                print("inserted id: \(rowid!)")
                self.navigationController?.view.makeToast("成功加入我的最愛", duration: 1.0, position: .top)
                let name = Notification.Name(rawValue: FavoriteNotificationKey)
                NotificationCenter.default.post(name: name, object: nil)
            } else {
                self.navigationController?.view.makeToast("我的最愛已經有了", duration: 1.0, position: .top)
            }
        } catch {
            print("insertion failed: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Image needs to be added to project.
        let buttonIcon = UIImage(named: "favorite")
        
        let leftBarButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.myLeftSideBarButtonItemTapped(_:)))
        leftBarButton.image = buttonIcon
        
        self.navigationItem.rightBarButtonItem = leftBarButton
        
        self.view.backgroundColor = UIColor.white
        
        let UScreenWidth = UIScreen.main.bounds.width / 4
        
        let viewControllers = [
            MovieInfoMainViewController(title: "電影資料", id: self.id),
            MovieSummaryViewController(title: "劇情簡介", id: self.id),
            MovieTimeResultViewController(title: "播放時間", id: self.id),
            MovieVideoViewController(title: "預告片", id: self.id),
        ]
        
        let pagingViewController = PagingViewController(viewControllers: viewControllers)
        
        pagingViewController.menuItemLabelSpacing = 10
        
        pagingViewController.menuItemSize = .fixed(width: UScreenWidth, height: 40)
        
        // Make sure you add the PagingViewController as a child view
        // controller and constrain it to the edges of the view.
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(update(notification:)), name: MovieMain, object: nil)
        
        picker.selectedDate = NSDate() as Date
        // customize your picker
        //        picker.timeInterval = DateTimePicker.MinuteInterval.thirty
        picker.locale = Locale(identifier: "zh_Hant_TW")
        //        picker.todayButtonTitle = "Today"
        //        picker.is12HourFormat = true
        picker.dateFormat = "yyyy-MM-dd"
        picker.isDatePickerOnly = true
        //picker.includesMonth = true
        //picker.includesSecond = true
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.doneButtonTitle = "查電影時刻"
        picker.doneBackgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.customFontSetting = DateTimePicker.CustomFontSetting(selectedDateLabelFont: .boldSystemFont(ofSize: 20))
        //        if #available(iOS 13.0, *) {
        //            picker.normalColor = UIColor.secondarySystemGroupedBackground
        //            picker.darkColor = UIColor.label
        //            picker.contentViewBackgroundColor = UIColor.systemBackground
        //            picker.daysBackgroundColor = UIColor.groupTableViewBackground
        //            picker.titleBackgroundColor = UIColor.secondarySystemGroupedBackground
        //        } else {
        //            picker.normalColor = UIColor.white
        //            picker.darkColor = UIColor.black
        //            picker.contentViewBackgroundColor = UIColor.white
        //        }
        
        picker.delegate = self
        
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            //self.title = formatter.string(from: date)
            let name = Notification.Name(rawValue: MovieTimeResultNotificationKey)
            var dataSource = [String:String]()
            dataSource["date"] = formatter.string(from: date)
            
            picker.selectedDate = date
            
            NotificationCenter.default.post(name: name, object: nil,
                                            userInfo: dataSource)
        }
        
        // add picker to your view
        // don't try to make customize width and height of the picker,
        // you'll end up with corrupted looking UI
        //        picker.frame = CGRect(x: 0, y: 100, width: picker.frame.size.width, height: picker.frame.size.height)
        // set a dismissHandler if necessary
        //        picker.dismissHandler = {
        //            picker.removeFromSuperview()
        //        }
        //        self.view.addSubview(picker)
        
        // or show it like a modal
        
    }
}
