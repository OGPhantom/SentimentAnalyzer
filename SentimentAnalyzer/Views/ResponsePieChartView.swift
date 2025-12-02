//
//  ResponsePieChartView.swift
//  SentimentAnalyzer
//
//  Created by Никита Сторчай on 30.11.2025.
//
import Charts
import SwiftUI

struct ResponsePieChartView: View {
    let responses: [Response]

    private var sentimentCounts: [(sentiment: Sentiment, count: Int)] {
        let map = Dictionary(grouping: responses, by: \.sentiment)
            .mapValues { $0.count }

        return [
            (.positive, map[.positive, default: 0]),
            (.moderate, map[.moderate, default: 0]),
            (.negative, map[.negative, default: 0])
        ]
    }

    var body: some View {
        Chart(sentimentCounts, id: \.sentiment) { item in
            SectorMark(
                angle: .value("Count", item.count),
                innerRadius: .ratio(0.75)
            )
            .foregroundStyle(by: .value("Sentiment", item.sentiment.rawValue))
        }
        .chartLegend(position: .trailing, alignment: .center)
        .frame(height: 200)
        .padding()
        .chartForegroundStyleScale([
            Sentiment.positive.rawValue: Sentiment.positive.sentimentColor,
            Sentiment.moderate.rawValue: Sentiment.moderate.sentimentColor,
            Sentiment.negative.rawValue: Sentiment.negative.sentimentColor
        ])
        .chartBackground { proxy in
            GeometryReader { geometry in
                if let anchor = proxy.plotFrame {
                    let frame = geometry[anchor]
                    Image(systemName: "face.smiling")
                        .resizable()
                        .scaledToFit()
                        .frame(height: frame.height * 0.4)
                        .position(x: frame.midX, y: frame.midY)
                }
            }
        }
    }
}

#Preview {
    ResponsePieChartView(
        responses: [
            Response(
                id: UUID().uuidString,
                text: Response
                    .sampleResponses[0],
                score: 1.0
            ),
            Response(
                id: UUID().uuidString,
                text: Response
                    .sampleResponses[0],
                score: -1.0
            ),
            Response(
                id: UUID().uuidString,
                text: Response
                    .sampleResponses[0],
                score: 0.0
            )]
    )
}
