//
//  MLWall.swift
//  Bannana Split Game
//
//  Created by Bryan Tineo Ccasani on 7/5/20.
//  Copyright © 2020 Bryan Tineo Ccasani. All rights reserved.
//

import Foundation
import SpriteKit
class MLWall: SKSpriteNode{
    
    
    
    var WALL = SKSpriteNode()
    
   
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: nil, color: UIColor.clear  ,size: CGSize(width: 30, height: 50))
        WALL = SKSpriteNode(imageNamed: "hungry tamara")
        WALL.position = CGPoint(x: 0,y: 2)
        addChild(WALL)
        startMoving()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving() {
        let moveleft = SKAction.moveBy(x: -10, y: 0, duration: 1)
        run(SKAction.repeatForever(moveleft))
    }
}
