//
//  HeadlinesView.swift
//  NewsApp
//
//  Created by Oleksiy Chebotarov on 14/03/2025.
//

import SwiftUI

struct HeadlinesView: View {
    @EnvironmentObject private var headlinesStore: HeadlinesStore

    var body: some View {
        NavigationStack {
            Group {
                switch headlinesStore.loadingState {
                case .initial:
                    InitialView(retryAction: headlinesStore.fetchHeadlines)
                case .loading:
                    LoadingView(text: "Loading headlines...")
                case let .loaded(headlines):
                    List(headlines, id: \.id) { headline in
                        HeadlineRowView(headline: headline)
                    }
                case let .failed(error):
                    ErrorView(error: error, retryAction: headlinesStore.fetchHeadlines)
                }
            }
            .task {
                if case .initial = headlinesStore.loadingState {
                    await headlinesStore.fetchHeadlines()
                }
            }
            .navigationTitle("Headlines")
        }
    }
}

#Preview {
    HeadlinesView()
        .environmentObject(HeadlinesStore())
}
