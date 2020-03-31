//
//  APIClient.swift
//  StarWarsCharacters
//
//  Created by Екатерина Протасова on 23.03.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import RxSwift
import RxAlamofire

class APIClient {
    func send<T: Codable>(urlRequest: URLRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                do {
                   let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)
                    observer.onCompleted()
                } catch let error {
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
