//
//  Sentiment.swift
//  SentimentAnalyzer
//
//  Created by Никита Сторчай on 28.11.2025.
//
import Charts
import SwiftUI

enum Sentiment: String, Plottable {
    case positive = "Positive"
    case negative = "Negative"
    case moderate = "Moderate"

    init(_ score: Double) {
        if score > 0.2 {
            self = .positive
        } else if score < -0.2 {
            self = .negative
        } else {
            self = .moderate
        }
    }

    var icon: String {
        switch self {
        case .positive:
            return "chevron.up.2"
        case .negative:
            return "chevron.down.2"
        case .moderate:
            return "minus"
        }
    }

    var sentimentColor: Color {
        switch self {
        case .positive:
            return .teal
        case .negative:
            return .red
        case .moderate:
            return .gray
        }
    }
}
