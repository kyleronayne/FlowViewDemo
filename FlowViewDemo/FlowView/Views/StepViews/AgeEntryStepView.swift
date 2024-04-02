//
//  AgeEntryStepView.swift
//  FlowViewDemo
//
//  Created by Kyle Ronayne on 4/2/24.
//

import SwiftUI

struct AgeEntryStepView: View {
    @Environment(\.dismiss) private var dismissAction
    @EnvironmentObject var flowRouter: FlowRouter
    @EnvironmentObject var flowData: FlowData
    
    var body: some View {
        VStack {
            Text("Select Your Age")
            Text("\(flowData.age)")
            Picker("", selection: $flowData.age) {
                ForEach(1...100, id: \.self) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.wheel)
            
            Spacer()
            
            Button("Next") {
                flowRouter.navigateForward(dismissFlowAction: dismissAction)
            }
        }
    }
}

#Preview {
    AgeEntryStepView()
}
