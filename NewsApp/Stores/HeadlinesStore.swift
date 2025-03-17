//
//  HeadlinesStore.swift
//  NewsApp
//
//  Created by Oleksiy Chebotarov on 17/03/2025.
//

import SwiftUI

@MainActor
class HeadlinesStore: ObservableObject {
    private let apiClient: APIClientProtocol
    @Published var loadingState: LoadingState<[HeadlineDto]> = .initial

    init(apiClient: APIClientProtocol = APIClientBuilder().makeAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchHeadlines() async {
        loadingState = .loading

        do {
            let headlines = try await apiClient.getHeadlines()
            InMemoryCache.shared.saveHeadlines(headlines)
            loadingState = .loaded(headlines)
        } catch {
            loadingState = .failed(error)
        }
    }
}
