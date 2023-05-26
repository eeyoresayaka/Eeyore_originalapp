//
//  CalendarView.swift
//  Eeyore_originalapp
//
//  Created by 大島彩也夏 on 2023/05/24.
//

import Foundation
import SwiftUI
import FSCalendar

struct CalendarTestView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        
        typealias UIViewType = FSCalendar
        
        let fsCalendar = FSCalendar()
            
        return fsCalendar
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

