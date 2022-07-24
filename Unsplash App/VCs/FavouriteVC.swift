
import Foundation
import UIKit

class FavouriteVC: UIViewController {
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 110
        tableView.register(imageCellFav.self, forCellReuseIdentifier: "imageCellFav")
        
        return tableView
        
    }()
    let refreshControl = UIRefreshControl()
    public var favPhotos: [PhotoList] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    var photosFavouriteArray: [PhotoList] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favourite"
        
        view.backgroundColor = .white
        
        setupView()
        NetworkManager.shared.getLikedPhotosRequest { result in
            switch result {
            case .success(let photos):
                self.photosFavouriteArray.removeAll()
                self.photosFavouriteArray = photos
            case .failure(_):
                print("error")
            }
        }
        refreshPage()
        
        
    }
    
    
    private func setupViewFav() {
        
        self.view.addSubview(tableView)
        
    }
    private func setupView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    private func refreshPage() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    
}
extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return photosFavouriteArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCellFav", for: indexPath) as? imageCellFav else {  return UITableViewCell() }
        cell.setupCell(photo: photosFavouriteArray[indexPath.row])
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailedVC()
        vc.getPhotos(id: photosFavouriteArray[indexPath.row].photoId)
        vc.image.sd_setImage(with: URL(string: photosFavouriteArray[indexPath.row].image))
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    @objc func refresh() {
        NetworkManager.shared.getLikedPhotosRequest { result in
            switch result {
            case .success(let photos):
                self.photosFavouriteArray.removeAll()
                self.photosFavouriteArray = photos
                self.refreshControl.endRefreshing()
            case .failure(_):
                print("error")
            }
        }
    }
}



