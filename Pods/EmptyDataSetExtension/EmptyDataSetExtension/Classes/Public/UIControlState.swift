//
//  UIControlState.swift
//  EmptyDataSetExtension
//
//  Created by Insect on 2021/9/30.
//

import UIKit

public enum UIControlState {

    case normal

    case highlighted

    case disabled

    case selected

    case focused

    case application

    case reserved
}

extension UIControl.State {

    var toState: UIControlState {
        switch self {
        case .normal:
            return .normal
        case .highlighted:
            return .highlighted
        case .disabled:
            return .disabled
        case .selected:
            return .selected
        case .focused:
            return .focused
        case .application:
            return .application
        case .reserved:
            return .reserved
        default:
            return .normal
        }
    }
}

extension UIControlState {

    var state: UIControl.State {
        switch self {
        case .normal:
            return .normal
        case .highlighted:
            return .highlighted
        case .disabled:
            return .disabled
        case .selected:
            return .selected
        case .focused:
            return .focused
        case .application:
            return .application
        case .reserved:
            return .reserved
        }
    }
}
