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
            ZStack {
                LinearGradient(
                    colors: [
                        Color(.systemBlue).opacity(0.15),
                        Color(.systemTeal).opacity(0.10),
                        Color(.systemPurple).opacity(0.12)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {

                    ScrollView(showsIndicators: false) {

                        VStack(spacing: 24) {
                            ResponsePieChartView(responses: responses)

                            OverallSentimentSectionView(responses: responses)

                            VStack(spacing: 12) {
                                ForEach(responses) { response in
                                    ResponseRowView(response: response)
                                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 12)
                    }
                    
                    inputBar
                }
                .padding(.bottom, 8)
                .navigationTitle("Sentiment Analyzer")
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .task {
            loadSampleResponses()
        }
    }

    private var inputBar: some View {
        HStack(spacing: 12) {
            TextField("Write your thoughts...", text: $responseText, axis: .vertical)
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22))
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ).opacity(0.75), lineWidth: 1)
                )
                .focused($isFocused)

            Button {
                withAnimation(.spring()) { submit() }
            } label: {
                Text("Send")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(14)
                    .background(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                        )
                    )
                    .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
            }
        }
        .padding(.horizontal)
    }

    private func submit() {
        guard !responseText.isEmpty else { return }
        let score = scorer.score(responseText)
        let response = Response(id: UUID().uuidString, text: responseText, score: score)
        responses.insert(response, at: 0)
        responseText = ""
        isFocused = false
    }

    private func loadSampleResponses() {
        for text in Response.sampleResponses {
            let score = scorer.score(text)
            let response = Response(id: UUID().uuidString, text: text, score: score)
            responses.append(response)
        }
    }
}

#Preview {
    ContentView()
}
