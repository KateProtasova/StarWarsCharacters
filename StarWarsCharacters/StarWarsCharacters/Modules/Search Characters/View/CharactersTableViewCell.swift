//
//  CharactersTableViewCell.swift
//  StarWarsCharacters
//
//  Created by Екатерина Протасова on 22.03.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    var viewModel: CharacterViewModel! {
        didSet {
            self.configure()
        }
    }

    func configure() {
        titleLabel.text = viewModel.name
    }
}
