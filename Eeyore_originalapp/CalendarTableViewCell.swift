//
//  CalendarTableViewCell.swift
//  Eeyore_originalapp
//
//  Created by 大島彩也夏 on 2023/06/04.
//

import UIKit
import UIKit
import FSCalendar
import RealmSwift



class CalendarTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
