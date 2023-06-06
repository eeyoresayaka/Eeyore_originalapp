//
//  diary.swift
//  Eeyore_originalapp
//
//  Created by 大島彩也夏 on 2023/05/21.
//

import Foundation
import RealmSwift

class Diary: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var article: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var image: Data?
}
