//
//  MasterViewModel.swift
//  InstagramSwiftUI
//
//  Created by Vitor Capretz on 2020-05-24.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import Foundation
import Combine

final class MasterViewModel: ObservableObject {
    @Published var hasUserSession: Bool
    private var cancellable: AnyCancellable?
    
    init(userSessionService: UserSessionService) {
        hasUserSession = userSessionService.session != nil
        cancellable = userSessionService.$session
            .map { $0 != nil }
            .removeDuplicates()
            .assign(to: \.hasUserSession, on: self)
    }
}
