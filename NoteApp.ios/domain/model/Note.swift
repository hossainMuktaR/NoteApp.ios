//
//  Note.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 25/8/24.
//
import SwiftUI
import SwiftData

@Model
class Note: Identifiable {
    let title: String
    let content: String
    let timeStamp: Double
    let colorModel: ColorModel
    @Attribute(.unique) let id: UUID
    
    // Companion object equivalent in Swift
    static let noteColors: [ColorModel] = [
        Color.red.toColorModel(), Color.green.toColorModel(), Color.purple.toColorModel(), Color.blue.toColorModel(), Color.pink.toColorModel()
    ]
    
    init(title: String, content: String, timeStamp: Double = Date().timeIntervalSince1970, colorModel: ColorModel, id: UUID) {
        self.title = title
        self.content = content
        self.timeStamp = timeStamp
        self.id = id
        self.colorModel = colorModel
        
    }
}

extension Color {
    func toColorModel() -> ColorModel {
        let uiColor = UIColor(self)
        return ColorModel(
            red: uiColor.cgColor.components?[0] ?? 0,
            green: uiColor.cgColor.components?[1] ?? 0,
            blue: uiColor.cgColor.components?[2] ?? 0,
            alpha: uiColor.cgColor.alpha
        )
    }
}

