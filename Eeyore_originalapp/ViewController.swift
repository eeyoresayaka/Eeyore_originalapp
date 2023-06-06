//
//  ViewController.swift
//  Eeyore_originalapp
//
//  Created by 大島彩也夏 on 2023/05/21.
//

import UIKit
import RealmSwift

let realm = try! Realm()

class ViewController: UIViewController , UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var articleTextField: UITextField!
    @IBOutlet var photoImageView: UIImageView!
//    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        titleTextField.delegate = self
        articleTextField.delegate = self
        
        let diary: Diary? = read()
        
        titleTextField.text = diary?.title
        articleTextField.text = diary?.article
        
        // Do any additional setup after loading the view.
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
//        textField.inputView = datePicker
        
        // 決定バーの生成
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
//        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
//        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        
//        textField.inputAccessoryView = toolbar
        
    }
    
    func read() -> Diary? {
        return realm.objects(Diary.self).first
    }
    
    // 決定ボタン押下
   
    
    @IBAction func onTappedCameraButton(){
        presentPickerController(sourceType:  .camera)
    }
    
    @IBAction func onTappedAlbumButton(){
        presentPickerController(sourceType:  .photoLibrary)
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        photoImageView.image = info[.originalImage] as? UIImage
    }
    
    @IBAction func save(){
        let title: String = titleTextField.text!
        let article: String = articleTextField.text!
        
        let diary: Diary? = read()
        
        let image = photoImageView.image?.jpegData(compressionQuality: 1)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"

        let date = dateFormatter.string(from: datePicker.date)
        
        if diary != nil {
            try! realm.write {
                diary!.title = title
                diary!.article = article
                diary!.date = date
                diary!.image = image
            }
        } else {
            let newDiary = Diary()
            newDiary.title = title
            newDiary.article = article
            newDiary.date = date
            newDiary.image = image
            
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

