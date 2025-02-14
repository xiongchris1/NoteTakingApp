//
//  ContentView.swift
//  NoteTakingApp
//
//  Created by Chris Xiong on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var addNote = false

    var body: some View {
        NavigationStack {
            
            // List of notes
            List {
                ForEach(viewModel.notes) { note in
                    // Link to the note detail view
                    NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                        // Horizontal alignment for green checkmark and title/content
                        HStack {
                            if note.isCompleted {
                                // Green checkmark for completion
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                            // Vertical alignment for all notes
                            VStack(alignment: .leading) {
                                Text(note.title)
                                    .font(.headline)
                                    .strikethrough(note.isCompleted, color: .red)
                                Text(note.content)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(4)
                            }
                        }
                    }
                }
                
                // Delete notes
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let _ = viewModel.notes[index]
                        viewModel.deleteNotes(at: indexSet)
                    }
                }
            }
            
            // Header
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { addNote = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            // Popup/modal for adding or editing notes
            .sheet(isPresented: $addNote) {
                AddEditNoteView(viewModel: viewModel)
            }
            }
        }
    }

