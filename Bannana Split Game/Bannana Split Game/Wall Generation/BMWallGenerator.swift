//
//  BMWallGenerator.swift
//  Bannana Split Game
//
//  Created by Bryan Tineo Ccasani on 7/5/20.
//  Copyright © 2020 Bryan Tineo Ccasani. All rights reserved.
//

import Foundation
import SpriteKit

class MLWallGenerator: SKSpriteNode {
    
    var generationTimer: Timer?
    
    func startGeneratingWallsEvery(seconds: TimeInterval) {
        generationTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
    }
    func generateWall() {
        var scale: CGFloat
        let rand = arc4random_uniform(2)
        if rand == 0{
            scale = -1.0
        }else{
            scale = 1.0
        }
            
        let wall = MLWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (KMLGroundHeight/2 + wall.size.height/2)
        addChild(wall)
    }
    
}
