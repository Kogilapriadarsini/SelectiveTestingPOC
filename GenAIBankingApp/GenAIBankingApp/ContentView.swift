//
//  ContentView.swift
//  GenAIBankingApp
//
//  Created by Kogilapriadarsini Nathan on 23/06/25.
//

import SwiftUI
import FoundationModels
internal import Combine

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            //DynamicBankingUI()
            Text(viewModel.text)
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


class ContentViewModel: ObservableObject {
    @Published var text = ""
    let session = LanguageModelSession()

    init() {
        self.text = text
        Task {
            do {
                try await generateSummary()
            } catch {
                print("Failed to generate summary: \(error)")
            }
        }
    }
    func generateSummary() async throws {
        let prompt = Prompt("Tell me a knock knock joke.")
        let response = try await session.respond(to: prompt)
        text = response.content
    }
}
