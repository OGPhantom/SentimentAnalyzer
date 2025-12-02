 //
//  ContentView.swift
//  SentimentAnalyzer
//
//  Created by Никита Сторчай on 28.11.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var responseText = ""
    @State private var responses = [Response]()
    @State private var scorer = Scorer()
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationStack {
            VStack{
                ScrollView {
                    ResponsePieChartView(responses: responses)
                    OverallSentimentSectionView(responses: responses)

                    ForEach(responses) { response in
                        ResponseRowView(response: response)
                            .padding(.horizontal)
                    }
                }

                HStack {
                    TextField(
                        "Type something in...",
                        text: $responseText,
                        axis: .vertical
                    )
                    .padding(12)
                    .padding(.leading, 4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(.systemGray),lineWidth: 1.0)
                    }
                    .focused($isFocused)

                    Button(
                        "Analyze"
                    ) {
                        withAnimation{
                            onDoneTapper()
                        }
                    }
                    .fontWeight(.semibold)


                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Sentiment Analyzer").navigationBarTitleDisplayMode(.inline)
        }
        .task {
            for response in Response.sampleResponses {
                saveResponse(response)
            }
        }
    }
}

private extension ContentView {
    func saveResponse(_ text: String, shouldInsert: Bool = false) {
        let score = scorer.score(text)
        let response = Response(id: UUID().uuidString, text: text, score: score)
        print("🧪 Text: \(text) → Score: \(score)")
        if shouldInsert {
            responses.insert(response, at: 0)
        } else {
            responses.append(response)
        }
    }

    func onDoneTapper() {
        guard !responseText.isEmpty else { return }
        saveResponse(responseText, shouldInsert: true)
        responseText = ""
        isFocused = false
    }
}

#Preview {
    ContentView()
}
