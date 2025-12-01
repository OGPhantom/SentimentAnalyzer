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
        HStack{
            Text(response.text)

            Spacer()

            Image(systemName: response.sentiment.icon)
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(response.sentiment.sentimentColor)
                )
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))

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
