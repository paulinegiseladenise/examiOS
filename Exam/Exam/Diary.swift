//
//  Diary.swift
//  Exam
//
//  Created by Pauline Broängen on 2022-11-09.
//

import Foundation

class Diary: ObservableObject {
    
    @Published private var pages = [DiaryPage]()
    
    func addPage(page: DiaryPage) {
        if page.diaryTitle == "" || page.diaryContent == "" {
            return
        }
        pages.append(page)
    }
    
    
    func getPages() -> [DiaryPage] {
        return pages
    }
}
