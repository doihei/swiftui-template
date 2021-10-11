//
//  SampleGithubFollowingTranslator.swift
//  TemplateDomains
//
//  Created by ykkd on 2021/10/11.
//

import TemplateRepositories

final class SampleGithubFollowingTranslator {
    static func transrate(response: GetFollowingsResponse) -> [Item] {
        return response.items.map { Item(id: $0.id, login: $0.login, avatarUrl: $0.avatarUrl, htmlUrl: $0.htmlUrl) }
    }
}
