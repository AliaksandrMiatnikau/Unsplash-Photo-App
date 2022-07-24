//
//  TableViewCell.swift
//  Unsplash App
//
//  Created by Aliaksandr Miatnikau on 21.07.22.
//

import Foundation
import UIKit
import SDWebImage

class imageCell: UITableViewCell {
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        self.contentView.addSubview(image)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
    }
    
    private func setupViewFav() {
        
        self.contentView.addSubview(image)
        image.frame = CGRect(x:10, y:10, width: 50, height: 50)
        
        
    }
    
    public func setupCell(photo: PhotoList) {
        self.image.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.image.sd_setImage(with: URL(string: photo.image))
        
    }
    
    
}



