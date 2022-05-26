import Parchment
import UIKit
import SQLite

// This is the simplest use case of using Parchment. We just create a
// bunch of view controllers, and pass them into our paging view
// controller. FixedPagingViewController is a subclass of
// PagingViewController that makes it much easier to get started with
// Parchment when you only have a fixed array of view controllers. It
// will create a data source for us and set up the paging items to
// display the view controllers title.
let FavoriteNotificationKey = "Favorite"

class FavoriteViewController: UIViewController {
    
    private var comicList = [[[String:String]]]()
    private var comicList1 = [[String:String]]()
    private var comicList2 = [[String:String]]()
    
    // Required for deinit the observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    let Favorite = Notification.Name(rawValue: FavoriteNotificationKey)
    
    @objc func update(notification: NSNotification) {
        // Do any additional setup after loading the view.
        comicList.removeAll()
        self.comicList1.removeAll()
        self.comicList2.removeAll()
        for movie in (try? db?.prepare(movie))!! {
            print("ahref: \(movie[ahref]), imgsrc: \(movie[imgsrc]), release_movie_name: \(movie[release_movie_name]), en: \(movie[en]), release_movie_time: \(movie[release_movie_time])")
            var dataSource = [String:String]()
            dataSource["ahref"] = movie[ahref]
            dataSource["imgsrc"] = movie[imgsrc]
            dataSource["release_movie_name"] = movie[release_movie_name]
            dataSource["en"] = movie[en]
            dataSource["release_movie_time"] = movie[release_movie_time]
            self.comicList1.append(dataSource)
        }
        
        for theater in (try? db?.prepare(theater))!! {
            print("href: \(theater[href]), name: \(theater[name]), tel: \(theater[tel]), adds: \(theater[adds])")
            // Do any additional setup after loading the view.
            var dataSource = [String:String]()
            dataSource["href"] = theater[href]
            dataSource["name"] = theater[name]
            dataSource["tel"] = theater[tel]
            dataSource["adds"] = theater[adds]
            self.comicList2.append(dataSource)
        }
        
        comicList.append(comicList1)
        comicList.append(comicList2)
        self.pagingViewController.reloadData()
    }
    
    let pagingViewController = PagingViewController()
    
    convenience init(dict: [String:String]) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的最愛";
        
        self.view.backgroundColor = UIColor.white
        
        let UScreenWidth = UIScreen.main.bounds.width / 2
        
        // Do any additional setup after loading the view.
        for movie in (try? db?.prepare(movie))!! {
            print("ahref: \(movie[ahref]), imgsrc: \(movie[imgsrc]), release_movie_name: \(movie[release_movie_name]), en: \(movie[en]), release_movie_time: \(movie[release_movie_time])")
            var dataSource = [String:String]()
            dataSource["ahref"] = movie[ahref]
            dataSource["imgsrc"] = movie[imgsrc]
            dataSource["release_movie_name"] = movie[release_movie_name]
            dataSource["en"] = movie[en]
            dataSource["release_movie_time"] = movie[release_movie_time]
            self.comicList1.append(dataSource)
        }
        
        for theater in (try? db?.prepare(theater))!! {
            print("href: \(theater[href]), name: \(theater[name]), tel: \(theater[tel]), adds: \(theater[adds])")
            // Do any additional setup after loading the view.
            var dataSource = [String:String]()
            dataSource["href"] = theater[href]
            dataSource["name"] = theater[name]
            dataSource["tel"] = theater[tel]
            dataSource["adds"] = theater[adds]
            self.comicList2.append(dataSource)
        }
        
        comicList.append(comicList1)
        comicList.append(comicList2)
        
        pagingViewController.dataSource = self
        
        pagingViewController.menuItemLabelSpacing = 10
        
        pagingViewController.menuItemSize = .fixed(width: UScreenWidth, height: 40)
        
        // Make sure you add the PagingViewController as a child view
        // controller and constrain it to the edges of the view.
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(update(notification:)), name: Favorite, object: nil)
    }
}

extension FavoriteViewController: PagingViewControllerDataSource {
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return self.comicList.count
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        if (index == 0) {
            return MovieFavoriteViewController(comicList1: self.comicList[index])
        } else {
            return TheaterFavoriteViewController(comicList1: self.comicList[index])
        }
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        if (index == 0) {
            return PagingIndexItem(index: index, title: "電影")
        } else {
            return PagingIndexItem(index: index, title: "電影院")
        }
    }
    
}

