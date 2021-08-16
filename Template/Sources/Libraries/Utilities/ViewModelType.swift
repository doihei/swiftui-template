//
//  ViewModel.swift
//  Template
//
//  Created by doi on 2021/07/26.
//

import Foundation

protocol ViewModelType: ObservableObject {
    associatedtype Input
    associatedtype Output

    var input: Input { get set }
    var output: Output { get set }
}
