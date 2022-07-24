

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        setupTabBar()
        
        
        
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: HomeVC(), title: NSLocalizedString("Photos", comment: ""), image: UIImage(systemName: "photo")!, selectedImage: nil),
            createNavController(for: FavouriteVC(), title: NSLocalizedString("Favourite", comment: ""), image: UIImage(systemName: "star")!, selectedImage: nil),
        ]
        
    }
    private func setupTabBar() {
        
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
}





