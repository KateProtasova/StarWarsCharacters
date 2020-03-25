//
//  CharactersRequest.swift
//  StarWarsCharacters
//
//  Created by Екатерина Протасова on 24.03.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

class CharactersReques: APIRequest {
    var method = RequestType.GET
    var path = "people/"
    var parameters = [String: String]()

    init(name: String) {
        parameters["search"] = name
    }
}
