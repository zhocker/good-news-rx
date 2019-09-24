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

struct Article : Decodable {
    let title : String?
    let description : String?
}
