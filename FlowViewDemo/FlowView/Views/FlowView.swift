//
//  FlowView.swift
//  FlowViewDemo
//
//  Created by Kyle Ronayne on 4/2/24.
//

import SwiftUI

/// A view that displays a flow.
struct FlowView: View {
    @Environment(\.dismiss) private var dismissAction
    @ObservedObject private var router: FlowRouter
    @ObservedObject private var data: FlowData
    @State private var isBackButtonDisabled: Bool = false
    
    init(firstStep: FlowStep, data: FlowData) {
        self.data = data
        self.router = FlowRouter(firstStep: firstStep, flowData: data)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { router.navigateBackward(dismissFlowAction: dismissAction) }) {
                    Image(systemName: "chevron.backward")
                }
                .disabled(isBackButtonDisabled)
                
                Spacer()
                
                Button(action: dismissAction.callAsFunction) {
                    Image(systemName: "xmark")
                }
            }
            .padding(.horizontal)
            
            FlowPageView(flowRouter: router, flowData: data, isTransitioning: $isBackButtonDisabled)
        }
    }
}

#Preview {
    FlowView(firstStep: .ageEntry, data: FlowData())
}
