
import Foundation
import UIKit


class HomeVC: UIViewController, UISearchBarDelegate  {
    
    
    
    
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UIScreen.main.bounds.width - 20
        tableView.register(imageCell.self, forCellReuseIdentifier: "imageCell")
        
        return tableView
    }()
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    var photosArray: [PhotoList] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Photos"
        
        view.backgroundColor = .white
        //        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        setupView()
        NetworkManager.shared.getPhotosRequest { result in
            switch result {
            case .success(let photos):
                self.photosArray = photos
            case .failure(_):
                print("error")
            }
        }
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        NetworkManager.shared.searchPhotos(with: text) { result in
            switch result {
            case .success(let photos):
                self.photosArray.removeAll()
                self.photosArray = photos
            case .failure(_):
                print("error")
            }
        }
        print(text)
    }
    
    
    
    
}
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return photosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? imageCell else {  return UITableViewCell() }
        cell.setupCell(photo: photosArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailedVC()
        vc.getPhotos(id: photosArray[indexPath.row].photoId)
        vc.image.sd_setImage(with: URL(string: photosArray[indexPath.row].image))
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        
    }
    
    
}
