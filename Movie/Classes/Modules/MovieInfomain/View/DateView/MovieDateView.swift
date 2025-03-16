//
//  DateView.swift
//  Movie
//
//  Created by User on 2024/9/19.
//

import Foundation
import UIKit
import RxSwift

public protocol MovieDateViewProtocol: AnyObject {

    func SetDateViewHeight(height: CGFloat)
}

public class MovieDateView: UIView {
    
    public weak var delegate: MovieDateViewProtocol?
    
    private let transparentView = UIView()
    
    /// 所有筛选数据
    public var date: [MovieDateTabItemModel] = [] {
        didSet {

        }
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dateButton)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(dateButton)
    }
    
    public lazy var dateButton: UIButton = {

        let button = UIButton(frame: CGRect(x: 10,
                                            y: 10,
                                            width: .screenWidth - 20,
                                            height: 40))
        // 按鈕文字
        button.setTitle("暫時無資訊", for: .normal)
        button.isUserInteractionEnabled = false;//交互关闭

        // 按鈕文字顏色
        button.setTitleColor(
            UIColor.white,
            for: .normal)

        // 按鈕是否可以使用
        button.isEnabled = true

        // 按鈕背景顏色
        button.backgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)

        // 按鈕按下後的動作
        button.addTarget(
            self,
            action: #selector(TheaterDateView.click),
            for: .touchUpInside)
        return button
    }()
    
    @objc func click(_ sender: Any) {
        addTransparentView(frames: dateButton.frame)
        self.delegate?.SetDateViewHeight(height: .screenHeight)
    }
    
    public lazy var tableView: UITableView = {

        let tableView = UITableView(frame: bounds)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.keyWindow
        transparentView.frame = window?.frame ?? self.frame
        self.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.date.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = dateButton.frame
        self.delegate?.SetDateViewHeight(height: 60)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
}

extension MovieDateView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = date[indexPath.row].date
        cell.textLabel!.textColor = UIColor.black
        cell.backgroundColor = UIColor.white
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 213/255, alpha: 1.0)
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dateButton.setTitle(date[indexPath.row].date, for: .normal)
        removeTransparentView()
    }
}

// MARK: - Reactive-extension
public extension Reactive where Base: MovieDateView {

    var date: Binder<[MovieDateTabItemModel]> {
        
        Binder(base) { view, result in
            view.date = result
        }
    }
}

