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
    
        
    @IBOutlet weak var tableView: UITableView!
    var label:UILabel!
    let df = DateFormatter()
    
    let realm = try! Realm()
    var diaryArray: [Diary] = []

     func fetchDiaries() {
         let diaries = realm.objects(Diary.self)
         diaryArray = Array(diaries)
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         fetchDiaries() // データの取得
         return diaryArray.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         fetchDiaries() // データの取得
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarTableViewCell
         let diary = diaryArray[indexPath.row]
         
         // カレンダーで選択された日付とDiaryのdateが一致する場合に表示
         if let selectedDate = label.text, selectedDate == diary.date {
             cell.dateLabel.text = diary.date
             cell.titleLabel.text = diary.title
         } else {
             cell.dateLabel.text = ""
             cell.titleLabel.text = ""
         }
         
         return cell
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
