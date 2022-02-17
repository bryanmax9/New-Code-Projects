//
//  GameScene.swift
//  Bannana Split Game
//
//  Created by Bryan Tineo Ccasani on 7/4/20.
//  Copyright © 2020 Bryan Tineo Ccasani. All rights reserved.
//
import SpriteKit
import GameplayKit


struct PhysicsCategory{
    static let WALL : UInt32 = 0x1 << 1
    static let Tony : UInt32 = 0x1 << 0
    static let Score : UInt32 = 0x1 << 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var movingGround: BMMovingGround!
    
    var hero: MLHero!
    
    var isStarted = Bool()
    
    var TextureAtlas = SKTextureAtlas()
    
    var TextureArray = [SKTexture]()
    
    var WALLPAIR = SKNode()

    var  moveAndRemove = SKAction()
    
    var died = Bool()
 
    var  restartBTN = SKSpriteNode()
    
    var score = Int()
    
    let scoreLbl = SKLabelNode()
   
    func restartScene(){
        
        self.removeAllChildren()
        self.removeAllActions()
        died = false
        isStarted = false
        score = 0
        createScene()
    }
    
    func createScene(){
        
        
        self.physicsWorld.contactDelegate = self
        
        for i in 0..<2 {
            let background = SKSpriteNode(imageNamed: "ice cream shop")
            
            background.size = self.size
            background.position = CGPoint(x: CGFloat(i) + 30 ,y: 0)
            background.zPosition = 0
            background.setScale(1.5)
            background.name = "background"
            self.addChild(background)
        }
               
        scoreLbl.position = CGPoint(x: -50, y: 115)
        scoreLbl.zPosition = 5
        scoreLbl.text = "\(score)"
        scoreLbl.fontName = "04b_19"
        scoreLbl.fontSize = 60
        scoreLbl.fontColor = SKColor.red
        self.addChild(scoreLbl)
        
               
               
               
        movingGround = BMMovingGround(size: CGSize(width: (view?.frame.width)!, height: KMLGroundHeight))
               movingGround.position = CGPoint(x: -550, y: -37)
               movingGround.zPosition = 1
               addChild(movingGround)
               
               hero = MLHero()
               
               hero.size = CGSize(width: 130, height: 130)
               hero.position = CGPoint(x: -100, y: 50)
               hero.zPosition = 2
               hero.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 32, height: 44))
               hero.physicsBody?.categoryBitMask = Tony
               hero.physicsBody?.contactTestBitMask = WALL | Score
               hero.physicsBody?.affectedByGravity = false
               hero.physicsBody?.isDynamic = true
        hero.physicsBody?.collisionBitMask = WALL
               self.addChild(hero)
               
               TextureAtlas = SKTextureAtlas(named: "tony")
               
               for i in 1...TextureAtlas.textureNames.count{
                   
                   var Name = "tony_\(i).png"
                   TextureArray.append(SKTexture(imageNamed: Name))
               
                   physicsWorld.contactDelegate = self
                
                    
               }
        
        let tapToStartLabel = SKLabelNode(text: "Double Tap to start!")
        tapToStartLabel.position = CGPoint(x: -50, y: 25)
        tapToStartLabel.fontColor = UIColor.black
        tapToStartLabel.fontName = "04b_19"
        tapToStartLabel.zPosition = 3
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.fontSize = 40
        addChild(tapToStartLabel)
        
    }
    
    override func didMove(to view: SKView) {
        
        createScene()
        
        
    }
   
    func start() {
        isStarted = true
        
        let tapToStartLabel = childNode(withName: "tapToStartLabel")
        tapToStartLabel?.removeFromParent()
        movingGround.start()
        let spawn = SKAction.run({
                       () in
                                            
                                            self.createWalls()
                   })
                          
        let delay = SKAction.wait(forDuration: 1.4)
                          let SpawnDelay = SKAction.sequence([spawn, delay])
                          let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
                          self.run(spawnDelayForever)
                   
                   
                   
                   let distance =  CGFloat(self.frame.height + WALLPAIR.frame.width)
        let movePipes = SKAction.moveBy(x: -distance ,y: 0, duration: TimeInterval( 0.003*distance ))
                   
                          let removePipes = SKAction.removeFromParent()
                          moveAndRemove = SKAction.sequence([movePipes, removePipes])
    }
    
    func CreateBTN(){
        
        restartBTN = SKSpriteNode(imageNamed: "Restart")
        restartBTN.size = CGSize(width: 200, height: 100)
        restartBTN.position = CGPoint(x: -50, y: 50)
        restartBTN.zPosition = 6
        restartBTN.setScale(0)
        self.addChild(restartBTN)
        
        restartBTN.run(SKAction.scale(to: 1.0, duration: 0.3))
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == PhysicsCategory.Score && secondBody.categoryBitMask == PhysicsCategory.Tony || firstBody.categoryBitMask == PhysicsCategory.Tony && secondBody.categoryBitMask == PhysicsCategory.Score{
            
            score += 1
            scoreLbl.text = "\(score)"
            
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.Tony && secondBody.categoryBitMask == PhysicsCategory.WALL || firstBody.categoryBitMask == PhysicsCategory.WALL && secondBody.categoryBitMask == PhysicsCategory.Tony{
            
            
            
            enumerateChildNodes(withName: "wallpair", using: ({
               (node, error) in
                
                node.speed = 0
                self.removeAllActions()
            }))
            if died == false{
                died = true
                CreateBTN()
                
            }
        }
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if isStarted == false {
            
            start()
            

            
        }else{
            if died == true{
                
            }else{
            
            hero.flip()
                hero.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.1)))
            }
        }
        
        
        for touch in touches{
            let location = touch.location(in: self)
            
            if died == true{
                if restartBTN.contains(location){
                    restartScene()
                }
                
                
            }
        }
        
        
        }
   
   
    
    func createWalls(){

        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 1, height: 100)
        scoreNode.position = CGPoint(x: 450, y: -100)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCategory.Score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCategory.Tony
        scoreNode.color = SKColor.clear
        
    
        
        WALLPAIR = SKNode()
        WALLPAIR.name = "wallpair"
        
        let TOPWALL = SKSpriteNode(imageNamed: "hungry tamara")
        let BTMWALL = SKSpriteNode(imageNamed: "hungry tamara")
        
        
        TOPWALL.position = CGPoint(x: 450,y: 40)
        BTMWALL.position = CGPoint(x: 650, y: -100)
        
        TOPWALL.zPosition = 2
        BTMWALL.zPosition = 2
        
        TOPWALL.setScale(1)
        BTMWALL.setScale(1)
        
        BTMWALL.zRotation = CGFloat(M_PI)
        
        TOPWALL.physicsBody = SKPhysicsBody(rectangleOf: TOPWALL.size)
        TOPWALL.physicsBody?.categoryBitMask = PhysicsCategory.WALL
        TOPWALL.physicsBody?.collisionBitMask = PhysicsCategory.Tony
        TOPWALL.physicsBody?.contactTestBitMask = PhysicsCategory.Tony
        TOPWALL.physicsBody?.isDynamic = false
        TOPWALL.physicsBody?.affectedByGravity = false
        
        BTMWALL.physicsBody = SKPhysicsBody(rectangleOf: BTMWALL.size)
        BTMWALL.physicsBody?.categoryBitMask = PhysicsCategory.WALL
        BTMWALL.physicsBody?.collisionBitMask = PhysicsCategory.Tony
        BTMWALL.physicsBody?.contactTestBitMask = PhysicsCategory.Tony
        BTMWALL.physicsBody?.isDynamic = false
        BTMWALL.physicsBody?.affectedByGravity = false
        
        
        
        WALLPAIR.addChild(TOPWALL)
        WALLPAIR.addChild(BTMWALL)
        WALLPAIR.addChild(scoreNode)
        
        WALLPAIR.run(moveAndRemove)
        self.addChild(WALLPAIR)
        
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
        if isStarted == true{
            if died == false{
                enumerateChildNodes(withName: "background", using: ({
                   (node, error) in
                    
                    var bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 0.05, y: bg.position.y)
                    if bg.position.x <= -bg.size.width {
                        bg.position = CGPoint(x: bg.position.x + bg.size.width*2, y: bg.position.y)
                        
                    }
                }))
            }
        }
    }
    
}






