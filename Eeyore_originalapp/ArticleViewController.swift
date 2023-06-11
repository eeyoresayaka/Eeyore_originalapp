//
//  ArticleViewController.swift
//  Eeyore_originalapp
//
//  Created by 大島彩也夏 on 2023/06/04.
//

import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet var titlelLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var articleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var diary: Diary?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let diary = diary {
            // diary の情報を使用して表示を更新する処理を行う
            titlelLabel.text = diary.title
            dateLabel.text = diary.date
            articleLabel.text = diary.article
            
            if let imageData = diary.image {
                let image = UIImage(data: imageData)
                imageView.image = image
            }
        }
    }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

