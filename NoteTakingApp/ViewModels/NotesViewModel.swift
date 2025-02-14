//
//  NotesViewModel.swift
//  NoteTakingApp
//
//  Created by Chris Xiong on 2/13/25.
//
import SwiftUI

class NotesViewModel: ObservableObject{
    @AppStorage("notes") private var notesData: Data?
    // Declare array named notes with NoteModel data
    @Published var notes: [NoteModel] = [] {
        didSet {
            saveNotes() // Save immediately on any modification
        }
    }
    
    // Load notes at new instance
    init() {
        loadNotes()
    }
    
    // Add new note with a title and content
    func addNote(title: String, content: String) {
        let newNote =
        NoteModel(title: title, content: content, isCompleted: false) // New Note object
        notes.append(newNote)
    }
    
    // Update notes
    func updateNote(note: NoteModel, title: String, content: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].title = title
            notes[index].content = content
        }
    }
    
    // Toggle completion
    func toggleCompletion(note: NoteModel) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isCompleted.toggle() // False to true if completed
        }
    }
    
    // Delete notes
    func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
    
    // Save notes using a try error handler
    func saveNotes() {
        let encodedNotesData = try? JSONEncoder().encode(notes)
        notesData = encodedNotesData
    }
    
    // Load notes with decoding
    func loadNotes() {
        // Use guard to exit if no data in note
        guard let decodedNotesData = notesData else {
            notes = []
            return
        }
        
        do {
            notes = try JSONDecoder().decode([NoteModel].self, from: decodedNotesData)
        } catch {
            print("Error loading notes!")
            notes = []
        }
    }
}
