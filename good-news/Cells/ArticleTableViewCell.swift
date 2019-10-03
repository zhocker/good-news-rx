//
//  ArticleTableViewCell.swift
//  good-news
//
//  Created by macbook on 9/24/19.
//  Copyright © 2019 Tanawat Polsuwan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var labelDesc : UILabel!
    @IBOutlet weak var imageViewNews: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(item : Article, disposeBag : DisposeBag) {
        
        self.labelTitle.text = item.title
        self.labelDesc.text = "\(item.title)\(item.title)"

        if let stringURL = item.urlToImage,let url : URL = URL(string:stringURL) {
            
            URLRequest.loadURL(resourceURL:url).subscribe(onNext: { [unowned self] (data) in
                
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageViewNews.isHidden = false
                        self.imageViewNews.image = UIImage(data: data)
                    }
                }
                
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }).disposed(by:disposeBag)

        } else {
            self.imageViewNews.isHidden = true
        }
        
//        URLRequest.loadURL(resourceURL:url).subscribe(onNext: { [unowned self] (data) in
//
//            if let data = data {
//                DispatchQueue.main.async {
//                    self.imageViewNews.isHidden = false
//                    self.imageViewNews.image = UIImage(data: data)
//                }
//            }
//
//        }, onError: { (error) in
//
//        }, onCompleted: {
//
//        }).disposed(by:disposeBag)
        
    }

}
