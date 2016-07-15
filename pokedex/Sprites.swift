//
//  Sprites.swift
//  pokedex
//
//  Created by Yung Kim on 7/15/16.
//  Copyright © 2016 Yung Kim. All rights reserved.
//

import Foundation

class Sprites {
        var front_default: String
        init(dictionary: NSDictionary) {
            front_default = dictionary.valueForKey("front_default") as! String
        }
}