//
//  BMMovingGround.swift
//  Bannana Split Game
//
//  Created by Bryan Tineo Ccasani on 7/4/20.
//  Copyright © 2020 Bryan Tineo Ccasani. All rights reserved.
//

import Foundation
import SpriteKit

class BMMovingGround: SKSpriteNode {
    
    let NUMBER_OF_Segments = 20
    let COLOR_ONE = UIColor.systemPink
    let COLOR_TWO = UIColor.purple
    
    init(size: CGSize) {
        super.init(texture: nil , color: UIColor.systemPink , size:CGSize(width: size.width*25, height: size.height*3))
        anchorPoint = CGPoint(x: 0, y: 0.5)
        
        for i in 0...NUMBER_OF_Segments {
            var segmentColor: UIColor!
            if i % 2 == 0 {
                segmentColor = COLOR_ONE
            } else {
                segmentColor = COLOR_TWO
            }
            
            let segment = SKSpriteNode(color: segmentColor, size: CGSize(width: self.size.width / CGFloat(NUMBER_OF_Segments), height: self.size.height))
            segment.anchorPoint = CGPoint(x: 0.0,y: 0.5)
            segment.position = CGPoint(x: CGFloat(i)*segment.size.width - 275, y: 0)
            self.addChild(segment)
            
    }
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    
    func start() {
        let moveleft = SKAction.moveBy(x: -frame.size.width/2, y: 0, duration: 14)
        let resetPosition = SKAction.moveTo(x: -85, duration: 0)
        
        let moveSequence = SKAction.sequence([moveleft, resetPosition])
        
        run(SKAction.repeatForever(moveSequence))
    }
}
