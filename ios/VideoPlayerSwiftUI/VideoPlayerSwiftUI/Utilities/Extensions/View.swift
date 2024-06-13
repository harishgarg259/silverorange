//
//  View.swift
//  VideoPlayerSwiftUI
//
//  Created by Harish Garg on 13/06/24.
//

import Foundation
import SwiftUI

extension View {
    func errorAlert(error: Binding<WebError?>, buttonTitle: String = "OK".localized) -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
}

struct LocalizedAlertError: LocalizedError {
    let underlyingError: WebError
    var errorDescription: String? {
        underlyingError.description
    }

    init?(error: WebError?) {
        guard let localizedError = error else { return nil }
        underlyingError = localizedError
    }
}
