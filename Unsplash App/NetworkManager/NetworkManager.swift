
import Foundation
import UIKit
import Alamofire
import SwiftyJSON

final class NetworkManager {
    static let shared = NetworkManager()
}

extension NetworkManager {
    public func getPhotosRequest(completion: @escaping (Result<[PhotoList], Error>) -> Void) {
        AF.request("https://api.unsplash.com/photos/?per_page=30&client_id=pr0bIO6R5hQnV-tABGx4Kf3KuhxBof8dbpim4EqoHck", method: .get).responseJSON { result in
            switch result.result {
            case .success(let value):
                let json = JSON(value)
                var photos: [PhotoList] = []
                guard let photosArray = json.array
                else {
                    completion(.failure(NetworkErrors.FailedToFetchData))
                    return
                    
                }
                for photo in photosArray {
                    guard let id = photo["id"].string ,
                          let authorName = photo["user"]["username"].string,
                          let image = photo["urls"]["small"].string
                    else {
                        completion(.failure(NetworkErrors.FailedToFetchData))
                        return }
                    photos.append(PhotoList(photoId: id, authorName: authorName, image: image))
                }
                completion(.success(photos))
            case .failure(_):
                completion(.failure(NetworkErrors.FailedToFetchData))
            }
        }
    }
    
    public func searchPhotos(with query: String, completion: @escaping (Result<[PhotoList], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        AF.request("https://api.unsplash.com/search/collections?per_page=30&query=\(query)&client_id=pr0bIO6R5hQnV-tABGx4Kf3KuhxBof8dbpim4EqoHck", method: .get).responseJSON { result in
            switch result.result {
            case .success(let value):
                let json = JSON(value)
                var photos: [PhotoList] = []
                guard let photosArray = json["results"].array
                else {
                    completion(.failure(NetworkErrors.FailedToFetchData))
                    return
                    
                }
                for photo in photosArray {
                    guard let id = photo["id"].string,
                          let authorName = photo["user"]["username"].string,
                          let image = photo["cover_photo"]["urls"]["small"].string
                    else {
                        completion(.failure(NetworkErrors.FailedToFetchData))
                        return }
                    photos.append(PhotoList(photoId: id, authorName: authorName, image: image))
                }
                completion(.success(photos))
            case .failure(_):
                completion(.failure(NetworkErrors.FailedToFetchData))
            }
        }
    }
    
    public func getPhotoDetails(about photoId: String, completion: @escaping (Result<DetailedInfo, Error>) -> Void) {
        
        AF.request("https://api.unsplash.com/photos/\(photoId)?client_id=pr0bIO6R5hQnV-tABGx4Kf3KuhxBof8dbpim4EqoHck", method: .get).responseJSON { result in
            switch result.result {
            case .success(let value):
                let json = JSON(value)
                
                guard let creationDate = json["created_at"].string,
                      let authorName = json["user"]["name"].string,
                      let numOfDownloads = json["downloads"].int,
                      let likedByUser = json["liked_by_user"].bool,
                      let location = json["user"]["location"].string != nil ? json["user"]["location"].string : "no info"
                        
                else {
                    completion(.failure(NetworkErrors.FailedToFetchData))
                    return }
                
                completion(.success(DetailedInfo(authorName: authorName,
                                                 dateOfCreation: String(creationDate.dropLast(15)),
                                                 location: location,
                                                 numberOfDownloads: numOfDownloads,
                                                 liked: likedByUser)))
                
            case .failure(_):
                completion(.failure(NetworkErrors.FailedToFetchData))
            }
        }
    }
    public func getLikedPhotosRequest(completion: @escaping (Result<[PhotoList], Error>) -> Void) {
        AF.request("https://api.unsplash.com/users/alx_mint/likes?per_page=30&client_id=pr0bIO6R5hQnV-tABGx4Kf3KuhxBof8dbpim4EqoHck", method: .get).responseJSON { result in
            switch result.result {
            case .success(let value):
                let json = JSON(value)
                var photos: [PhotoList] = []
                guard let photosArray = json.array
                else {
                    completion(.failure(NetworkErrors.FailedToFetchData))
                    return
                    
                }
                for photo in photosArray {
                    guard let id = photo["id"].string ,
                          let authorName = photo["user"]["username"].string,
                          let image = photo["urls"]["small"].string
                    else {
                        completion(.failure(NetworkErrors.FailedToFetchData))
                        return }
                    photos.append(PhotoList(photoId: id, authorName: authorName, image: image))
                }
                completion(.success(photos))
            case .failure(_):
                completion(.failure(NetworkErrors.FailedToFetchData))
            }
        }
    }
    
    public func likeAPhoto(about photoId: String, completion: @escaping (Result<DetailedInfo, Error>) -> Void) {
        
        AF.request("https://api.unsplash.com/photos/\(photoId)/like?client_id=pr0bIO6R5hQnV-tABGx4Kf3KuhxBof8dbpim4EqoHck", method: .post).responseJSON { result in
            switch result.result {
            case .success(let value):
                let json = JSON(value)
                guard let creationDate = json["created_at"].string,
                      let authorName = json["user"]["name"].string,
                      let numOfDownloads = json["downloads"].int,
                      let likedByUser = json["liked_by_user"].bool,
                      let location = json["user"]["location"].string != nil ? json["user"]["location"].string : "no info"
                else {
                    completion(.failure(NetworkErrors.FailedToFetchData))
                    return }
                
                completion(.success(DetailedInfo(authorName: authorName,
                                                 dateOfCreation: String(creationDate.dropLast(15)),
                                                 location: location,
                                                 numberOfDownloads: numOfDownloads,
                                                 liked: likedByUser)))
                
            case .failure(_):
                completion(.failure(NetworkErrors.FailedToFetchData))
            }
        }
    }
    
}



public enum NetworkErrors: Error {
    case FailedToFetchData
    
}





