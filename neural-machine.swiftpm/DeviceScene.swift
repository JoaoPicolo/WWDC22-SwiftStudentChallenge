//
//  DeviceScene.swift
//  Neural Hacker
//
//  Created by João Pedro Picolo on 22/04/22.
//

import SpriteKit

class DeviceScene: SKScene, ObservableObject {
    @Published var deviceNode = SKSpriteNode(imageNamed: "device")
    
    override func didMove(to view: SKView) {
        deviceNode.position = CGPoint(x: frame.midX + 100, y: frame.midY)
        addChild(deviceNode)
    }
}
