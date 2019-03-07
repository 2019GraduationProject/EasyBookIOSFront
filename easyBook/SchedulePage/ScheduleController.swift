//
//  ScheduleController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/2/26.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit
import FSCalendar
import PopMenu

class ScheduleController: UIViewController, UITableViewDataSource, UITableViewDelegate, FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate, PopMenuViewControllerDelegate {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    var popMenuManager: PopMenuManager!
    
    var datesWithEvent = ["2019-02-28", "2019-03-01", "2019-03-18", "2019-04-15"]
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0
//        calendar.firstWeekday = 2 // 使用周一为第一列
        
        initPopMenuManager()
    }
    
    /// 设置新建事件的弹出窗口
    func initPopMenuManager() {
        // 获取 PopMenuManager 实例
        popMenuManager = PopMenuManager.default
        // 设置 action
        let action1 = PopMenuDefaultAction(title: "组内/跨组事件", image: UIImage(), color: UIColor.white)
        let action2 = PopMenuDefaultAction(title: "全局事件", image: UIImage(), color: UIColor.white)
        // 设置 action 的图片高度为0，即起到去掉图片的效果，否则会占用空间位置
        action1.iconWidthHeight = 0
        action2.iconWidthHeight = 0
        // 加入 action
        popMenuManager.addAction(action1)
        popMenuManager.addAction(action2)
        
        // 定制外观
        popMenuManager.popMenuAppearance.popMenuBackgroundStyle = .none()
        popMenuManager.popMenuAppearance.popMenuCornerRadius = 6
        popMenuManager.popMenuAppearance.popMenuStatusBarStyle = .default
        popMenuManager.popMenuDelegate = self
    }
    
    
    // MARK:- PopMenuViewControllerDelegate
    
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        popMenuViewController.dismiss(animated: true) {
            if index == 0 {
                if let addLocalEventNaviController = self.storyboard?.instantiateViewController(withIdentifier: "AddLocalEventNaviController") as? UINavigationController {
                    self.present(addLocalEventNaviController, animated: true)
                }
            } else {
                if let addGlobalEventNaviController = self.storyboard?.instantiateViewController(withIdentifier: "AddGlobalEventNaviController") as? UINavigationController {
                    self.present(addGlobalEventNaviController, animated: true)
                }
            }
        }
    }
    
    
    // MARK:- UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    
    // MARK:- FSCalendar
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    /// 给有事件的日期设置白点，返回值表示设置几个白点
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return 3
        }
        return 0
    }
    
    
    // MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: EventCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EventCell
        
        cell.startTimeLabel.text = "15:00"
        cell.endTImeLabel.text = "16:30"
        cell.eventNameLabel.text = "本科毕业设计"
        cell.groupNameLabel.text = "iOS访谈app组"
        cell.locationLabel.text = "南京大学软件学院院楼710"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击行则选中的状态
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Event Listeners
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        popMenuManager.present(sourceView: sender)
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
