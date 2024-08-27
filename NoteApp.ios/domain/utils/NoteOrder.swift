//
//  NoteOrder.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 25/8/24.
//

import Foundation

class NoteOrder {
    let orderType: OrderType
    
    init(orderType: OrderType) {
        self.orderType = orderType
    }
    
    // The copy method which returns a new instance with the updated orderType
    func copy(with orderType: OrderType) -> NoteOrder {
        if let titleOrder = self as? TitleOrder {
            return TitleOrder(orderType: orderType)
        } else if let dateOrder = self as? DateOrder {
            return DateOrder(orderType: orderType)
        } else if let colorOrder = self as? ColorOrder {
            return ColorOrder(orderType: orderType)
        } else {
            fatalError("Unknown subclass of NoteOrder")
        }
    }
}

// Subclasses for each specific type of NoteOrder
class TitleOrder: NoteOrder {}
class DateOrder: NoteOrder {}
class ColorOrder: NoteOrder {}
