//
//  DeviceScene.swift
//  Neural Hacker
//
//  Created by João Pedro Picolo on 22/04/22.
//

import SpriteKit

class DeviceScene: SKScene, ObservableObject {
    @Published var deviceNode = SKSpriteNode(imageNamed: "device")
    
    private var background = SKSpriteNode(imageNamed: "background_device")
    
    override func didMove(to view: SKView) {
        background.zPosition = -1
        background.position = CGPoint(x: (frame.size.width / 2), y: (frame.size.height / 2))
        addChild(background)
        
        deviceNode.position = CGPoint(x: frame.midX + 100, y: frame.midY)
        addChild(deviceNode)
    }
}
