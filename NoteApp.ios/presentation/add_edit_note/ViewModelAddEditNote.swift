//
//  ViewModelAddEditNote.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 26/8/24.
//

import SwiftUI
import SwiftData

@Observable
class ViewModelAddEditNote {
    
    private var modelContext: ModelContext?
    
    var noteTitle = NoteTextFieldState(
        hint: "Enter title here...")
    var noteContent = NoteTextFieldState(
        hint: "Enter content here...")

    var noteColor: ColorModel = Color.red.toColorModel()
    
    var currentNoteId: UUID?
    
    init(noteId: UUID?) {
        self.currentNoteId = noteId
    }
    
    func updateModelContext(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func changeNoteColor(colorModel: ColorModel) {
        self.noteColor = colorModel
    }
    
    func fetchNoteById() {
        guard let modelContext = self.modelContext else {
            print("ModelContext Not found")
            return
        }
        guard let id = currentNoteId else {
            print("noteid nil")
            return
        }
        
        let fetchDescriptor = FetchDescriptor<Note>(
            predicate: #Predicate { $0.id == id }
        )
        
        
        
        do {
            let result = try modelContext.fetch(fetchDescriptor).first
            
            self.noteTitle.text = result!.title
            self.noteContent.text = result!.content
            self.noteColor = result!.colorModel
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    func save(dismiss: DismissAction) {
        guard let modelContext = self.modelContext else {
            print("ModelContext Not found")
            return
        }
        let note = Note(
            title: noteTitle.text,
            content: noteContent.text,
            colorModel: noteColor,
            id: currentNoteId ?? UUID()
        )
        modelContext.insert(note)
        print("\(note.title) was saved")
        try! modelContext.save()
        self.dismisScreen(dismiss: dismiss)
    }
    
    private func dismisScreen(dismiss: DismissAction) {
        dismiss()
    }
    
    
}
