//
//  ScreenNoteList.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 26/8/24.
//

import SwiftUI
import SwiftData

struct ScreenNoteList: View {
    private var vm = ViewModelNoteList()
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack{
            if(vm.state.isOrderSectionVisible) {
                OrderSection(noteOrder: vm.state.noteOrder , onOrderChange: { noteOrder in
                    withAnimation{
                        vm.changeNoteOrder(noteOrder: noteOrder)
                    }
                })
            }
            ScrollView{
                VStack(spacing: 16){
                    ForEach(vm.state.notes, id: \.timeStamp) { note in
                        NavigationLink(destination: ScreenAddEditNote(noteId: note.id)){
                            
                            NoteItem(note: note, onDeleteClick: { note in
                                //delete note
                                withAnimation{
                                    vm.delete(note: note)
                                }
                            })
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
            HStack(alignment: .bottom){
                Spacer()
                NavigationLink(destination: ScreenAddEditNote(noteId: nil)){
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(.trailing, 16)
                .padding(.bottom, 16)
            }
            
        }
        .navigationTitle("Your Note")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    //visible and hide orderSection
                    withAnimation{
                        vm.toggleOrderVisibility()
                    }
                }, label: {
                    Image(systemName: "arrow.up.arrow.down")
                })
            }
        }
        .onAppear {
            vm.updateModelContext(modelContext: modelContext)
            print("notelist on apeare call")
            vm.fetchNoteByOrder(noteOrder: vm.state.noteOrder)
        }
        
    }
}

#Preview {
    ScreenNoteList()
}
