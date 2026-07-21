//
//  ImageLoadOperation.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 14.07.2026.
//

import UIKit

enum Images: String {
    case imgNotPhoto = "imgNotPhoto"
    
    var image: UIImage? {
        if let image = UIImage(named: rawValue) {
            image
        } else {
            UIImage(named: Images.imgNotPhoto.rawValue)
        }
    }
}

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = URLCache.shared
    private let session: URLSession
    private let operationQueue: OperationQueue
    
    private init() {
        let config = URLSessionConfiguration.default
        config.urlCache = cache
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: config)
        
        self.operationQueue = OperationQueue()
        self.operationQueue.maxConcurrentOperationCount = 4
    }
    
    func loadImage(from urlString: String, into imageView: UIImageView, placeholder: UIImage? = nil) -> Cancellable? {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                imageView.image = placeholder
            }
            return nil
        }
        
        DispatchQueue.main.async {
            imageView.image = placeholder
        }
        
        let request = URLRequest(url: url)
        if let cachedData = cache.cachedResponse(for: request)?.data,
           let image = UIImage(data: cachedData) {
            DispatchQueue.main.async {
                imageView.image = image
            }
            return nil
        }
        
        // Создаем операцию
        let operation = ImageLoadOperation(url: url, session: session, cache: cache, request: request)
        operation.completionHandler = { [weak imageView] image in
            DispatchQueue.main.async {
                imageView?.image = image
            }
        }
        
        operationQueue.addOperation(operation)
        return operation
    }
    
    func cancelAllLoads() {
        operationQueue.cancelAllOperations()
    }
}

// Протокол для отмены загрузки
protocol Cancellable {
    func cancel()
}

extension Operation: Cancellable {}

// Операция загрузки картинки
class ImageLoadOperation: Operation, @unchecked Sendable {
    private let url: URL
    private let session: URLSession
    private let cache: URLCache
    private let request: URLRequest
    private var task: URLSessionDataTask?
    var completionHandler: ((UIImage?) -> Void)?
    
    init(url: URL, session: URLSession, cache: URLCache, request: URLRequest) {
        self.url = url
        self.session = session
        self.cache = cache
        self.request = request
        super.init()
    }
    
    override func main() {
        guard !isCancelled else { return }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        task = session.dataTask(with: url) { [weak self] data, response, error in
            defer { semaphore.signal() }
            
            guard let self = self, !self.isCancelled else { return }
            
            if let error = error {
                print("❌ Ошибка \(self.url.lastPathComponent): \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            // Сохраняем в кэш
            if let response = response {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                self.cache.storeCachedResponse(cachedResponse, for: self.request)
            }
            
            DispatchQueue.main.async {
                self.completionHandler?(image)
            }
        }
        
        task?.resume()
        semaphore.wait()
    }
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
}
