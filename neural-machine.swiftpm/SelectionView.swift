//
//  SelectionView.swift
//  Neural Hacker
//
//  Created by João Pedro Picolo on 19/04/22.
//

import SwiftUI
import SpriteKit

struct SelectionView: View {
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    @State private var images: [SelectionImage] = [
        SelectionImage(name: "jair-face", isGood: true),
        SelectionImage(name: "jair-face", isGood: true),
        SelectionImage(name: "jair-face", isGood: true),
        SelectionImage(name: "jair-face", isGood: true),
        SelectionImage(name: "jair-face", isGood: true),
        SelectionImage(name: "jair-face", isGood: true),
        SelectionImage(name: "jair-face", isGood: true),
        SelectionImage(name: "jair-face", isGood: true),
        SelectionImage(name: "jair-face", isGood: true),
    ]
    
    @StateObject private var scene: DeviceScene = {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let scene = DeviceScene()
    
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }()
    
    

    var body: some View {
        let imageWidth = scene.deviceNode.size.width
        let imageHeight = scene.deviceNode.size.height
        
        VStack {
            SpriteView(scene: scene)
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
        }
        .overlay {
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    Image("jair-face")
                        .overlay(RoundedRectangle(cornerRadius: 2)
                            .stroke(.black, lineWidth: 1))
                        .shadow(radius: 1)
                    
                    Text("This is Jair, remove the images were his face can't been seen clarly. This will help our machine learning model to build better videos for our Facial Identification.")
                        .padding(.top, 20)
                }
                .frame(
                    width: imageWidth - (imageWidth / 4) - 40,
                    height: 200,
                    alignment: .bottom
                )
                .padding(.top, 20)
//                .background(.red)
                
                VStack(alignment: .center, spacing: 40) {
                    ForEach(0..<3) { i in
                        HStack(alignment: .center, spacing: 60) {
                            ForEach(0..<3) { j in
                                VStack {
                                    if !images[(i * 3) + j].selected {
                                        Image(images[(i * 3) + j].name)
                                            .overlay(RoundedRectangle(cornerRadius: 2)
                                                .stroke(.black, lineWidth: 1))
                                            .shadow(radius: 1)
                                    } else {
                                        Image(images[(i * 3) + j].name)
                                            .overlay(RoundedRectangle(cornerRadius: 2)
                                                .stroke(.red, lineWidth: 1))
                                            .shadow(radius: 1)
                                    }
                                }
                                .scaleEffect(images[(i * 3) + j].tapped ? 0.95 : 1)
                                .animation(.spring(response: 0.4, dampingFraction: 0.6))
                                .onTapGesture {
                                    images[(i * 3) + j].tapped = true
                                    images[(i * 3) + j].selected = !images[(i * 3) + j].selected
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        images[(i * 3) + j].tapped = false
                                    }
                                    print("Tapped on image \((i * 3) + j)")
                                }
                            }
                        }
                    }
                }
                .frame(
                    width: imageWidth - (imageWidth / 4) - 20,
                    height: imageHeight - (imageHeight / 20) - 240,
                    alignment: .center
                )
//                .background(.green)

                Spacer()
            }
            .frame(
                width: imageWidth - (imageWidth / 4) - 20,
                height: imageHeight - (imageHeight / 20),
                alignment: .topLeading
            )
//            .background(.blue)
            
        }
        .navigationBarHidden(true)
    }
}

class DeviceScene: SKScene, ObservableObject {
    @Published var deviceNode = SKSpriteNode(imageNamed: "device")
    
    override func didMove(to view: SKView) {
        deviceNode.position = CGPoint(x: frame.midX + 100, y: frame.midY)
        addChild(deviceNode)
    }
}

struct SelectionImage {
    var name: String
    var isGood: Bool
    var tapped = false
    var selected = false
}

