//
//  AddEditNoteView.swift
//  NoteTakingApp
//
//  Created by Chris Xiong on 2/14/25.
//

import SwiftUI

struct AddEditNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: NotesViewModel
    var note: NoteModel?

    @State private var title: String = ""
    @State private var content: String = ""

    // Initialize editing form
    init(viewModel: NotesViewModel, note: NoteModel? = nil) {
        self.viewModel = viewModel // Stores note list, savings, and updated notes
        self.note = note // Stores note or new note
        
        // Checks if title or content has values
        _title = State(initialValue: note?.title ?? "")
        _content = State(initialValue: note?.content ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                // Title
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title) // Simple TextField for title
                }
                //Content
                Section(header: Text("Content")) {
                    TextEditor(text: $content) // TextEditor for content
                        .frame(minHeight: 200)
                }
            }
            // If note is empty, then New Note, otherwise, edit Note
            .navigationTitle(note == nil ? "New Note" : "Edit Note")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss() // Exit the sheet/modal view
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let note = note {
                            // Update text if editing
                            viewModel.updateNote(note: note, title: title, content: content)
                        } else {
                            viewModel.addNote(title: title, content: content)
                        }
                        presentationMode.wrappedValue.dismiss() // Exit the sheet/modal view
                    }
                }
            }
        }
    }
}
