//
//  SearchCharacterViewModel.swift
//  StarWarsCharacters
//
//  Created by Екатерина Протасова on 22.03.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchCharacterViewModel {
    private let disposeBag = DisposeBag()
    private let apiClient = APIClient()
    let searchText = PublishSubject<String>()

    func bind() -> Observable<[Character]> {
        return self.searchText
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { searchText -> Observable<[Character]> in
                if searchText.isEmpty {
                    return .just([])
                } else {
                    let root: Observable<Characters> = self.apiClient.send(apiRequest: CharactersReques(name: searchText))
                    let chars: Observable<[Character]> = root.map {
                        $0.results
                    }
                    return chars
                }
        }
    }
}
