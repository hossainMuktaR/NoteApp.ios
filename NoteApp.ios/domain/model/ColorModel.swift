//
//  ColorModel.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 28/8/24.
//

import SwiftUI
import SwiftData

@Model
final class ColorModel: Comparable {
    
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat

    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    // Implement the < operator to conform to Comparable
    static func < (lhs: ColorModel, rhs: ColorModel) -> Bool {
        return lhs.totalColorValue < rhs.totalColorValue
    }
    
    // Implement the == operator to conform to Equatable (Comparable requires Equatable)
    static func == (lhs: ColorModel, rhs: ColorModel) -> Bool {
        return lhs.totalColorValue == rhs.totalColorValue
    }
    
    // Helper computed property to calculate a total color value for comparison
    private var totalColorValue: CGFloat {
        return (red + green + blue + alpha)
    }
}



extension ColorModel {
    func toColor() -> Color {
        return Color(UIColor(
            red: self.red,
            green: self.green,
            blue: self.blue,
            alpha: self.alpha
        ))
    }
}
