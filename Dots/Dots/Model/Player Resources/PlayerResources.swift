//
//  PlayerResources.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 28/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class PlayerResources {
    
    static var allResources: [[GameResource]] {
        return [defenseItems, attackItems]
    }
    
    static let defenseItems: [GameResource] = [
        GameResource(name: "test", images: [#imageLiteral(resourceName: "doodleBaloon-1"), #imageLiteral(resourceName: "doodleBaloon-2"), #imageLiteral(resourceName: "doodleBaloon-3"), #imageLiteral(resourceName: "doodleBaloon-4")], value: 200),
        GameResource(name: "test", images: [#imageLiteral(resourceName: "doodleBaloon-1"), #imageLiteral(resourceName: "doodleBaloon-2"), #imageLiteral(resourceName: "doodleBaloon-3"), #imageLiteral(resourceName: "doodleBaloon-4")], value: 200),
        GameResource(name: "test", images: [#imageLiteral(resourceName: "doodleBaloon-1"), #imageLiteral(resourceName: "doodleBaloon-2"), #imageLiteral(resourceName: "doodleBaloon-3"), #imageLiteral(resourceName: "doodleBaloon-4")], value: 200),
        GameResource(name: "test", images: [#imageLiteral(resourceName: "doodleBaloon-1"), #imageLiteral(resourceName: "doodleBaloon-2"), #imageLiteral(resourceName: "doodleBaloon-3"), #imageLiteral(resourceName: "doodleBaloon-4")], value: 200),
        GameResource(name: "test", images: [#imageLiteral(resourceName: "doodleBaloon-1"), #imageLiteral(resourceName: "doodleBaloon-2"), #imageLiteral(resourceName: "doodleBaloon-3"), #imageLiteral(resourceName: "doodleBaloon-4")], value: 200),
        GameResource(name: "test", images: [#imageLiteral(resourceName: "doodleBaloon-1"), #imageLiteral(resourceName: "doodleBaloon-2"), #imageLiteral(resourceName: "doodleBaloon-3"), #imageLiteral(resourceName: "doodleBaloon-4")], value: 200)
    ]
    static let attackItems: [GameResource] = [
        GameResource(name: "test", images: [#imageLiteral(resourceName: "doodleBaloon-1"), #imageLiteral(resourceName: "doodleBaloon-2"), #imageLiteral(resourceName: "doodleBaloon-3"), #imageLiteral(resourceName: "doodleBaloon-4")], value: 200)
    ]
    
}

class GameResource {
    var name: String
    var animationImages: [UIImage]
    var value: Int
    
    var priceTag: String {
        return "$ \(value)"
    }
    
    init(name: String, images: [UIImage], value: Int) {
        self.name = name
        self.animationImages = images
        self.value = value
    }
    
}
