//
//  Response.swift
//  SentimentAnalyzer
//
//  Created by Никита Сторчай on 28.11.2025.
//

import Foundation

struct Response: Identifiable  {
    let id: String
    let text: String
    let score: Double

    static let sampleResponses: [String] = [
        "The future of AI makes me excited—let it handle repetitive tasks so developers can focus on creative problem-solving and product impact!",
        "I don't mind smarter tools, but relying on AI for core coding feels risky and could lead to fewer junior jobs.",
        "AI seems like a pretty good way to speed up code reviews and reduce boilerplate.",
        "I love everything about AI copilots: instant documentation, safer refactors, and auto-generated tests. When can we roll this out company-wide?",
        "There's a helpful AI completion in my editor that I like, but I don't need it writing entire features end-to-end.",
        "I enjoy tough engineering challenges. If AI takes the grunt work, we can spend more time on architecture, performance, and user value.",
        "Last time we tried an AI code generator we spent days fixing subtle bugs and chasing compliance issues. I'm not eager to trust it with critical code."
    ] 
}
