//
//  CharactersRequest.swift
//  StarWarsCharacters
//
//  Created by Екатерина Протасова on 24.03.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import Foundation

class CharactersRequest: APIRequest {
    var method = RequestType.GET
    var path = "people/"
    var parameters = [String: String]()

    init(searchText: String, page: String? = nil) {
        parameters["search"] = searchText
        parameters["page"] = page
    }

    init(parameters: [String: String]? = nil) {
        self.parameters = parameters ?? [:]
    }
}
