//
//  NoteItem.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 25/8/24.
//

import SwiftUI

struct NoteItem: View {
    var note: Note
    var cornerRadius: CGFloat = 10
    var cutCornerSize: CGFloat = 30
    var onDeleteClick: (Note) -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            //             Custom background with the cut corner effect
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: width - cutCornerSize, y: 0))
                    path.addLine(to: CGPoint(x: width, y: cutCornerSize))
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.closeSubpath()
                }
                .fill(Color(note.colorModel.toColor())) // Main note color
                
                Path { path in
                    path.move(to: CGPoint(x: width - cutCornerSize, y: 0))
                    path.addLine(to: CGPoint(x: width, y: cutCornerSize))
                    path.addLine(to: CGPoint(x: width, y: 100))
                    path.addLine(to: CGPoint(x: width - cutCornerSize + 100, y: 100))
                    path.closeSubpath()
                }
                .fill(Color(note.colorModel.toColor()).opacity(0.8)) // Darker color for the corner effect
                .cornerRadius(cornerRadius)
            }
            
            // Note content
            VStack(alignment: .leading, spacing: 8) {
                Text(note.title)
                    .font(.headline)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text(note.content)
                    .font(.body)
                    .foregroundStyle(.black)
                    .lineLimit(10)
                    .truncationMode(.tail)
            }
            .padding(.all, 16)
            .padding(.trailing, 32)
            
            // Delete button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {onDeleteClick(note)}) {
                        Image(systemName: "trash")
                            .foregroundStyle(.black)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, 16)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(radius: 5)
    }
}



#Preview {
    NoteItem(
        note: Note(
            title: "Sample Note",
            content: "This is the content of the note.",
            colorModel: Color.red.toColorModel(),
            id: UUID()
        ),
        onDeleteClick: { _ in }
    )
}
