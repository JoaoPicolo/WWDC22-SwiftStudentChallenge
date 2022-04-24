//
//  NetworkView.swift
//  Neural Hacker
//
//  Created by João Pedro Picolo on 22/04/22.
//

import SwiftUI
import SpriteKit

struct NetworkView: View {
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    @State private var selectedNetwork = -1;
    
    @State private var images: [NetworkType] = [
        NetworkType(name: "network-1"),
        NetworkType(name: "network-2"),
        NetworkType(name: "network-3"),
        NetworkType(name: "network-4", isBest: true),
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
    
    @StateObject private var balloon: InstructionScene = {
        var line: SpeechLine = SpeechLine(text: "Finally we jsut need to select a machine learning architecture to train our model.", duration: 3)
    
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let scene = InstructionScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.line = line
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }()
    
    
    var body: some View {
        let imageWidth = scene.deviceNode.size.width
        let imageHeight = scene.deviceNode.size.height
        
        ZStack {
            SpriteView(scene: scene)
                .frame(width: screenWidth, height: screenHeight)
                .ignoresSafeArea()
            
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    Image("nick-multi")
                        .overlay(RoundedRectangle(cornerRadius: 2)
                            .stroke(.black, lineWidth: 0))
                        .shadow(radius: 1)
                    
                    Text("Select the network you want to use. Remember that the more neurons the network has, the better it learns to represent someone. A good network is able to learn new things, so find a balance between number of layers and generability.")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                }
                .frame(
                    width: imageWidth - (imageWidth / 4) - 40,
                    height: 200,
                    alignment: .bottom
                )
                .padding(.top, 20)
                
                VStack(alignment: .center, spacing: 20) {
                    ForEach(0..<2) { i in
                        HStack(alignment: .center, spacing: 40) {
                            ForEach(0..<2) { j in
                                VStack {
                                    if (selectedNetwork != (i * 2) + j) {
                                        Image(images[(i * 2) + j].name)
                                            .resizable()
                                            .overlay(RoundedRectangle(cornerRadius: 2)
                                                .stroke(.black, lineWidth: 1))
                                            .shadow(radius: 1)
                                    } else {
                                        Image(images[(i * 2) + j].name)
                                            .resizable()
                                            .overlay(RoundedRectangle(cornerRadius: 2)
                                                .stroke(.green, lineWidth: 2))
                                            .shadow(radius: 1)
                                    }
                                }
                                
                                .frame(width: 300, height: 280, alignment: .center)
                                .scaleEffect(images[(i * 2) + j].tapped ? 0.95 : 1)
                                .animation(.spring(response: 0.4, dampingFraction: 0.6))
                                .onTapGesture {
                                    selectedNetwork = (i * 2) + j
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        images[(i * 2) + j].tapped = false
                                    }
                                }
                            }
                        }
                    }
                    
                    NavigationLink(destination: FinalView()) {
                        VStack {
                            Text("Train")
                                .foregroundColor(.black) //Color(red: 51.0, green: 51.0, blue: 51.0)
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                        }
                        .frame(width: screenWidth / 8, height: 20, alignment: .bottom)
                        .padding()
                        .background(.yellow) //Color(red: 253, green: 207, blue: 60)
                        .cornerRadius(10)
                        .padding(.top, 10)
                    }
                }
                .frame(
                    width: imageWidth - (imageWidth / 4) - 20,
                    height: imageHeight - (imageHeight / 20) - 240,
                    alignment: .center
                )
                
                Spacer()
            }
            .frame(
                width: imageWidth - (imageWidth / 4) - 20,
                height: imageHeight - (imageHeight / 20),
                alignment: .topLeading
            )
            
            if balloon.showBallon {
                SpriteView(scene: balloon, options: [.allowsTransparency])
                    .frame(width: screenWidth, height: screenHeight)
                    .ignoresSafeArea()
            }
        }
        .navigationBarHidden(true)
    }
}

struct NetworkType {
    var name: String
    var tapped = false
    var isBest = false
}

