//
//  IntroductionScene.swift
//  Neural Hacker
//
//  Created by João Pedro Picolo on 22/04/22.
//

import SpriteKit

class IntroductionScene: SKScene, ObservableObject {
    var lines: [SpeechLine] = []
    var characterNode: SKSpriteNode = SKSpriteNode(imageNamed: "bouman-wave")
    var speechBalloonNode = SKSpriteNode(imageNamed: "speech-balloon")
    
    @Published var showedLastMessage = false
    
    private var background = SKSpriteNode(imageNamed: "background")
    
    override func didMove(to view: SKView) {
        background.zPosition = -1
        background.position = CGPoint(x: (frame.size.width / 2), y: (frame.size.height / 2) + 25)
        addChild(background)
        
        characterNode.position = CGPoint(x: frame.midX - 30, y: frame.midY - 120)
        addChild(characterNode)
        
        speechBalloonNode.position = CGPoint(x: frame.midX - 25, y: frame.midY + 320)
        addChild(speechBalloonNode)
        
        setupAnimation()
    }
    
    
    private func setupAnimation() {
        var accumulatedTime = 1.0
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 30)]
        
        for line in lines {
            let text = NSAttributedString(string: line.text, attributes: attributes)
            let ballonText = SKLabelNode(text: line.text)
            ballonText.attributedText = text
            ballonText.numberOfLines = 0
            ballonText.alpha = 0
            ballonText.preferredMaxLayoutWidth = speechBalloonNode.frame.width - 50
            ballonText.position = CGPoint(x: 0, y: 0)
            
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

