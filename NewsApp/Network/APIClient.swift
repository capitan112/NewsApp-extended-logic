//
//  APIClient.swift
//  NewsApp
//
//  Created by Oleksiy Chebotarov on 14/03/2025.
//

import Foundation

public typealias StoryIdentifier = Int

public struct HeadlineDto {
    public let id: StoryIdentifier
    public let title: String
    public let author: String
}

public struct StoryDetailsDto {
    public let id: StoryIdentifier
    public let title: String
    public let author: String
    public let content: String
    public let publicationDate: Date
    public var headline: HeadlineDto {
        HeadlineDto(id: id, title: title, author: author)
    }
}

public protocol APIClientProtocol {
    func getHeadlines() async throws -> [HeadlineDto]
    func getStory(id: StoryIdentifier) async throws -> StoryDetailsDto
}

public class APIClientBuilder {
    public init() {}

    func makeAPIClient(offline: Bool = false) -> APIClientProtocol {
        if offline {
            return OfflineAPI()
        } else {
            return SimulatedAPIClient(stories: exampleData)
        }
    }
}

public enum NetworkError: Error {
    case failed
    case offline
    case notFound
}

class SimulatedAPIClient: APIClientProtocol {
    private let stories: [StoryDetailsDto]

    init(stories: [StoryDetailsDto]) {
        self.stories = stories
    }

    func getHeadlines() async throws -> [HeadlineDto] {
        try await doUnreliability()
        return stories.map { $0.headline }
    }

    func getStory(id: StoryIdentifier) async throws -> StoryDetailsDto {
        try await doUnreliability()
        guard let story = stories.first(where: { $0.id == id }) else { throw NetworkError.notFound }
        return story
    }

    private func doUnreliability() async throws {
        let randomDelay = UInt64.random(in: 10_000_000 ..< 4_000_000_000)
        try? await Task.sleep(nanoseconds: randomDelay)
        guard Int.random(in: 0 ..< 5) > 0 else { throw NetworkError.failed }
    }
}

class OfflineAPI: APIClientProtocol {
    func getHeadlines() async throws -> [HeadlineDto] {
        throw NetworkError.offline
    }

    func getStory(id _: StoryIdentifier) async throws -> StoryDetailsDto {
        throw NetworkError.offline
    }
}
