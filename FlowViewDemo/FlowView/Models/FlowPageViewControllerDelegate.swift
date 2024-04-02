//
//  FlowPageViewControllerDelegate.swift
//  FlowViewDemo
//
//  Created by Kyle Ronayne on 4/2/24.
//

import UIKit

/// A delegate protocol that a ``FlowRouter`` can use to communicate a did-step-change notification to a ``FlowPageView``.
protocol FlowPageViewControllerDelegate: AnyObject {
    /// Sends or receives a notification that the flow's router has changed its current step to the one specified.
    ///
    /// - Parameters:
    ///   - step: The flow router's new current step.
    ///   - direction: The direction for which the flow router wishes to navigate to the specified step.
    func didStepChange(to step: FlowStep, inDirection direction: UIPageViewController.NavigationDirection)
}
