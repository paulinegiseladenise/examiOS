//
//  UserDocument.swift
//  Exam
//
//  Created by Pauline Broängen on 2022-11-10.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct UserDocument: Codable, Identifiable {
    @DocumentID var id: String?
}

