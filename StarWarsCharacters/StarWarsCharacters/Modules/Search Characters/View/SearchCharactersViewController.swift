//
//  SearchCharactersViewController.swift
//  StarWarsCharacters
//
//  Created by Екатерина Протасова on 22.03.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchCharactersViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: SearchCharacterViewModel!
    private let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = SearchCharacterViewModel()

        setupTableView()
        setupSearchBar()

        bindSearchBar()
        bindTableView()
    }

    // MARK: - Binding

    func bindTableView() {
        viewModel.bind()
            .bind(to: tableView.rx.items(cellIdentifier: "CharactersTableViewCell", cellType: CharactersTableViewCell.self)) {(index, character: Character, cell) in
                cell.viewModel = CharacterViewModel(character: character)
        }
        .disposed(by: disposeBag)
    }

    func bindSearchBar() {
        searchController.searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
    }

    // MARK: - UI Setup

    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }

    func setupTableView() {
        tableView.register(UINib(nibName: "CharactersTableViewCell", bundle: nil), forCellReuseIdentifier: "CharactersTableViewCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

}
