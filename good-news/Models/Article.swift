//
//  Article.swift
//  good-news
//
//  Created by macbook on 9/24/19.
//  Copyright © 2019 Tanawat Polsuwan. All rights reserved.
//

import Foundation

struct ArticleList : Decodable {
    let articles : [Article]
}

extension ArticleList {
    static var all : Resource<ArticleList> {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=1a531cf91ab64d778f057c87ff7dfb08")!
        let resource = Resource<ArticleList>(url : url)
        return resource
    }
}

struct Article : Decodable {
    let title : String?
    let description : String?
}
