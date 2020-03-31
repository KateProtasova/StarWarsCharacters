//
//  URL.swift
//  StarWarsCharacters
//
//  Created by Екатерина Протасова on 29.03.2020.
//  Copyright © 2020 Екатерина Протасова. All rights reserved.
//

import UIKit

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else {
            return nil
        }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
