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
    private let networkManager = NetworkManager(apiClient: APIClient())
    let searchText = PublishSubject<String>()

    var result: BehaviorSubject<[Character]> = BehaviorSubject(value: [])

    init() {
        fetchedCharacters()
    }

    func fetchedCharacters() {
        self.searchText
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { searchText -> Observable<[Character]> in
                if searchText.isEmpty {
                    return .just([])
                } else {
                    let tempArray = [Character(name: "aaa"), Character(name: "aaa"), Character(name: "aaa"), Character(name: "aaa")]

                    let networkData: Observable<[Character]> = self.networkManager.searchCharacters(text: searchText)
                        .scan([Character]()) { accum, root in
                            print("scan \(accum) \(root)")
                            return accum + root
                    }
                    if !tempArray.isEmpty {
                        let localData = Observable<[Character]>.create { observer in
                            observer.onNext(tempArray)
                            return Disposables.create()
                        }
                        return Observable.merge(localData, networkData)
                    }
                    return networkData
                }
        }
        .subscribe(onNext: { chars in
            self.result.on(.next(chars))
        }).disposed(by: disposeBag)
    }
}
