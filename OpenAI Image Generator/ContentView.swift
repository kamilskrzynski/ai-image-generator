//
//  ContentView.swift
//  OpenAI Image Generator
//
//  Created by Kamil Skrzyński on 15/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State var prompt: String = ""
    @State var generatedImage: UIImage?
    
    var body: some View {
        VStack {
            Spacer()
            if let generatedImage = generatedImage {
                Image(uiImage: generatedImage)
                    .resizable()
                    .frame(width: 250, height: 250)
            } else {
                Text("You need to provide prompt to generate an image")
            }
            Spacer()
            TextField("Type prompt here...", text: $prompt)
            Button("Generate") {
                Task {
                    generatedImage =  await viewModel.generateImage(from: prompt)
                }
            }
            .onAppear {
                viewModel.setup()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
