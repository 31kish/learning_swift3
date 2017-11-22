//
//  QiitaArticleAPI.swift
//  learning_swift
//
//  Created by 桑原慶之 on 2017/11/17.
//  Copyright © 2017年 KeishiKuwabara. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

class QiitaArticleAPI : HttpTask<Article> {
    static func getItems(completion: (([Article?], Error?) -> ())?) -> HttpTask<Article> {
        let path = "/items"
        let task = HttpTask<Article>(path: path)
        task.execute(completion: completion)

        return task
    }
}

struct Article {
    let title: String?
    let urlStr: String?
    let user: User?
}

extension Article: Unboxable {
    init(unboxer: Unboxer) throws {
        title = unboxer.unbox(key: "title")
        user = unboxer.unbox(key: "user")
        urlStr = unboxer.unbox(key: "url")
    }
}

struct User {
    let id: String?
}

extension User: Unboxable {
    init(unboxer: Unboxer) throws {
        id = unboxer.unbox(key: "id")
    }
}
