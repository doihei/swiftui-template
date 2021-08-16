//
//  ErrorType.swift
//  TemplateDataSources
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

/// エラータイプ
/// - failVersionIncompatible: 非対応バージョンからのリクエスト。アップデートを強制する (ストアに誘導)
public enum ErrorType: String {
    case failVersionIncompatible = "fatal.client_application.incompatible"
}
