//
//  MLHero.swift
//  Bannana Split Game
//
//  Created by Bryan Tineo Ccasani on 7/4/20.
//  Copyright © 2020 Bryan Tineo Ccasani. All rights reserved.
//

import Foundation
import SpriteKit

class MLHero: SKSpriteNode {
    
    
    var TextureAtlas = SKTextureAtlas()
    
    var TextureArray = [SKTexture]()
    
    
    var body = SKSpriteNode()
    var isUpsideDown = false
    
    
    
     override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let size = CGSize(width: 32, height: 44)
        
           super.init(texture: nil, color: UIColor.clear  ,size: size)
        
        loadAppearence()
        loadPhysicsBodyWithSize(size: size)
        
        }
    
    func loadAppearence(){
        TextureAtlas = SKTextureAtlas(named: "tony")
               
               for i in 1...TextureAtlas.textureNames.count{
                   
                   let Name = "tony_\(i).png"
                   TextureArray.append(SKTexture(imageNamed: Name))
             
               }
               
               
               body.position = CGPoint(x: 0,y: -2)
               body.size = CGSize(width: 1000, height: 1000)
               body.zPosition = 2

               self.addChild(body)
    }
    
    func loadPhysicsBodyWithSize(size: CGSize ){
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = Tony
        physicsBody?.contactTestBitMask = WALL | Score
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = true
        physicsBody?.collisionBitMask = WALL
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func flip() {
    
        isUpsideDown  = !isUpsideDown
              
              var scale: CGFloat!
              if isUpsideDown {
                  scale = -1.0
              } else {
                  scale = 1.0
          }
              let translate = SKAction.moveBy(x: 0, y: scale*(size.height +  KMLGroundHeight), duration: 0.1)
              let flip = SKAction.scaleY(to: scale, duration: 0.1)
              
              run(translate)
              run(flip)
    
    }
    
   
    
           

    


}
