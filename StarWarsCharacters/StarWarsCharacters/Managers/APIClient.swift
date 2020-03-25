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

    private let baseURL = URL(string: "https://swapi.co/api/")!

    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { [unowned self] observer in
            let request = apiRequest.request(with: self.baseURL)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                do {
                    let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
