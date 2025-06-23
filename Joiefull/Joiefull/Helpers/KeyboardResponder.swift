//
//  KeyboardResponder.swift
//  Joiefull
//
//  Created by Elo on 23/06/2025.
//


import Combine
import SwiftUI

final class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification in
                if notification.name == UIResponder.keyboardWillHideNotification {
                    return 0
                }
                if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    return frame.height
                }
                return 0
            }
            .assign(to: \.keyboardHeight, on: self)
    }
}