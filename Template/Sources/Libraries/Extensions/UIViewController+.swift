//
//  UIViewController+.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import SVProgressHUD
import UIKit

extension UIViewController {
    
    /// Navigationの戻るボタンの文言削除
    func deleteNavigationBackString() {
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
    }

    /// NetworkState更新による共通UI処理
    ///
    /// - Parameter status: NetworkState
    /// - Parameter errorActionHandler: エラーダイアログのアクション処理
    func updateNetworkState(_ networkState: NetworkState) {
        updateNetworkState(networkState, errorActionHandler: nil)
    }

    /// NetworkState更新による共通UI処理
    ///
    /// - Parameter status: NetworkState
    func updateNetworkState(_ networkState: NetworkState,
                            errorActionHandler: (() -> Void)?) {

        switch networkState {
        case .error(let templateError):
            let errorMessage: String
            switch templateError {
            case .apiError(let error):
                errorMessage = error.message

            case .dataSourceError(let error):
                switch error {
                case .requestTimeout:
                    errorMessage = R.string.localizable.networkErrorDialogMessage()
                default:
                    errorMessage = R.string.localizable.networkErrorDialogMessage()
                }
            case .unknownError:
                errorMessage = R.string.localizable.unknownErrorDialogMessage()
            }

            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: R.string.localizable.commonDialogOkButtonTitle(), style: .cancel,
                                       handler: { [weak self] action in
                                        self?.forceUpdate(networkState: networkState)
                                        errorActionHandler?()
            })
            alert.addAction(action)
            self.present(alert, animated: true)
        case .loading:
            SVProgressHUD.show()
        case .normal:
            SVProgressHUD.dismiss()
        }
    }

    /// 強制アップデート検証
    ///
    /// - Parameter status: ViewModelStatus
    private func forceUpdate(networkState: NetworkState) {
        guard case .error(let error) = networkState,
            case .apiError(let apiError) = error,
            apiError.type == .failVersionIncompatible,
            let url = URL(string: R.string.urLs.appStore()) else { return }
        UIApplication.shared.open(url)
    }
}
