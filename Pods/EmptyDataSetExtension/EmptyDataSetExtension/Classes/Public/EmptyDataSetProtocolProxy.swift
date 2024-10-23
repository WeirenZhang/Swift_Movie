//
//  ProtocolProxy.swift
//  EmptyDataSetExtension
//
//  Created by Insect on 2021/9/29.
//

import DZNEmptyDataSet

class EmptyDataSetProtocolProxy: NSObject {

    weak var config: EmptyDataSetConfig?

    init(config: EmptyDataSetConfig) {
        self.config = config
    }
}

extension EmptyDataSetProtocolProxy: DZNEmptyDataSetSource {

    public func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return config?.title
    }

    public func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return config?.detail
    }

    public func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return config?.image
    }

    public func imageTintColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return config?.imageTintColor
    }

    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView) -> CAAnimation? {
        return config?.imageAnimation
    }

    public func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        if let value = config?.buttonTitle?[state.toState] {
            return value
        } else {
            return nil
        }
    }

    public func buttonImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        if let value = config?.buttonImage?[state.toState] {
            return value
        } else {
            return nil
        }
    }

    public func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        if let value = config?.buttonBackgroundImage?[state.toState] {
            return value
        } else {
            return nil
        }
    }

    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return config?.backgroundColor
    }

    public func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        return config?.customView
    }

    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return config?.verticalOffset ?? 0
    }

    public func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return config?.spaceHeight ?? 11
    }
}

// MARK: - EmptyDataSetDelegate

extension EmptyDataSetProtocolProxy: DZNEmptyDataSetDelegate {

    public func emptyDataSetShouldFade(in scrollView: UIScrollView) -> Bool {
        return config?.isFadeIn ?? true
    }

    public func emptyDataSetShouldBeForced(toDisplay scrollView: UIScrollView) -> Bool {
        return config?.isBeForcedToDisplay ?? false
    }

    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return (config?.isDisplay ?? true) ? !(config?.isLoading ?? false) : false
    }

    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return config?.isAllowTouch ?? true
    }

    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return config?.isAllowScroll ?? false
    }

    public func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool {
        return config?.isAnimateImageView ?? true
    }

    public func emptyDataSet(_ scrollView: UIScrollView, didTap view: UIView) {
        config?.didTapView?()
    }

    public func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        config?.didTapButton?()
    }

    public func emptyDataSetWillAppear(_ scrollView: UIScrollView) {
        config?.willAppear?()
    }

    public func emptyDataSetDidAppear(_ scrollView: UIScrollView) {
        config?.didAppear?()
    }

    public func emptyDataSetWillDisappear(_ scrollView: UIScrollView) {
        config?.willDisappear?()
    }

    public func emptyDataSetDidDisappear(_ scrollView: UIScrollView) {
        config?.didDisappear?()
    }
}
