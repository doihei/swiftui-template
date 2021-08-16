//
//  DateInputView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import SwiftUI

struct DateInputView: View {
    var inputDate: Published<Date?>.Publisher
    var title = R.string.localizable.dateInputViewDefaultTitle()
    var placeholder = R.string.localizable.dateInputViewDefaultPlaceholder()
    var format: String = "y/M/d"
    var datePickerMode: UIDatePicker.Mode = .date
    var datePickerInputViewExtra = DatePickerInputView.Extra()

    var body: some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color(R.color.gray()!))
                .frame(maxWidth: .infinity, alignment: .leading)
            DatePickerInputView(placeholder: placeholder, format: format, datePickerMode: datePickerMode)
        }
        .padding(EdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 16))
        .background(Color.white)
        .environmentObject(datePickerInputViewExtra)
        .onReceive(inputDate, perform: {
            datePickerInputViewExtra.date = $0
        })
    }
}
