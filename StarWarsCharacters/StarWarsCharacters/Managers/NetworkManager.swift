//
//  NetworkManager.swift
//  StarWarsCharacters
//
//  Created by Екатерина Протасова on 29.03.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import RxSwift
import RxAlamofire

class NetworkManager {

    private let baseURL = URL(string: "https://swapi.co/api/")!
    private var apiClient: APIClient
    private let disposeBag = DisposeBag()
    private var characters = PublishSubject<[Character]>()

    private var params = PublishSubject<[String: String]>()

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    var lastText = ""

    func searchCharacters(text: String, page: String? = nil) -> PublishSubject<[Character]> {
        lastText = text
        return searchChars(text: text)
    }

    private func searchChars(text: String, page: String? = nil) -> PublishSubject<[Character]> {

        let request = CharactersRequest(searchText: text, page: page)
        let urlRequest = request.urlRequest(with: self.baseURL)
        let initial: Observable<Characters> = self.apiClient.send(urlRequest: urlRequest)

        initial.subscribe(onNext: { root in
            guard self.lastText == text else {
                return
            }
            self.characters.onNext(root.results)
            if let nextPath = root.next, let nextUrl = URL(string: nextPath), let searchValue = nextUrl.valueOf("search"), let page = nextUrl.valueOf("page") {
                print("nextUrl \(searchValue) \(page)" )

                self.characters = self.searchChars(text: searchValue, page: page)
            }
        }, onError: { error in
            print("Error")
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Dispose")
        }).disposed(by: self.disposeBag)

        return characters
    }
}
