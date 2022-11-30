

// Created by Gayan Dias on 28/11/2022.

import SwiftUI

extension Alert {
    init(with alertMessage: AlertMessage) {
        if let secondaryButton = alertMessage.secondaryButton {
            self.init(
                title: Text(alertMessage.title),
                message: Text(alertMessage.message),
                primaryButton: alertMessage.primaryButton,
                secondaryButton: secondaryButton
            )
        } else {
            self.init(
                title: Text(alertMessage.title),
                message: Text(alertMessage.message),
                dismissButton: alertMessage.primaryButton
            )
        }
    }
}

extension AlertMessage: Identifiable {
    var id: Int { title.hashValue }
}

struct AlertMessage {
    let title: String
    let message: String
    let primaryButton: Alert.Button
    let secondaryButton: Alert.Button?
}

extension AlertMessage {
    init(title: String, message: String) {
        self.init(
            title: title,
            message: message,
            primaryButton: .default(Text("Ok")),
            secondaryButton: nil
        )
    }
}

extension AlertMessage {
    init(error: Error) {
        switch error {
        case let error as NetworkRequestError:
            self.init(networkError: error)
        default:
            self.init(
                title: "Error",
                message: "It seems something went wrong, please try again later."
            )
        }
    }
}

extension AlertMessage {
    init(networkError: NetworkRequestError) {
        switch networkError {
        default:
            self.init(
                title: "Error",
                message: "It seems something went wrong, please try again later."
            )
        }
    }
}

