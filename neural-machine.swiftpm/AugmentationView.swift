//
//  AugmentationView.swift
//  Neural Hacker
//
//  Created by João Pedro Picolo on 22/04/22.
//

import SwiftUI
import SpriteKit

struct AugmentationView: View {
    private let screenWidth = UIScreen.main.bounds.size.width
    private let screenHeight = UIScreen.main.bounds.size.height
    
    @State private var selectedOption = false
    
    @State private var options: [AugmentationType] = [
        AugmentationType(type: "Flipping", images: [
            AgumentationImage(name: "good-1"),
            AgumentationImage(name: "good-3"),
            AgumentationImage(name: "good-6"),
            AgumentationImage(name: "good-7"),
        ]),
        AugmentationType(type: "Rotation", images: [
            AgumentationImage(name: "good-1"),
            AgumentationImage(name: "good-3"),
            AgumentationImage(name: "good-6"),
            AgumentationImage(name: "good-7"),
        ]),
        AugmentationType(type: "Brightness", images: [
            AgumentationImage(name: "good-1"),
            AgumentationImage(name: "good-3"),
            AgumentationImage(name: "good-6"),
            AgumentationImage(name: "good-7"),
        ]),
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
        var line: SpeechLine = SpeechLine(text: "Now we have to do the augmentation process to generate more good images, and increase our dataset", duration: 4)
    
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
                    
                    Text("Select the augmentation methods in order to generate more images. You're gonna have a preview of a few of the new generated images.")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                }
                .frame(
                    width: imageWidth - (imageWidth / 4) - 40,
                    height: 200,
                    alignment: .bottom
                )
                .padding(.top, 20)
                
                VStack(alignment: .center, spacing: 10) {
                    VStack {
                        HStack(alignment: .center) {
                            Image(systemName: options[0].used ? "checkmark.square": "square")
                                .foregroundColor(.white)
                            
                            Text(options[0].type)
                                .foregroundColor(.white)
                        }
                        .frame(width: imageWidth - (imageWidth / 4), height: 30, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .onTapGesture {
                            options[0].used = !options[0].used
                            self.selectedOption = options[0].used && options[1].used  && options[2].used
                        }
                        
                        HStack(alignment: .center, spacing: 30) {
                            ForEach(0..<4) { j in
                                VStack {
                                    if (options[0].used) {
                                        Image(options[0].images[j].name)
                                            .resizable()
                                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                    }
                                    else {
                                        Image(options[0].images[j].name)
                                            .resizable()
                                    }
                                }
                                .frame(width: 150, height: 150, alignment: .center)
                                .overlay(RoundedRectangle(cornerRadius: 2)
                                    .stroke(.black, lineWidth: 1))
                                .shadow(radius: 1)
                            }
                        }
                    }
                    
                    VStack {
                        HStack(alignment: .center) {
                            Image(systemName: options[1].used ? "checkmark.square": "square")
                                .foregroundColor(.white)
                            
                            Text(options[1].type)
                                .foregroundColor(.white)
                        }
                        .frame(width: imageWidth - (imageWidth / 4), height: 30, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .onTapGesture {
                            options[1].used = !options[1].used
                            self.selectedOption = options[0].used && options[1].used  && options[2].used
                        }
                        
                        HStack(alignment: .center, spacing: 30) {
                            ForEach(0..<4) { j in
                                VStack {
                                    if (options[1].used) {
                                        Image(options[1].images[j].name)
                                            .resizable()
                                            .rotation3DEffect(.degrees([0.0, 90.0, -90.0].randomElement()!), axis: (x: 0, y: 0, z: 1))
                                            .rotation3DEffect(.degrees([0.0, 180.0].randomElement()!), axis: (x: 1, y: 0, z: 0))
                                            .scaledToFit()
                                    }
                                    else {
                                        Image(options[1].images[j].name)
                                            .resizable()
                                    }
                                }
                                .frame(width: 150, height: 150, alignment: .center)
                                .overlay(RoundedRectangle(cornerRadius: 2)
                                    .stroke(.black, lineWidth: 1))
                                .shadow(radius: 1)
                            }
                        }
                    }
                    
                    VStack {
                        HStack(alignment: .center) {
                            Image(systemName: options[2].used ? "checkmark.square": "square")
                                .foregroundColor(.white)
                            
                            Text(options[2].type)
                                .foregroundColor(.white)
                        }
                        .frame(width: imageWidth - (imageWidth / 4), height: 30, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .onTapGesture {
                            options[2].used = !options[2].used
                            self.selectedOption = options[0].used && options[1].used  && options[2].used
                        }
                        
                        HStack(alignment: .center, spacing: 30) {
                            ForEach(0..<4) { j in
                                VStack {
                                    if (options[2].used) {
                                        Image(options[2].images[j].name)
                                            .resizable()
                                            .brightness(Double.random(in: -0.3...0.3))
                                    }
                                    else {
                                        Image(options[2].images[j].name)
                                            .resizable()
                                    }
                                }
                                .frame(width: 150, height: 150, alignment: .center)
                                .overlay(RoundedRectangle(cornerRadius: 2)
                                    .stroke(.black, lineWidth: 1))
                                .shadow(radius: 1)
                            }
                        }
                    }
                    
                    NavigationLink(destination: NetworkView()) {
                        VStack {
                            Text("NEXT")
                                .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                        }
                        .frame(width: screenWidth / 8, height: 20, alignment: .bottom)
                        .padding()
                        .padding(.top, 10)
                        .background(
                            selectedOption ? Color(red: 253 / 255, green: 207 / 255, blue: 60 / 255) : Color(red: 196 / 255, green: 196 / 255, blue: 196 / 255)
                        )
                        .cornerRadius(10)
                        .padding(.top, 10)
                    }
                    .disabled(!selectedOption)
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

struct AgumentationImage {
    var name: String
}

struct AugmentationType {
    var type: String
    var images: [AgumentationImage]
    var used = false
}


