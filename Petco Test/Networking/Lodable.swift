//
//  Lodable.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import Foundation

protocol Lodable {
    @MainActor var loadingState: LoadingState { get }
}
