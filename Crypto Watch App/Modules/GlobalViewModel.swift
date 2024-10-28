//
//  GlobalViewModel.swift
//  Crypto Watch App
//
//  Created by Virtual Gravity.
//

import SwiftUI

class GlobalViewModel: ObservableObject {
    @AppStorage("widgetTapped") var widgetTapped: Bool = false
}
