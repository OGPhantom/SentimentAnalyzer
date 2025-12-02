//
//  ResponseRowView.swift
//  SentimentAnalyzer
//
//  Created by Никита Сторчай on 29.11.2025.
//

import SwiftUI

struct ResponseRowView: View {
    let response: Response

    var body: some View {
        HStack(alignment: .center, spacing: 12) {

            Image(systemName: response.sentiment.icon)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding(10)
                .background(response.sentiment.sentimentColor, in: RoundedRectangle(cornerRadius: 14))

            Text(response.text)
                .font(.body)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(LinearGradient(
                    colors: [response.sentiment.sentimentColor, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).opacity(0.75), lineWidth: 1)
        )
    }
}

#Preview {
    ResponseRowView(
        response: Response(
            id: UUID().uuidString,
            text: Response.sampleResponses[0],
            score: 1.0
        )
    )
}
