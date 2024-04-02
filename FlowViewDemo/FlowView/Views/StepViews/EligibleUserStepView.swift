//
//  EligibleUserStepView.swift
//  FlowViewDemo
//
//  Created by Kyle Ronayne on 4/2/24.
//

import SwiftUI

struct EligibleUserStepView: View {
    @Environment(\.dismiss) private var dismissAction
    @EnvironmentObject var flowRouter: FlowRouter
    
    var body: some View {
        VStack {
            Text("Wohoo! You are old enough to use our App!")
            
            Spacer()
            
            Button("Finish") {
                flowRouter.navigateForward(dismissFlowAction: dismissAction)
            }
        }
    }
}

#Preview {
    EligibleUserStepView()
}
