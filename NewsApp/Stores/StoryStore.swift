//
//  StoryStore.swift
//  NewsApp
//
//  Created by Oleksiy Chebotarov on 17/03/2025.
//

import SwiftUI

@MainActor
class StoryStore: ObservableObject {
    private let apiClient: APIClientProtocol
    @Published var loadingState: LoadingState<StoryDetailsDto> = .initial

    init(apiClient: APIClientProtocol = APIClientBuilder().makeAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchStory(by storyID: StoryIdentifier) async {
        loadingState = .loading

        if let cachedStory = InMemoryCache.shared.getStory(id: storyID) {
            loadingState = .loaded(cachedStory)
            return
        }

        do {
            let fetchedStory = try await apiClient.getStory(id: storyID)
            InMemoryCache.shared.saveStory(fetchedStory)
            loadingState = .loaded(fetchedStory)
        } catch {
            loadingState = .failed(error)
        }
    }
}
