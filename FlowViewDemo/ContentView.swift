//
//  ContentView.swift
//  FlowViewDemo
//
//  Created by Kyle Ronayne on 4/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresentingFlowView: Bool = false
    
    var body: some View {
        Button("Begin Flow") {
            isPresentingFlowView = true
        }
        .fullScreenCover(isPresented: $isPresentingFlowView) {
            FlowView(firstStep: .ageEntry, data: FlowData())
        }
    }
}

#Preview {
    ContentView()
}
