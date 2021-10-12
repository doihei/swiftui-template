//
//  DatePickerInputView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import SwiftUI
import SwiftDate
import UIKit

struct DatePickerInputView: UIViewRepresentable {
    final class Extra: ObservableObject {
        @Published var date: Date?
    }

    @EnvironmentObject var extra: Extra // iOS14.2以降で、viewと関係ないプロパティが変更してもupdateUIViewが呼ばれないことへの対策
    let placeholder: String
    let format: String
    let datePickerMode: UIDatePicker.Mode

    func updateUIView(_ uiView: DatePickerTextField, context: Context) {
        uiView.updateText(date: extra.date)
    }

    func makeUIView(context: Context) -> DatePickerTextField {
        let datePickerTextField = DatePickerTextField(date: $extra.date, datePickerMode: datePickerMode, format: format, frame: .zero)
        datePickerTextField.placeholder = placeholder
        return datePickerTextField
    }
}

final class DatePickerTextField: UITextField {
    @Binding var date: Date?
    private let datePicker = UIDatePicker()
    private let format: String

    init(date: Binding<Date?>, datePickerMode: UIDatePicker.Mode, format: String, frame: CGRect) {
        self._date = date
        self.format = format
        super.init(frame: frame)
        self.font = .systemFont(ofSize: 15.5)
        inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerDidSelect(_:)), for: .valueChanged)
        datePicker.datePickerMode = datePickerMode
        datePicker.preferredDatePickerStyle = .wheels
        updateText(date: self.date)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func datePickerDidSelect(_ sender: UIDatePicker) {
        date = sender.date
    }

    func updateText(date: Date?) {
        self.text = date?.convertTo(region: .current).toString(.custom(format))
    }
}
