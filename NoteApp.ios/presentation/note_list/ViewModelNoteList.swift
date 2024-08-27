//
//  ViewModelNoteList.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 26/8/24.
//

import Foundation
import SwiftData

@Observable
class ViewModelNoteList {
    private var modelContext: ModelContext?

    var state = StateNoteList()
    
    func toggleOrderVisibility() {
        state.isOrderSectionVisible = !state.isOrderSectionVisible
    }
    
    func changeNoteOrder(noteOrder: NoteOrder) {
        state.noteOrder = noteOrder
        fetchNoteByOrder(noteOrder: noteOrder)
    }
    
    func fetchNoteByOrder(noteOrder: NoteOrder = TitleOrder(orderType: .ascending)) {
        guard let modelContext = self.modelContext else {
            print("ModelContext Not found")
            return
        }
        var sortDescriptor: SortDescriptor<Note>
        switch noteOrder{
        case is TitleOrder:
            sortDescriptor = SortDescriptor(\.title, order: noteOrder.orderType == .ascending ? .forward : .reverse)
        case is DateOrder:
            sortDescriptor = SortDescriptor(\.timeStamp, order: noteOrder.orderType == .ascending ? .forward : .reverse)
        case is ColorOrder:
            sortDescriptor = SortDescriptor(\.colorModel, order: noteOrder.orderType == .ascending ? .forward : .reverse)
        default:
            fatalError("Unknown NoteOrder type")
        }
        
        let fetchDescriptor = FetchDescriptor<Note>(
            sortBy: [sortDescriptor]
        )
        do {
            let result = try modelContext.fetch(fetchDescriptor)
            self.state.notes = result
           
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func delete(note: Note) {
        guard let modelContext = self.modelContext else {
            print("ModelContext Not found")
            return
        }
        modelContext.delete(note)
        fetchNoteByOrder()
    }
    
    
    func updateModelContext(modelContext: ModelContext){
        self.modelContext = modelContext
    }
}
