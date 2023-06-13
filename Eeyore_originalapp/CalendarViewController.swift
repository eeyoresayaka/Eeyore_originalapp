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
    var selectedDiary: Diary?
    var selectedDate: Date?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 110

        
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

    func fetchDiaries(date: Date) {
        let formattedDate = df.string(from: date)
        let diaries = realm.objects(Diary.self).filter("date == %@", formattedDate)
        diaryArray = Array(diaries)
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         guard let selectedDate = selectedDate else { return 0 }
         fetchDiaries(date: selectedDate) // データの取得
         return diaryArray.count
     }


    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        df.dateFormat = "yyyy年MM月dd日"
        let formattedDate = df.string(from: date)
        label.text = formattedDate
        label.font = UIFont.systemFont(ofSize: 21.0)

        // テーブルビューの再読み込みを行う
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarTableViewCell
        guard let selectedDate = selectedDate else { return cell }
        fetchDiaries(date: selectedDate) // データの取得
        let diary = diaryArray[indexPath.row]
        cell.titleLabel.text = diary.title
        if let imageData = diary.image {
            let image = UIImage(data: imageData)
            cell.articleImage.image = image
        } else {
            cell.articleImage.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      selectedDiary = diaryArray[indexPath.row]
      performSegue(withIdentifier: "toArticleViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArticleViewController" {
            if let articleViewController = segue.destination as? ArticleViewController {
                articleViewController.diary = selectedDiary
            }
        }
        if segue.identifier == "toViewController" {
            if let ViewController = segue.destination as? ViewController {
                ViewController.selectedDate = selectedDate
            }
        }
    }
    

}
