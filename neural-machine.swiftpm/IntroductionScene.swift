//
//  IntroductionScene.swift
//  Neural Hacker
//
//  Created by João Pedro Picolo on 22/04/22.
//

import SpriteKit

class IntroductionScene: SKScene, ObservableObject {
    var lines: [SpeechLine] = []
    var characterNode: SKSpriteNode = SKSpriteNode(imageNamed: "bouman")
    var speechBalloonNode = SKSpriteNode(imageNamed: "speech-balloon")
    
    @Published var showedLastMessage = false
    
    override func didMove(to view: SKView) {
        characterNode.position = CGPoint(x: frame.midX - 30, y: frame.midY - 120)
        addChild(characterNode)
        
        speechBalloonNode.position = CGPoint(x: frame.midX - 50, y: frame.midY + 340)
        addChild(speechBalloonNode)
        
        setupAnimation()
    }
    
    
    private func setupAnimation() {
        var accumulatedTime = 0.0
        
        for line in lines {
            let ballonText = SKLabelNode(text: line.text)
            ballonText.fontColor = .black
            ballonText.fontSize = 25
            ballonText.numberOfLines = 0
            ballonText.alpha = 0
            ballonText.preferredMaxLayoutWidth = speechBalloonNode.frame.width - 30
            ballonText.position = CGPoint(x: 0, y: 10)
            
            let presentTextAction = SKAction.sequence([
                SKAction.wait(forDuration: accumulatedTime),
                SKAction.fadeIn(withDuration: 0.5),
                SKAction.wait(forDuration: line.duration),
            ])
            accumulatedTime += (1.0 + line.duration)
            
            ballonText.run(presentTextAction) {
                if !line.isLast {
                    ballonText.run(SKAction.fadeOut(withDuration: 0.5)) {
                        ballonText.removeFromParent()
                    }
                } else {
                    self.showedLastMessage = true
                }
            }
            speechBalloonNode.addChild(ballonText)
        }
    }
}

struct SpeechLine {
    var text: String
    var duration: Double
    var isLast: Bool = false
}

