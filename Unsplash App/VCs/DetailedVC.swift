

import Foundation
import UIKit
import SDWebImage


class DetailedVC: UIViewController {
    
    private let backButton = UIButton()
    private let likeButton = UIButton()
    var currentPhotoData: PhotoList?
    
    public var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .red
        image.image = UIImage(named: "")
        return image
    }()
    
    private var authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var creationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var numderOfDownloadsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private var photoID: String = ""
    private var imagePhoto: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Photos"
        setupView()
        setBackButton()
        setLikeButton()
        view.backgroundColor = .white
        
        
    }
    
    func getPhotos(id: String){
        NetworkManager.shared.getPhotoDetails(about: id) { result in
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {
                        return
                    }
                    self.setupLabels(with: photos)
                }
                
            case .failure(_):
                print("error")
            }
        }
    }
    private func setupLabels(with: DetailedInfo) {
        
        self.authorNameLabel.text = "   👤 Author:  \(with.authorName)"
        self.numderOfDownloadsLabel.text = "   ⬇️ Downloads:  \(with.numberOfDownloads)"
        self.locationLabel.text = "   🧭 Location:  \(with.location)"
        self.creationDateLabel.text = "   📅 Date:  \(with.dateOfCreation) "
        
    }
    
    
    private func setupView() {
        image.backgroundColor = .white
        self.view.addSubview(image)
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
            image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        self.view.addSubview(authorNameLabel)
        authorNameLabel.backgroundColor = .white
        authorNameLabel.textAlignment = .left
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height * 0.13),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 30),
            authorNameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
            
        ])
        
        
        self.view.addSubview(creationDateLabel)
        creationDateLabel.backgroundColor = .white
        creationDateLabel.textAlignment = .left
        NSLayoutConstraint.activate([
            creationDateLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height * 0.19),
            creationDateLabel.heightAnchor.constraint(equalToConstant: 30),
            creationDateLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        self.view.addSubview(locationLabel)
        locationLabel.backgroundColor = .white
        locationLabel.textAlignment = .left
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height * 0.8),
            locationLabel.heightAnchor.constraint(equalToConstant: 30),
            locationLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        self.view.addSubview(numderOfDownloadsLabel)
        numderOfDownloadsLabel.backgroundColor = .white
        numderOfDownloadsLabel.textAlignment = .left
        NSLayoutConstraint.activate([
            numderOfDownloadsLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height * 0.86),
            numderOfDownloadsLabel.heightAnchor.constraint(equalToConstant: 30),
            numderOfDownloadsLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        
        
        
    }
    
    private func setBackButton() {
        
        backButton.frame = CGRect(x: 10, y: 40, width: view.bounds.maxY / 10, height: view.bounds.maxX / 10)
        backButton.backgroundColor = .clear
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.blue, for: .normal)
        backButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    private func setLikeButton() {
        
        likeButton.frame = CGRect(x: view.bounds.maxX * 0.75, y: 40, width: view.bounds.maxY / 10, height: view.bounds.maxX / 10)
        likeButton.backgroundColor = .clear
        likeButton.setTitle("Like❤️", for: .normal)
        likeButton.setTitleColor(.blue, for: .normal)
        likeButton.addTarget(self, action: #selector(alertCall), for: .touchUpInside)
        view.addSubview(likeButton)
    }
    
    
    
    @objc private func backToMenu () {
        self.dismiss(animated: true)
    }
    
    
    @objc private func alertCall () {
        self.showAlert(title: "WOW", text: "You liked it!")
        
    }
    
    //    @objc private func likePhoto(){
    //        guard let currentPhotoData = self.currentPhotoData else { return }
    //        if currentPhotoData.liked {
    //            self.likeButton.setTitle("Like❤️", for: .normal)
    //            NetworkManager.shared.likeAPhoto(about: <#T##String#>, completion: <#T##(Result<DetailedInfo, Error>) -> Void#>)
    //        } else {
    //            self.addFavoritButton.setTitle("Удалить из избранного", for: .normal)
    //            networkService.likePhoto(id: currentPhotoData.id)
    //        }
    //    }
}




