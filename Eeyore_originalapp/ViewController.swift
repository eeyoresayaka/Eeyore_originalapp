//
//  ViewController.swift
//  Eeyore_originalapp
//
//  Created by 大島彩也夏 on 2023/05/21.
//

import UIKit
import RealmSwift

    let realm = try! Realm()

class ViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var articleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        articleTextField.delegate = self
        
        let diary: Diary? = read()
        
        titleTextField.text = diary?.title
        articleTextField.text = diary?.article
        
        // Do any additional setup after loading the view.
    }
    
    func read() -> Diary? {
        return realm.objects(Diary.self).first
    }
    
    @IBAction func save(){
        let title: String = titleTextField.text!
        let article: String = articleTextField.text!
        
        let diary: Diary? = read()
        
        if diary != nil {
            try! realm.write {
                diary!.title = title
                diary!.article = article
            }
        } else {
            let newDiary = Diary()
            newDiary.title = title
            newDiary.article = article
            
            try! realm.write {
                realm.add(newDiary)
            }
        }
        
        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }


}

