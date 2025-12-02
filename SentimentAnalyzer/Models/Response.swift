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

    var sentiment: Sentiment {
        Sentiment(score)
    }

    static let sampleResponses: [String] = [
        "I finally finished my app and it runs flawlessly!",
        "Working with SwiftUI has been a joy — everything feels so smooth.",
        "I got promoted today — all those late nights paid off!",
        "My teammates were incredibly supportive during the sprint.",
        "This coffee is exactly what I needed to power through the day.",
        "Just got back from a hike and I feel amazing!",
        "That bug I've been chasing for a week is finally gone!",
        "The feedback from the client was overwhelmingly positive.",
        "This bug is driving me insane — nothing seems to fix it.",
        "My laptop just crashed and I lost two hours of work.",
        "I missed a meeting because Calendar didn’t sync.",
        "The internet’s been down all morning and I can’t get anything done.",
        "I feel completely burned out after this sprint.",
        "I got rejected from the role I was really excited about.",
        "My app crashes randomly and I can't reproduce the issue.",
        "The UI still looks off no matter how much I tweak the layout.",
        "I have a few meetings today, then might get back to coding.",
        "The update went okay — a couple of warnings but nothing major.",
        "Planning to review PRs after lunch.",
        "Still need to figure out how to structure this feature.",
        "Reading up on Combine. Not sure I fully get it yet.",
        "I think the new framework could be useful, but it needs polish.",
        "The docs were fine, but I wish there were more examples.",
        "I'm not sure how I feel about the redesign yet."
    ]
}
