//
//  ViewController.swift
//  Eeyore_originalapp
//
//  Created by 大島彩也夏 on 2023/05/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController , UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let realm = try! Realm()
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var articleTextField: UITextField!
    @IBOutlet var photoImageView: UIImageView!
//    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        titleTextField.delegate = self
        articleTextField.delegate = self
        
//        let diary: Diary? = read()
        
//        titleTextField.text = diary?.title
//        articleTextField.text = diary?.article
        
        // Do any additional setup after loading the view.
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
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
        let diary = Diary()
        let title: String = titleTextField.text!
        let article: String = articleTextField.text!
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日"
        let date = df.string(from: datePicker.date)
        let image = photoImageView.image?.jpegData(compressionQuality: 1)
        
        diary.title = title
        diary.article = article
        diary.date = date
        diary.image = image
        
        try! realm.write{
            realm.add(diary)
        }
        
        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.dismiss(animated: true)}))

        present(alert, animated: true, completion: nil)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }


}

