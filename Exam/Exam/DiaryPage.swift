//
//  DiaryPage.swift
//  Exam
//
//  Created by Pauline Broängen on 2022-11-09.
//

import Foundation

struct DiaryPage: Identifiable {
    var id = UUID()
    var diaryTitle: String
    var diaryContent: String
}
