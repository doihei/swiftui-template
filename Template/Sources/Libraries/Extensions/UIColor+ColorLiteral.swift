//
//  UIColor+ColorLiteral.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import UIKit

extension UIColor {
    
    // swiftlint:disable type_name
    /// アプリ定義色
    class iOSTemplate {
        
        /// 統一背景色
        class var background: UIColor { return #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1) }
        
        /// サンプル画面色
        class Sample {
            /// ボタン
            class var buttonColor: UIColor { return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1) }
        }
    }
}
