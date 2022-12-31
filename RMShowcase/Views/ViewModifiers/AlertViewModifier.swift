//
//  AlertViewModifier.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import SwiftUI

struct AlertViewModifier: ViewModifier {
    
    @Binding var alertMessage: AlertMessageInfo?
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .alert(item: $alertMessage) { alertMessage in
                Alert(
                    title: Text(alertMessage.title),
                    message: Text(alertMessage.description),
                    dismissButton: .default(Text(alertMessage.dismissText), action: {
                        action()
                    })
                )
            }
    }
}

extension View {
    func alertView(for alertMessage: Binding<AlertMessageInfo?>, action: @escaping (() -> Void) = {}) -> some View {
        modifier(AlertViewModifier(alertMessage: alertMessage, action: action))
    }
}
