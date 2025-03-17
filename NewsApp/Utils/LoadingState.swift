//
//  LoadingState.swift
//  NewsApp
//
//  Created by Oleksiy Chebotarov on 17/03/2025.
//

import SwiftUI

enum LoadingState<T> {
    case initial
    case loading
    case loaded(T)
    case failed(Error)
}
