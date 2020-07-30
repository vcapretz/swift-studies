//
//  UpdateStore.swift
//  DesingCode1
//
//  Created by Vitor Capretz on 2020-05-19.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}

