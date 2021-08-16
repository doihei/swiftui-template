//
//  SampleView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//

import Combine
import SwiftUI

struct SampleView<ViewModel: SampleViewModelType>: View {
    @ObservedObject var viewModel: ViewModel

    let presenter: SamplePresenter
    let dismissObject: DismissableDelegateObject<Self>

    var body: some View {
        ZStack {
            Color(UIColor.iOSTemplate.background)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Button(
                    action: {
                        presenter.input.didTapInputButton.send(())
                    },
                    label: {
                        Text(R.string.sample.inputButtonTittle())
                            .foregroundColor(Color(UIColor.iOSTemplate.Sample.buttonColor))
                    }
                )
                .frame(maxWidth: .infinity)
                .frame(height: 50)
            }
        }
        .onAppear {
            viewModel.input.getSample.send(())
        }
        .onReceive(viewModel.output.$sample.receive(on: DispatchQueue.main)) {
            print($0?.intValue ?? 0)
        }
    }
}

#if DEBUG
struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SampleView(viewModel: SampleViewModel.mock, presenter: .init(navigator: .init()), dismissObject: DismissableDelegateObject())
        }
    }
}
#endif
