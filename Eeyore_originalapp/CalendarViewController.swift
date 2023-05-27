//
//  CalendarViewController.swift
//  Eeyore_originalapp
//
//  Created by 大島彩也夏 on 2023/05/24.
//

import Foundation
import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource{


    var label:UILabel!
    let df = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = FSCalendar(frame: CGRect(x: 25, y: 120, width: 350, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        calendar.appearance.weekdayTextColor = UIColor.systemPink
        calendar.appearance.headerTitleColor = UIColor.systemPink
        label = UILabel(frame: CGRect(x: 20, y: 300, width: 320, height: 300))
        view.addSubview(label)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        df.dateFormat = "yyyy年MM月dd日"
        label.text = df.string(from: date)
    }
}
