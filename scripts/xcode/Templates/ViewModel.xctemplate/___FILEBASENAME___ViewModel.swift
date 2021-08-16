//___FILEHEADER___

import RxCocoa
import RxSwift
import Unio

protocol ___VARIABLE_productName___ViewModelType: AnyObject {
    var input: InputWrapper<___VARIABLE_productName___ViewModel.Input> { get }
    var output: OutputWrapper<___VARIABLE_productName___ViewModel.Output> { get }
}

final class ___VARIABLE_productName___ViewModel: UnioStream<___VARIABLE_productName___ViewModel>, ___VARIABLE_productName___ViewModelType {

    init(extra: Extra = .init()) {
        super.init(input: Input(),
                   state: State(),
                   extra: extra)
    }
}

extension ___VARIABLE_productName___ViewModel {

    struct Input: InputType {}

    struct Output: OutputType {}

    struct State: StateType {}

    struct Extra: ExtraType {}
}

extension ___VARIABLE_productName___ViewModel {

    static func bind(from dependency: Dependency<Input, State, Extra>, disposeBag: DisposeBag) -> Output {

        return Output()
    }
}
