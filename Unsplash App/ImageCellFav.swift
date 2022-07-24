//
//  TableViewCell.swift
//  Unsplash App
//
//  Created by Aliaksandr Miatnikau on 21.07.22.
//

import Foundation
import UIKit
import SDWebImage

class imageCellFav: UITableViewCell {
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewFav()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func setupViewFav() {
        
        self.contentView.addSubview(image)
        image.frame = CGRect(x:10, y:10, width: 100, height: 100)
        
        
    }
    
    public func setupCell(photo: PhotoList) {
        self.image.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.image.sd_setImage(with: URL(string: photo.image))
        self.textLabel?.text = "   👤 :  \(photo.authorName)"
        self.textLabel?.textAlignment = .right
        
        
    }
    
    
}



