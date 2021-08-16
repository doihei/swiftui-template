//
//  PickerField.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import SwiftUI

struct PickerField: UIViewRepresentable {
    @Binding var inputText: String
    @Binding var contents: [[String]]

    var selectedComponentRow: [Int: (component: Int, row: Int)] = [:]
    var placeholder: String = R.string.localizable.textInputViewDefaultPickerFieldPlaceholder()

    private let textField = UITextField()
    private let picker = UIPickerView()

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<PickerField>) -> UITextField {
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        picker.tintColor = .black
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.systemBlue
        toolBar.sizeToFit()
        let doneButtonItem = UIBarButtonItem(title: R.string.localizable.commonDialogDoneButtonTitle(),
                                             style: UIBarButtonItem.Style.plain,
                                             target: context.coordinator,
                                             action: #selector(context.coordinator.donePicker))
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleItem, doneButtonItem], animated: false)
        textField.placeholder = placeholder
        textField.font = .systemFont(ofSize: 15.5)
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<PickerField>) {
        uiView.text = inputText
    }
}

extension PickerField {
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
        private enum Const {
            static let delimiter: String = ","
        }

        private var parent: PickerField

        init(_ parent: PickerField) {
            self.parent = parent
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            self.parent.contents.count
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            self.parent.contents[component].count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            self.parent.contents[component][row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selectedComponentRow[component] = (component: component, row: row)
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.textField.resignFirstResponder()
        }

        @objc func donePicker() {
            if 0 < self.parent.contents.count {
                let text = (0...self.parent.contents.count - 1)
                    .compactMap {
                        parent.selectedComponentRow[$0]
                    }
                    .map {
                        parent.contents[$0.component][$0.row]
                    }
                    .joined(separator: Const.delimiter)
                self.parent.textField.text = text
                self.parent.inputText = text
            }
            self.parent.textField.endEditing(true)
        }
   }
}
