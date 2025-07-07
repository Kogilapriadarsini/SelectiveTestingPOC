//
//  TextSummarizationUtility.swift
//  GenAIBankingApp
//
//  Created by Kogilapriadarsini Nathan on 03/07/25.
//

import Foundation
import FoundationModels
import Playgrounds

//@available(iOS 18.0, macOS 15.0, *)
//class FoundationTextSummarizer {
//    private let maxWordsPerChunk = 300
//    private let systemModel: SystemLanguageModel
//   
//    init() throws {
//        self.systemModel = SystemLanguageModel.default
//    }
//
//    func summarize(text: String) async throws -> String {
//        let chunks = chunkText(text)
//        var allSummaries: [String] = []
//
//        for chunk in chunks {
//            let summary = try await summarizeChunk(chunk)
//            allSummaries.append(summary)
//        }
//
//        return allSummaries.joined(separator: "\n\n")
//    }
//
//    private func summarizeChunk(_ chunk: String) async throws -> String {
//        let prompt = "Summarize the following:\n\(chunk)"
//        return try await session.generate(prompt: prompt)
//    }
//
//    private func chunkText(_ text: String) -> [String] {
//        var chunks: [String] = []
//        var currentChunk = ""
//        var currentCount = 0
//
//        let lines = text.components(separatedBy: .newlines)
//
//        for line in lines {
//            let wordsInLine = line.split(separator: " ").count
//
//            if currentCount + wordsInLine > maxWordsPerChunk {
//                chunks.append(currentChunk.trimmingCharacters(in: .whitespacesAndNewlines))
//                currentChunk = ""
//                currentCount = 0
//            }
//
//            currentChunk += line + "\n"
//            currentCount += wordsInLine
//        }
//
//        if !currentChunk.isEmpty {
//            chunks.append(currentChunk.trimmingCharacters(in: .whitespacesAndNewlines))
//        }
//
//        return chunks
//    }
//}

