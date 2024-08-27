//
//  OrderSection.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 25/8/24.
//

import SwiftUI

struct OrderSection: View {
        var noteOrder: NoteOrder
        var onOrderChange: (NoteOrder) -> Void
        
        var body: some View {
            VStack(alignment: .center) {
                HStack {
                    RadioButton(
                        text: "Title",
                        selected: noteOrder is TitleOrder,
                        onSelect: { onOrderChange(TitleOrder(orderType: noteOrder.orderType)) }
                    )
                    RadioButton(
                        text: "Date",
                        selected: noteOrder is DateOrder,
                        onSelect: { onOrderChange(DateOrder(orderType: noteOrder.orderType)) }
                    )
                    RadioButton(
                        text: "Color",
                        selected: noteOrder is ColorOrder,
                        onSelect: { onOrderChange(ColorOrder(orderType: noteOrder.orderType)) }
                    )
                }
                Spacer().frame(height: 8)
                HStack {
                    RadioButton(
                        text: "Ascending",
                        selected: noteOrder.orderType == .ascending,
                        onSelect: { onOrderChange(noteOrder.copy(with: .ascending)) }
                    )
                    RadioButton(
                        text: "Descending",
                        selected: noteOrder.orderType == .descending,
                        onSelect: { onOrderChange(noteOrder.copy(with: .descending)) }
                    )
                }
            }
            .padding()
        }
    }

#Preview {
    OrderSection(
        noteOrder: TitleOrder(orderType: .descending), onOrderChange: { _ in }
    )
}
