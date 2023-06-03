//
//  CalendarViewController.swift
//  Eeyore_originalapp
//
//  Created by 大島彩也夏 on 2023/05/24.
//

import Foundation
import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate , UITableViewDataSource {
    
    var label:UILabel!
    let df = DateFormatter()
    let resultTitle = realm.objects(Diary.self).value(forKey: "title")
    let resultArticle = realm.objects(Diary.self).value(forKey: "article")
    
    var array = ["a", "b", "c"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:  "cell", for: indexPath)
        cell.textLabel!.text = array[indexPath.row]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = FSCalendar(frame: CGRect(x: 25, y: 110, width: 350, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
//        calendar.appearance.weekdayTextColor = UIColor.systemPink
        calendar.appearance.weekdayTextColor = .darkGray //曜日表示のテキストカラー
        calendar.appearance.titleWeekendColor = .systemPink
        calendar.appearance.headerTitleColor = UIColor.systemPink
        calendar.appearance.headerTitleFont      = UIFont.boldSystemFont(ofSize: 22)
        calendar.appearance.headerDateFormat = "yyyy年MM月"
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.weekdayFont          = UIFont.systemFont(ofSize: 17)
        calendar.appearance.titleFont            = UIFont.systemFont(ofSize: 17)
        label = UILabel(frame: CGRect(x: 25, y: 285, width: 320, height: 300))
        view.addSubview(label)
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        df.dateFormat = "yyyy年MM月dd日"
        label.text = df.string(from: date)
        label.font = UIFont.systemFont(ofSize: 23.0)
    }
}
