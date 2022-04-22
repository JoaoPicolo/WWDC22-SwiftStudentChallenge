//
//  File.swift
//  Neural Machine
//
//  Created by João Pedro Picolo on 17/04/22.
//

import SwiftUI
import SpriteKit

struct IntroductionView: View {
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    @StateObject private var scene: IntrductionScene = {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let scene = IntrductionScene()
    
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }()
    
    var body: some View {
        NavigationView {
            VStack {
                SpriteView(scene: scene)
                    .frame(width: screenWidth, height: screenHeight)
                    .ignoresSafeArea()
            }
            .overlay {
                VStack {
                    Spacer()
//                    if scene.showedLastMessage {
                        NavigationLink(destination: SelectionView()) {
                            VStack {
                                Text("Build")
                            }
                            .frame(width: screenWidth / 8, height: 20, alignment: .bottom)
                            .foregroundColor(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                            .padding(.leading, screenWidth - (screenWidth / 4))
                        }
//                    }
                }
                
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .ignoresSafeArea()
    }
}


class IntrductionScene: SKScene, ObservableObject {
    private var lines: [SpeechLine] = [
        SpeechLine(text: "Hi there. I’m Doctor Bouman, I'm the responsible for helping you build our Machine Learning Model", duration: 3),
        SpeechLine(text: "You probably saw in the news that a hacker group took over one of our research centers", duration: 3),
        SpeechLine(text: "This center has important data about the cure of viruses that can attack large groups of people", duration: 3),
        SpeechLine(text: "Their leader, Jair, is using facial Recognition in order to control the machines, and stop us from acessing our backups", duration: 3),
        SpeechLine(text: "Can you help me build a Deep Fake in order to regain access to our system?", duration: 3, isLast: true)
    ]
    
    var characterNode = SKSpriteNode(imageNamed: "bouman-wave")
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
