//
//  RemoteAPIConcrete.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

struct RemoteAPIConcrete: RemoteAPI {

    // MARK: - Methods

    func fetchPictureGalleryDataModel<T>(url: URL?, then handler: @escaping (Result<T, RemoteAPIError>) -> Void) where T : Decodable {
        guard let url = url else {
            handler(.failure(.invalidEndpoint))
            return
        }

        URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    handler(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    handler(.success(model))
                } catch {
                    handler(.failure(.decodeError))
                }
            case .failure:
                handler(.failure(.apiError))
            }
        }.resume()
    }

    func loadImage(url: String, then handler: @escaping (Result<UIImage, RemoteAPIError>) -> Void) {
        guard let endpoint = URL(string: url) else {
            handler(.failure(.invalidEndpoint))
            return
        }

        URLSession.shared.dataTask(with: endpoint) { result in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    handler(.failure(.invalidResponse))
                    return
                }
                guard let image = UIImage(data: data) else {
                    handler(.failure(.decodeError))
                    return
                }
                handler(.success(image))
            case .failure:
                handler(.failure(.apiError))
            }
        }.resume()
    }

}
