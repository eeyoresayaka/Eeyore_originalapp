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

    @IBOutlet  weak var calendar: FSCalendar!
    var label:UILabel!
    let df = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = FSCalendar(frame: CGRect(x: 50, y: 200, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        label = UILabel(frame: CGRect(x: 50, y: 400, width: 320, height: 300))
        view.addSubview(label)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        df.dateFormat = "yyyy-MM-dd"
        label.text = df.string(from: date)
    }
}
