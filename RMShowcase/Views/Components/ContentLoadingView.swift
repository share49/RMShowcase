//
//  ContentLoadingView.swift
//  RMShowcase
//
//  Created by Roger Pintó Diaz on 12/31/22.
//

import SwiftUI

struct ContentLoadingView<Content: View>: ContentLoadableView {
    
    let content: () -> Content
    let noContentInfo: String
    var isLoading: Bool
    var hasContent: Bool
    let progressViewTopMargin: CGFloat
    
    var body: some View {
        VStack {
            if isLoading {
                ListProgressView(topMargin: progressViewTopMargin)
            } else {
                if hasContent {
                    content()
                } else {
                    NoContentInfoView(text: noContentInfo)
                }
            }
        }
    }
}

struct ContentLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        let content = Color(.systemBlue)
        let noContentText = ls.noCharacters
        
        Group {
            ContentLoadingView({
                content
            }, noContentInfo: noContentText, isLoading: true, hasContent: false)
            
            ContentLoadingView({
                content
            }, noContentInfo: noContentText, isLoading: false, hasContent: true)
            
            ContentLoadingView({
                content
            }, noContentInfo: noContentText, isLoading: false, hasContent: false)
        }
    }
}
