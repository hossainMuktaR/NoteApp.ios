//
//  ScreenAddEditNote.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 26/8/24.
//

import SwiftUI

struct ScreenAddEditNote: View {
    var noteId: UUID?
    @State private var vm: ViewModelAddEditNote
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTextEditorFocused: Bool
    
    init(noteId: UUID?){
        _vm = State(initialValue: ViewModelAddEditNote(noteId: noteId))
    }

    var body: some View {
        VStack{
            HStack {
                ForEach(Note.noteColors, id: \.self) { colorModel in
                    Circle()
                        .fill(colorModel.toColor())
                        .frame(width: 50, height: 50)
                        .shadow(radius: 15)
                        .overlay(
                            Circle()
                                .stroke(
                                    vm.noteColor.toColor() == colorModel.toColor() ? Color.black : Color.clear,
                                    lineWidth: 3
                                )
                        )
                        .onTapGesture{
                            vm.changeNoteColor(colorModel: colorModel)
                        }
                        
                }
            }
            TextField(vm.noteTitle.hint, text: $vm.noteTitle.text)
                .font(.title)
                .padding()
            Divider()
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $vm.noteContent.text)
                    .focused($isTextEditorFocused)
                    .font(.body)
                    .padding()
                
                
                if vm.noteContent.text.isEmpty {
                    Text(vm.noteContent.hint)
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 24)
                        .onTapGesture {
                            isTextEditorFocused = true
                        }
                }
            }
            Spacer()
            HStack(alignment: .bottom){
                Spacer()
                Button(action: {
                    // save note to model container
                    vm.save(dismiss: dismiss)
                    
                }) {
                    Image(systemName: "tray.and.arrow.down")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(.trailing, 16)
                .padding(.bottom, 16)
            }
        }
        .onAppear{
            vm.updateModelContext(modelContext: modelContext)
            vm.fetchNoteById()
        }
    }
}

#Preview {
    ScreenAddEditNote(noteId: nil)
}
