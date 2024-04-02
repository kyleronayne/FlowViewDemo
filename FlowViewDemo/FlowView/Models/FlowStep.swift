//
//  FlowStep.swift
//  FlowViewDemo
//
//  Created by Kyle Ronayne on 4/2/24.
//

import SwiftUI

/// A step in the flow.
enum FlowStep {
    case ageEntry
    case eligibleUser
    case ineligibleUser
    
    /// The view for this step.
    @ViewBuilder var view: some View {
        switch self {
            case .ageEntry:
                AgeEntryStepView()
            case .eligibleUser:
                EligibleUserStepView()
            case .ineligibleUser:
                IneligibleUserStepView()
        }
    }
}
