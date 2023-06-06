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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:  "cell", for: indexPath)
        cell.textLabel!.text = array[indexPath.row]
        return cell
    }
    
        
    @IBOutlet weak var tableView: UITableView!
    var label:UILabel!
    let df = DateFormatter()
    let resultTitle = realm.objects(Diary.self).value(forKey: "title")
    let resultArticle = realm.objects(Diary.self).value(forKey: "article")
    
    var array = ["a", "b", "c"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        
        let calendar = FSCalendar(frame: CGRect(x: 23, y: 100, width: 350, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
//        calendar.appearance.weekdayTextColor = UIColor.systemPink
        calendar.appearance.weekdayTextColor = .darkGray //曜日表示のテキストカラー
        calendar.appearance.titleWeekendColor = .systemPink
        calendar.appearance.headerTitleColor = UIColor.darkGray
        calendar.appearance.headerTitleFont      = UIFont.systemFont(ofSize: 21)
        calendar.appearance.headerDateFormat = "yyyy年MM月"
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.weekdayFont          = UIFont.systemFont(ofSize: 16)
        calendar.appearance.titleFont            = UIFont.systemFont(ofSize: 16)
        label = UILabel(frame: CGRect(x: 25, y: 285, width: 320, height: 290))
        view.addSubview(label)
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        df.dateFormat = "yyyy年MM月dd日"
        label.text = df.string(from: date)
        label.font = UIFont.systemFont(ofSize: 21.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: "toArticleViewController", sender: nil)
    }
    

}
