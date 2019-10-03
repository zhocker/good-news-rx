//
//  NewsTableViewController.swift
//  good-news
//
//  Created by macbook on 9/24/19.
//  Copyright © 2019 Tanawat Polsuwan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    private var disposeBag = DisposeBag()
    private var articles : [Article]? = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.populateNews()
    }
    
    private func populateNews() {
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 1024

        URLRequest.load(resource: ArticleList.all).subscribe(onNext:
            { [weak self] (result) in
            
                if let result = result {
                    self?.articles = result.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
                
            },onError: { (error) in
                
                print(error.localizedDescription)
                
        }).disposed(by: self.disposeBag)
        
        /*
        if let url : URL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=1a531cf91ab64d778f057c87ff7dfb08") {

            let resource = Resource<ArticleList>(url : url)
            URLRequest.load(resource: resource).subscribe(onNext: { [weak self] (result) in
         
                if let result = result {
                    self?.articles = result.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
         
            }).disposed(by: self.disposeBag)
         
        }
 */
        
        /*
        let newsURL = "https:newsapi.org/v2/top-headlines?country=th&category=business&apiKey=1a531cf91ab64d778f057c87ff7dfb08"
        let newsURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=1a531cf91ab64d778f057c87ff7dfb08"
        let url : URL = URL(string: newsURL)!
        Observable.just(url).flatMap { (url) -> Observable<Data> in
            
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
            
            }.map { data -> [Article]? in
                
                return try? JSONDecoder().decode(ArticleList.self, from: data).articles
                
            }.subscribe(onNext: { [weak self] (articles) in
                
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            }).disposed(by: self.disposeBag)
         */
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.articles?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell  else {
            fatalError("ArticleTableViewCell doesn't have")
        }
        
        if let item = self.articles?[indexPath.row] {
            cell.configCell(item:item, disposeBag: self.disposeBag)
        }
        
        /*
        cell.labelTitle.text = self.articles?[indexPath.row].title
        if let stringURL = self.articles?[indexPath.row].urlToImage,
            let url : URL = URL(string:stringURL) {
            
            URLRequest.loadURL(resourceURL:url).subscribe(onNext: { [unowned cell] (data) in
                
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imageViewNews.isHidden = false
                        cell.imageViewNews.image = UIImage(data: data)
                    }
                }
                
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }).disposed(by: self.disposeBag)

        } else {
            cell.imageViewNews.isHidden = true
        }
        
        cell.labelDesc.text = "\(self.articles?[indexPath.row].title)\(self.articles?[indexPath.row].title)"
         */
        
        return cell
        
    }


}
