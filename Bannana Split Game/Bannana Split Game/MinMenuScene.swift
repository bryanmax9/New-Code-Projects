//
//  MinMenuScene.swift
//  Bannana Split Game
//
//  Created by Bryan Tineo Ccasani on 7/8/20.
//  Copyright © 2020 Bryan Tineo Ccasani. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: SKScene{
    
    override func didMove(to view: SKView) {
        
        
        let background = SKSpriteNode(imageNamed: "ice cream shop")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameBy = SKLabelNode(fontNamed: "04B_19__")
        gameBy.text = "Bryanmax9 and Tony"
        gameBy.fontSize = 50
        gameBy.fontColor = SKColor.black
        gameBy.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.78)
        gameBy.zPosition = 1
        self.addChild(gameBy)
        
        let gameName1 = SKLabelNode(fontNamed: "04B_19__")
        gameName1.text = "Banana Split"
        gameName1.fontSize = 200
        gameName1.fontColor = SKColor.black
        gameName1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameName1.zPosition = 1
        self.addChild(gameName1)
        
        let gameName2 = SKLabelNode(fontNamed: "04B_19__")
        gameName2.text = "Game"
        gameName2.fontSize = 200
        gameName2.fontColor = SKColor.black
        gameName2.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.625)
        gameName2.zPosition = 1
        self.addChild(gameName2)
        
        let startGame = SKLabelNode(fontNamed: "04B_19__")
        startGame.text = "Start Game"
        startGame.fontSize = 150
        startGame.fontColor = SKColor.black
        startGame.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
        startGame.zPosition = 1
        self.addChild(startGame)
        
       
        
        
        
        
        
        
        
        
        
    }
}
