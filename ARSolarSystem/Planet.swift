//
//  Planet.swift
//  ARSolarSystem
//
//  Created by Dilip Gurjar on 14/02/19.
//  Copyright © 2019 Dilip Gurjar. All rights reserved.
//

import UIKit

class planet {
    
    let name: String
    let color: UIColor
    let sunDistance: Float
    let radius: CGFloat
    let rotation: CGFloat
    
    init(name: String, color: UIColor, sunDistance: Float, radius: CGFloat, rotation: CGFloat) {
        self.name = name
        self.color = color
        self.sunDistance = sunDistance
        self.radius = radius
        self.rotation = rotation
    }
    
}
