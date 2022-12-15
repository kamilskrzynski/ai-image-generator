//
//  ViewModel.swift
//  OpenAI Image Generator
//
//  Created by Kamil Skrzyński on 15/12/2022.
//

import SwiftUI
import OpenAIKit

final class ViewModel: ObservableObject {
    
    private var openAI: OpenAI?
    let apiKey = "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"
    
    func setup() {
        openAI = OpenAI(
            Configuration(
                organization: "Personal",
                apiKey: apiKey
            )
        )
    }
    
    func generateImage(from prompt: String) async -> UIImage? {
        guard let openAI = openAI else {
            return nil
        }
        
        let imageParameters = ImageParameters(
            prompt: prompt,
            resolution: .medium,
            responseFormat: .base64Json
        )
    
        do {
            let result = try await openAI.createImage(parameters: imageParameters)
            let imageData = result.data[0].image
            let image = try openAI.decodeBase64Image(imageData)
            return image
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
