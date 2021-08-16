//
//  SampleGithubTranslator.swift
//  TemplateDomains
//
//  Created by 土井大平 on 2021/08/10.
//

import TemplateRepositories

final class SampleGithubTranslator {
    static func transrate(response: GetSearchUsersResponse) -> [Item] {
        return response.items.map { Item(id: $0.id, login: $0.login, avatarUrl: $0.avatarUrl, htmlUrl: $0.htmlUrl) }
    }
}

