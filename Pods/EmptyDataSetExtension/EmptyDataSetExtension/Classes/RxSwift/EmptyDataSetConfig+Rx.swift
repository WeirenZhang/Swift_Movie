
import RxCocoa
import RxSwift
import UIKit

public extension Reactive where Base: EmptyDataSetConfig {

    /// The title of the dataset.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    var title: Binder<NSAttributedString?> {
        return Binder(base) {
            $0.title = $1
        }
    }

    /// The description of the dataSet.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    var detail: Binder<NSAttributedString?> {
        return Binder(base) {
            $0.detail = $1
        }
    }

    /// An image of the dataset.
    var image: Binder<UIImage?> {
        return Binder(base) {
            $0.image = $1
        }
    }

    /// A tint color of the image dataset.
    /// Default is nil.
    var imageTintColor: Binder<UIColor?> {
        return Binder(base) {
            $0.imageTintColor = $1
        }
    }

    /// The image animation of the dataset.
    var imageAnimation: Binder<CAAnimation?> {
        return Binder(base) {
            $0.imageAnimation = $1
        }
    }

    /// The title to be used for the specified button state.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    var buttonTitle: Binder<[UIControlState: NSAttributedString?]?> {
        Binder(base) {
            $0.buttonTitle = $1
        }
    }
    /// The image to be used for the specified button state.
    /// This closure will override buttonTitleForEmptyDataSet:forState: and present the image only without any text.
    var buttonImage: Binder<[UIControlState: UIImage?]?> {
        Binder(base) {
            $0.buttonImage = $1
        }
    }

    /// A background image to be used for the specified button state.
    /// There is no default style for this call.
    var buttonBackgroundImage: Binder<[UIControlState: UIImage?]?> {
        Binder(base) {
            $0.buttonBackgroundImage = $1
        }
    }

    /// The background color of the dataset.
    /// Default is clear color.
    var backgroundColor: Binder<UIColor?> {
        return Binder(base) {
            $0.backgroundColor = $1
        }
    }

    /// A custom view to be displayed instead of the default views such as labels, imageview and button.
    /// Default is nil.
    var customView: Binder<UIView?> {
        return Binder(base) {
            $0.customView = $1
        }
    }

    /// Vertical alignment of the content.
    /// Default is 0.
    var verticalOffset: Binder<CGFloat> {
        return Binder(base) {
            $0.verticalOffset = $1
        }
    }

    /// A vertical space between elements.
    /// Default is 11 pts.
    var spaceHeight: Binder<CGFloat> {
        return Binder(base) {
            $0.spaceHeight = $1
        }
    }

    /// The empty dataset should fade in when displayed.
    /// Default is true.
    var isFadeIn: Binder<Bool> {
        return Binder(base) {
            $0.isFadeIn = $1
        }
    }

    /// if the empty dataset should still be displayed when the amount of items is more than 0.
    /// Default is false.
    var isBeForcedToDisplay: Binder<Bool> {
        return Binder(base) {
            $0.isBeForcedToDisplay = $1
        }
    }

    /// The rendered and displayed permission of the empty dataset.
    /// Default is true.
    var isDisplay: Binder<Bool> {
        return Binder(base) {
            $0.isDisplay = $1
        }
    }

    /// The rendered and displayed permission of the empty dataset.
    /// Use it when you are doing some time-consuming operation.
    /// Like this:
    /// isLoading = true
    /// do something...
    /// isLoading = false
    /// Default is false.
    var isLoading: Binder<Bool> {
        return Binder(base) {
            $0.isLoading = $1
        }
    }

    /// The touch permission of the empty dataset .
    /// Default is true.
    var isAllowTouch: Binder<Bool> {
        return Binder(base) {
            $0.isAllowTouch = $1
        }
    }

    /// The scroll permission of the empty dataset.
    /// Default is false.
    var isAllowScroll: Binder<Bool> {
        return Binder(base) {
            $0.isAllowScroll = $1
        }
    }

    /// The animation permission of the dataset image view.
    /// Default is false.
    var isAnimateImageView: Binder<Bool> {
        return Binder(base) {
            $0.isAnimateImageView = $1
        }
    }

    /// The empty dataset view was tapped.
    /// Use this closure either to resignFirstResponder of a textField or searchBar.
    var didTapView: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create { [weak control = self.base] observer in

            MainScheduler.ensureRunningOnMainThread()
            guard let control = control else {
                observer.on(.completed)
                return Disposables.create()
            }

            control.didTapView = {
                observer.on(.next(()))
            }

            return Disposables.create()
        }
        .take(until: deallocated)

        return ControlEvent(events: source)
    }

    /// The action button was tapped.
    var didTapButton: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create { [weak control = self.base] observer in

            MainScheduler.ensureRunningOnMainThread()
            guard let control = control else {
                observer.on(.completed)
                return Disposables.create()
            }

            control.didTapButton = {
                observer.on(.next(()))
            }

            return Disposables.create()
        }
        .take(until: deallocated)

        return ControlEvent(events: source)
    }

    /// The empty data set will appear.
    var willAppear: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create { [weak control = self.base] observer in

            MainScheduler.ensureRunningOnMainThread()
            guard let control = control else {
                observer.on(.completed)
                return Disposables.create()
            }

            control.willAppear = {
                observer.on(.next(()))
            }

            return Disposables.create()
        }
        .take(until: deallocated)

        return ControlEvent(events: source)
    }

    /// The empty data set did appear.
    var didAppear: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create { [weak control = self.base] observer in

            MainScheduler.ensureRunningOnMainThread()
            guard let control = control else {
                observer.on(.completed)
                return Disposables.create()
            }

            control.didAppear = {
                observer.on(.next(()))
            }

            return Disposables.create()
        }
        .take(until: deallocated)

        return ControlEvent(events: source)
    }

    /// The empty data set will disappear.
    var willDisappear: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create { [weak control = self.base] observer in

            MainScheduler.ensureRunningOnMainThread()
            guard let control = control else {
                observer.on(.completed)
                return Disposables.create()
            }

            control.willDisappear = {
                observer.on(.next(()))
            }

            return Disposables.create()
        }
        .take(until: deallocated)

        return ControlEvent(events: source)
    }

    /// The empty data set did disappear.
    var didDisappear: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create { [weak control = self.base] observer in

            MainScheduler.ensureRunningOnMainThread()
            guard let control = control else {
                observer.on(.completed)
                return Disposables.create()
            }

            control.didDisappear = {
                observer.on(.next(()))
            }

            return Disposables.create()
        }
        .take(until: deallocated)

        return ControlEvent(events: source)
    }
}

extension EmptyDataSetConfig: ReactiveCompatible {}
