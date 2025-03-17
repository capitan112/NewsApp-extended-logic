//
//  StoryView.swift
//  NewsApp
//
//  Created by Oleksiy Chebotarov on 14/03/2025.
//

import Foundation
import SwiftUI

struct StoryView: View {
    let storyID: StoryIdentifier
    @EnvironmentObject private var storyStore: StoryStore

    var body: some View {
        Group {
            switch storyStore.loadingState {
            case .initial:
                InitialView(retryAction: { await storyStore.fetchStory(by: storyID) })
            case .loading:
                LoadingView(text: "Loading Story...")
            case let .loaded(story):
                StoryContentView(story: story)
            case let .failed(error):
                ErrorView(error: error, retryAction: { await storyStore.fetchStory(by: storyID) })
            }
        }
        .task {
            await storyStore.fetchStory(by: storyID)
        }
        .navigationTitle("Story Details")
    }
}

#Preview {
    StoryView(storyID: 102)
        .environmentObject(StoryStore())
}
