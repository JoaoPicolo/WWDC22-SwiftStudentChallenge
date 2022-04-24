//
//  FinalView.swift
//  Neural Hacker
//
//  Created by João Pedro Picolo on 23/04/22.
//

import SwiftUI
import SpriteKit

struct FinalView: View {
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    @StateObject private var scene: IntroductionScene = {
        let lines: [SpeechLine] = [
            SpeechLine(text: "Nice, we were able to regain access to our system and retrieve our data.", duration: 3),
            SpeechLine(text: "Remember, now that you know how Deep Fakes work you must use this knlowdge only for the good", duration: 3),
            SpeechLine(text: "After all, with great power comes great responsibility! Thank you for your good work today.", duration: 3, isLast: true)
        ]
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let scene = IntroductionScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.lines = lines
        scene.characterNode = SKSpriteNode(imageNamed: "bouman-like")
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }()
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
        }
        .navigationBarHidden(true)
    }
}


