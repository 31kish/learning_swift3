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
    static func getItems(completion: ((Article?, Error?) -> ())?) -> HttpTask<Article> {
        let path = "/items"
        let task = HttpTask<Article>(path: path)
        task.execute(completion: completion)

        return task
    }
}

struct Article {
//    let httpStatusCode: Int?
//    let title: String?
//    let user: [String: AnyObject]?
//    let userID: String?
}

extension Article: Unboxable {
    init(unboxer: Unboxer) throws {
        print(unboxer)
//        httpStatusCode = unboxer.unbox(key: "http_status")
//        title = unboxer.unbox(key: "title")
//        user = unboxer.unbox(key: "user")
//        userID = ""
//        if let user = self.user {
//            userID = user["id"]
//        }
    }
}
