//
//  NoteModel.swift
//  NoteTakingApp
//
//  Created by Chris Xiong on 2/13/25.
//

import Foundation

struct NoteModel: Identifiable, Codable {
    var id: UUID = UUID() // Unique identifier
    var title: String
    var content: String
    var isCompleted: Bool = false
}
