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
        SelectionImage(name: "good-1", isGood: true),
        SelectionImage(name: "bad-1", isGood: false),
        SelectionImage(name: "bad-2", isGood: false),
        SelectionImage(name: "good-3", isGood: true),
        SelectionImage(name: "bad-3", isGood: false),
        SelectionImage(name: "bad-4", isGood: false),
        SelectionImage(name: "good-6", isGood: true),
        SelectionImage(name: "good-7", isGood: true),
        SelectionImage(name: "bad-5", isGood: false),
    ]
    
    @StateObject private var scene: DeviceScene = {
        var line: SpeechLine = SpeechLine(text: "The hacker leader is called Nick. First we need to remove images where it's hard to see Nick's face", duration: 3)
    
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let scene = DeviceScene()
        
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
                    Image("nick-face")
                        .overlay(RoundedRectangle(cornerRadius: 2)
                            .stroke(.black, lineWidth: 0))
                        .shadow(radius: 1)
                    
                    Text("This is Nick, remove the images were his face can't been seen clarly. This will help our machine learning model to build better videos for our Facial Identification.")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .regular, design: .rounded))
                }
                .frame(
                    width: imageWidth - (imageWidth / 4) - 40,
                    height: 200,
                    alignment: .bottom
                )
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                VStack(alignment: .center, spacing: 20) {
                    ForEach(0..<3) { i in
                        HStack(alignment: .center, spacing: 50) {
                            ForEach(0..<3) { j in
                                VStack {
                                    if !images[(i * 3) + j].selected {
                                        Image(images[(i * 3) + j].name)
                                            .resizable()
                                            .frame(width: 178, height: 182, alignment: .center)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 2)
                                                    .stroke(.black, lineWidth: 1)
                                            )
                                            .shadow(radius: 1)
                                    } else {
                                        Image(images[(i * 3) + j].name)
                                            .resizable()
                                            .frame(width: 178, height: 182, alignment: .center)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 2)
                                                    .stroke(.red, lineWidth: 1)
                                                    .background(Color(red: 196, green: 196, blue: 196))
                                                    .opacity(0.6)
                                            )
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
                                }
                            }
                        }
                    }
                    
                    NavigationLink(destination: AugmentationView()) {
                        VStack {
                            Text("NEXT")
                                .foregroundColor(.black) //Color(red: 51.0, green: 51.0, blue: 51.0)
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                        }
                        .frame(width: screenWidth / 8, height: 20, alignment: .bottom)
                        .padding()
                        .background(.yellow) //Color(red: 253, green: 207, blue: 60)
                        .cornerRadius(10)
                    }
                }
                .frame(
                    width: imageWidth - (imageWidth / 4) - 20,
                    height: imageHeight - (imageHeight / 20) - 240,
                    alignment: .center
                )
            }
            .frame(
                width: imageWidth - (imageWidth / 4) - 20,
                height: imageHeight - (imageHeight / 20),
                alignment: .topLeading
            )
        }
        .navigationBarHidden(true)
    }
}

struct SelectionImage {
    var name: String
    var isGood: Bool
    var tapped = false
    var selected = false
}

