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
            .mapValues(\.count)

        return [
            (.positive, map[.positive, default: 0]),
            (.moderate, map[.moderate, default: 0]),
            (.negative, map[.negative, default: 0])
        ]
    }

    private var dominantSentiment: Sentiment? {
        let positive = sentimentCounts[0].count
        let moderate = sentimentCounts[1].count
        let negative = sentimentCounts[2].count

        let maxValue = max(positive, moderate, negative)

        switch maxValue {
        case positive: return .positive
        case moderate: return .moderate
        case negative: return .negative
        default: return nil
        }
    }

    private func percentage(for sentiment: Sentiment) -> Int {
        let total = responses.count
        guard total > 0 else { return 0 }

        let count = sentimentCounts.first(where: { $0.sentiment == sentiment })?.count ?? 0
        return Int((Double(count) / Double(total)) * 100)
    }


    var body: some View {
        VStack(spacing: 16) {

            Chart(sentimentCounts, id: \.sentiment) { item in
                SectorMark(
                    angle: .value("Count", item.count),
                    innerRadius: .ratio(0.70),
                    angularInset: 2.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Sentiment", item.sentiment.rawValue))
            }
            .chartBackground { proxy in
                GeometryReader { geometry in
                    if let anchor = proxy.plotFrame {
                        let frame = geometry[anchor]
                        if let dominant = dominantSentiment {
                            Text("\(percentage(for: dominant))%")
                                .font(.system(size: 52, weight: .bold))
                                .foregroundStyle(dominant.sentimentColor)
                                .position(x: frame.midX, y: frame.midY)
                        }

                    }
                }
            }
            .frame(height: 230)
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 28))
            .chartForegroundStyleScale([
                Sentiment.positive.rawValue: Sentiment.positive.sentimentColor,
                Sentiment.moderate.rawValue: Sentiment.moderate.sentimentColor,
                Sentiment.negative.rawValue: Sentiment.negative.sentimentColor
            ])
            .chartLegend(position: .trailing, alignment: .center)
        }
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 24, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(Color.white.opacity(0.08), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
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
