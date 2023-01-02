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
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
             if isLoading {
                ProgressView()
                     .tint(.white)
                     .frame(maxWidth: .infinity, maxHeight: .infinity)
                     .background(Color("backgroundColor"))
             } else {
                 VStack {
                     Text("DALL-E IMAGE GENERATOR")
                         .foregroundColor(.white.opacity(0.8))
                         .font(.title2)
                         .bold()
                         .offset(y: 10)
                     Spacer()
                     if let generatedImage = generatedImage {
                         Image(uiImage: generatedImage)
                             .resizable()
                             .frame(width: 250, height: 250)
                     } else {
                         Image("placeholderImage")
                             .resizable()
                             .frame(width: 250, height: 250)
                             .opacity(0.5)
                     }
                     Spacer()
                         Text("ENTER YOUR PROMPT BELOW")
                             .foregroundColor(.white.opacity(0.6))
                             .font(.caption2.bold())
                         TextField("", text: $prompt)
                         .padding()
                         .font(.caption)
                         .foregroundColor(.white.opacity(0.5))
                             .background(Color("textFieldColor"))
                             .cornerRadius(5)
                     .padding(.horizontal)
                     
                     Button("Generate") {
                         Task {
                             isLoading = true
                             generatedImage = await viewModel.generateImage(from: prompt)
                             isLoading = false
                         }
                     }
                     .foregroundColor(.white)
                     .buttonStyle(.borderedProminent)
                     .tint(.primary)
                     .onAppear {
                         viewModel.setup()
                     }
                     .padding()
                 }
             }
        }
        .background(Color("backgroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
