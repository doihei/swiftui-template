//
//  GetSearchUsersResponse.swift
//  TemplateDataSources
//
//  Created by 土井大平 on 2021/08/10.
//

import Foundation

final public class GetSearchUsersResponse: Decodable {
    public let totalCount: Int
    public let incompleteResults: Bool
    public let items: [ItemEntity]
}
