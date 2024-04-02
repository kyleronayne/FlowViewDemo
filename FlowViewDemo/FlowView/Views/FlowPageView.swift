//
//  FlowPageView.swift
//  FlowViewDemo
//
//  Created by Kyle Ronayne on 4/2/24.
//

import SwiftUI

/// A container view that displays and manages the navigation animation for a step in the flow.
///
/// - Parameters:
///   - flowRouter: The router responsible for managing the user's navigation between steps in the flow. This will be propagated to each step view in the flow.
///   - flowData: The data collected by the flow. This will be propagated to each step view in the flow.
///   - isTransitioning: A binding to a boolean that will return `true` when the flow is transitioning to a new step view.
struct FlowPageView: UIViewControllerRepresentable {
    @Binding private var isTransitioning: Bool
    private let flowRouter: FlowRouter
    private let flowData: FlowData
    typealias UIViewControllerType = FlowPageViewController
    
    init(flowRouter: FlowRouter, flowData: FlowData, isTransitioning: Binding<Bool> = .constant(true)) {
        self.flowRouter = flowRouter
        self.flowData = flowData
        self._isTransitioning = isTransitioning
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return FlowPageViewController(flowRouter: flowRouter, flowData: flowData, isTransitioning: $isTransitioning)
    }

    func updateUIViewController(_ flowPageViewController: UIViewControllerType, context: Context) {
        // no-op
    }
    
    class FlowPageViewController: UIPageViewController, FlowPageViewControllerDelegate {
        @Binding private var isTransitioning: Bool
        private let flowRouter: FlowRouter
        private let flowData: FlowData
        
        init(flowRouter: FlowRouter, flowData: FlowData, isTransitioning: Binding<Bool>) {
            self.flowRouter = flowRouter
            self.flowData = flowData
            self._isTransitioning = isTransitioning
            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            flowRouter.delegate = self
            setViewControllers([viewController(forStep: flowRouter.currentStep)], direction: .forward, animated: false)
        }
        
        func didStepChange(to step: FlowStep, inDirection direction: UIPageViewController.NavigationDirection) {
            isTransitioning = true
            
            setViewControllers([viewController(forStep: step)], direction: direction, animated: true) { isTransitionFinished in
                self.isTransitioning = !isTransitionFinished
            }
        }
        
        private func viewController(forStep step: FlowStep) -> UIViewController {
            let stepView = step.view.environmentObject(flowRouter).environmentObject(flowData)
            return UIHostingController(rootView: stepView)
        }
    }
}
