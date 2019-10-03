//
//  URLRequest+Extension.swift
//  good-news
//
//  Created by macbook on 9/24/19.
//  Copyright © 2019 Tanawat Polsuwan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<Item:Decodable> {
    let url : URL
}

extension URLRequest {
    
    static func load<Item>(resource : Resource<Item>) -> Observable<Item?> {
        return Observable.from([resource.url]).flatMap({ (url) -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }).map({ (data) -> Item? in
            return try? JSONDecoder().decode(Item.self, from: data)
        }).asObservable()
    }
    
    static func loadURL(resourceURL : URL) -> Observable<Data?> {
        return Observable.from([resourceURL]).flatMap({ (url) -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request) 
        }).map({ (data) -> Data? in
            return data
        }).asObservable()
    }

    
}
