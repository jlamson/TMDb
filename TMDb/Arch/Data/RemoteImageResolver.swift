//
//  RemoteImageResolver.swift
//  TMDb
//
//  Created by Joshua Lamson on 4/2/21.
//

import Foundation
import UIKit

protocol RemoteImageResolver{
    func load(imageAt url: URL, _ completion: @escaping (Result<UIImage>) -> Void)
}

class CachedRemoteImageResolver: RemoteImageResolver {
    
    private let cache: NSCache<AnyObject, AnyObject>
    
    init(cache: NSCache<AnyObject, AnyObject>) {
        self.cache = cache
    }
    
    func load(imageAt url: URL, _ completion: @escaping (Result<UIImage>) -> Void) {
        if let cachedImage = cache.object(forKey: url as AnyObject) as? UIImage {
            completion(.success(cachedImage))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async { completion(.error(error)) }
                return
            }
            guard let safeData = data else {
                DispatchQueue.main.async { completion(.error(SimpleError("Couldn't load image"))) }
                return
            }
            if let resolvedImage = UIImage(data: safeData) {
                self?.cache.setObject(resolvedImage, forKey: url as AnyObject)
                DispatchQueue.main.async { completion(.success(resolvedImage)) }
            } else {
                DispatchQueue.main.async {
                    completion(.error(SimpleError("Couldn't process downloaded data")))
                }
            }
        }.resume()
    }
}
