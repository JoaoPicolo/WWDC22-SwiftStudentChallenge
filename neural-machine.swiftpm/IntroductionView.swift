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
    
    @StateObject private var scene: IntroductionScene = {
        let lines: [SpeechLine] = [
            SpeechLine(text: "Hi there. I’m Doctor Bouman, I'm the responsible for helping you build our Machine Learning Model", duration: 3),
            SpeechLine(text: "You probably saw in the news that a hacker group took over one of our research centers", duration: 3),
            SpeechLine(text: "This center has important data about the cure of viruses that can attack large groups of people", duration: 3),
            SpeechLine(text: "Their leader is using facial Recognition in order to control the machines, and stop us from acessing our backups", duration: 4),
            SpeechLine(text: "Can you help me build a Deep Fake in order to regain access to our system?", duration: 3, isLast: true)
        ]
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let scene = IntroductionScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.lines = lines
        scene.characterNode = SKSpriteNode(imageNamed: "bouman-wave")
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }()
    
    var body: some View {
        NavigationView {
            ZStack {
                SpriteView(scene: scene)
                    .frame(width: screenWidth, height: screenHeight)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    if scene.showedLastMessage {
                        NavigationLink(destination: SelectionView()) {
                            VStack {
                                Text("BUILD")
                                    .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                                    .font(.system(size: 25, weight: .bold, design: .rounded))
                            }
                            .frame(width: screenWidth / 8, height: 20, alignment: .bottom)
                            .padding()
                            .padding(.top, 10)
                            .background(Color(red: 253 / 255, green: 207 / 255, blue: 60 / 255))
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                            .padding(.leading, screenWidth - (screenWidth / 4))
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .ignoresSafeArea()
    }
}

