//
//  FlowRouter.swift
//  FlowViewDemo
//
//  Created by Kyle Ronayne on 4/2/24.
//

import SwiftUI

/// A router responsible for managing the user's navigation between steps in the flow.
///
/// - Parameters:
///   - firstStep: The step for which to being the flow.
///   - flowData: The data to propagate between flow steps.
class FlowRouter: ObservableObject {
    weak var delegate: FlowPageViewControllerDelegate?
    private let flowData: FlowData
    private(set) var currentStep: FlowStep
    private var stepStack: [FlowStep]
    
    init(firstStep: FlowStep, flowData: FlowData) {
        self.currentStep = firstStep
        self.stepStack = [firstStep]
        self.flowData = flowData
    }
    
    /// Navigates the user forward to the next step in the flow. If a next step does not exist, the flow view will be dismissed.
    ///
    /// - Parameter dismissFlowAction: An action that dismisses the flow view presentation.
    func navigateForward(dismissFlowAction: DismissAction) {
        guard let nextStep = getNextStep() else {
            dismissFlowAction.callAsFunction()
            return
        }
        
        currentStep = nextStep
        stepStack.append(nextStep)
        delegate?.didStepChange(to: nextStep, inDirection: .forward)
    }
    
    /// Navigates the user backward to the previous step in the flow. If a previous step does not exist, the flow view will be dismissed.
    ///
    /// - Parameter dismissFlowAction: An action that dismisses the flow view presentation.
    func navigateBackward(dismissFlowAction: DismissAction) {
        guard !stepStack.isEmpty else {
            return
        }
        
        stepStack.removeLast()
        
        guard let previousStep = stepStack.last else {
            dismissFlowAction.callAsFunction()
            return
        }
        
        currentStep = previousStep
        delegate?.didStepChange(to: previousStep, inDirection: .reverse)
    }
    
    /// Returns the next step in the flow based on the current step and the flow data. A `nil` return value indicates the end of the flow.
    ///
    /// - Returns: A flow step.
    private func getNextStep() -> FlowStep? {
        switch currentStep {
            case .ageEntry:
                return flowData.age < 16 ? .ineligibleUser : .eligibleUser
            case .eligibleUser:
                return nil
            case .ineligibleUser:
                return nil
        }
    }
}
