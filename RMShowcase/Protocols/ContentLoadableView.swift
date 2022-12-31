//
//  ContentLoadableView.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import SwiftUI

protocol ContentLoadableView: View {
    associatedtype Content
    init(
        content: @escaping () -> Content,
        noContentInfo: String,
        isLoading: Bool,
        hasContent: Bool,
        progressViewTopMargin: CGFloat
    )
}

extension ContentLoadableView {
    init(@ViewBuilder _ content: @escaping () -> Content,
         noContentInfo: String,
         isLoading: Bool,
         hasContent: Bool,
         progressViewTopMargin: CGFloat = Constants.UI.bigMargin
    ) {
        self.init(
            content: content,
            noContentInfo: noContentInfo,
            isLoading: isLoading,
            hasContent: hasContent,
            progressViewTopMargin: progressViewTopMargin
        )
    }
}
