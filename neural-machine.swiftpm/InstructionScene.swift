//
//  InstructionScene.swift
//  Neural Learner
//
//  Created by João Pedro Picolo on 23/04/22.
//

import SpriteKit

class InstructionScene: SKScene, ObservableObject {
    var line: SpeechLine = SpeechLine(text: "", duration: 3)
    var speechBalloonNode = SKSpriteNode(imageNamed: "instruction-balloon")

    @Published var deviceNode = SKSpriteNode(imageNamed: "device")
    
    @Published var showBallon = true
    
    private var background = SKSpriteNode(imageNamed: "background_device")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        
        speechBalloonNode.position = CGPoint(x: frame.midX - 25, y: frame.midY + 320)
        speechBalloonNode.alpha = 0
        speechBalloonNode.run(SKAction.fadeIn(withDuration: 0.2))
        addChild(speechBalloonNode)
        
        setupAnimation()
    }
    
    private func setupAnimation() {
        var accumulatedTime = 1.0
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 30)]
        
        let text = NSAttributedString(string: line.text, attributes: attributes)
        let ballonText = SKLabelNode(text: line.text)
        ballonText.attributedText = text
        ballonText.numberOfLines = 0
        ballonText.alpha = 0
        ballonText.preferredMaxLayoutWidth = speechBalloonNode.frame.width - 100
        ballonText.position = CGPoint(x: 0, y: 0)
        
        let presentTextAction = SKAction.sequence([
            SKAction.wait(forDuration: accumulatedTime),
            SKAction.fadeIn(withDuration: 0.2),
            SKAction.wait(forDuration: line.duration),
        ])
        accumulatedTime += (1.0 + line.duration)
        
        ballonText.run(presentTextAction) {
            ballonText.run(SKAction.fadeOut(withDuration: 0.5)) {
                ballonText.removeFromParent()
                self.speechBalloonNode.run(SKAction.fadeOut(withDuration: 0.5))
                self.showBallon = false
            }
        }
        
        speechBalloonNode.addChild(ballonText)
    }
}

