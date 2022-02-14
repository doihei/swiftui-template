//
//  GetFollowingsResponse.swift
//  TemplateDataSources
//
//  Created by ykkd on 2021/10/11.
//

import Foundation

final public class GetFollowingsResponse: Decodable {
    public let items: [ItemEntity]
}
