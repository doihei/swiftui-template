//
//  ItemEntity.swift
//  TemplateDataSources
//
//  Created by 土井大平 on 2021/08/10.
//

import Foundation

public struct ItemEntity: Decodable {
    public let login: String
    public let id: Int
    public let nodeId: String
    public let avatarUrl: String
    public let gravatarId: String
    public let url: String
    public let htmlUrl: String
    public let followersUrl: String
    public let subscriptionsUrl: String
    public let organizationsUrl: String
    public let reposUrl: String
    public let receivedEventsUrl: String
    public let type: String
    public let score: Int
    public let followingUrl: String
    public let gistsUrl: String
    public let starredUrl: String
    public let eventsUrl: String
    public let siteAdmin: Bool
}
