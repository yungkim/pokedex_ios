//
//  Pokemon.swift
//  pokedex
//
//  Created by Yung Kim on 7/15/16.
//  Copyright © 2016 Yung Kim. All rights reserved.
//

import Foundation

class Pokemon {
    var url: String
    var name: String
    init(dictionary: NSDictionary) {
        url = dictionary.valueForKey("url") as! String
        name = dictionary.valueForKey("name") as! String
    }
}