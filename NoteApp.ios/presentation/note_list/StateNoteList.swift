//
//  StateNoteList.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 25/8/24.
//

import Foundation

struct StateNoteList {
    var notes: [Note] = []
    var noteOrder: NoteOrder = DateOrder(orderType: .descending)
    var isOrderSectionVisible: Bool = false
}
