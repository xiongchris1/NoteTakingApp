//
//  NoteDetailView.swift
//  NoteTakingApp
//
//  Created by Chris Xiong on 2/13/25.
//

import SwiftUI

struct NoteDetailView: View {
    var note: NoteModel
    @ObservedObject var viewModel: NotesViewModel
    @State private var showEditView = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                
                // Title
                Text(note.title)
                    .font(.title)
                    .bold()
                    .strikethrough(note.isCompleted, color: .red)
                
                Spacer()
            }
            
            // Content
            Text(note.content)
                .font(.body)
                .padding()
                .strikethrough(note.isCompleted, color: .black)

            Spacer()
            
            HStack {
                Spacer()
                
                // Mark as Completed button
                Button(action: {
                    viewModel.toggleCompletion(note: note)
                }) {
                    Image(systemName: note.isCompleted ? "xmark.circle" : "checkmark.circle")
                        .font(.largeTitle)
                        .frame(width: 110, height: 110)
                        .background(note.isCompleted ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .padding()
                }
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Note Details")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    showEditView = true
                }
            }
        }
        .sheet(isPresented: $showEditView) {
            AddEditNoteView(viewModel: viewModel, note: note)
        }
    }
}
