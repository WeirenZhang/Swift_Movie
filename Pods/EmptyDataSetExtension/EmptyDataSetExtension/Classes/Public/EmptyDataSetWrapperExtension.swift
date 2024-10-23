//
//  EmptyDataSetWrapperExtension.swift
//  EmptyDataSetConfig
//
//  Created by Insect on 2021/3/26.
//  Copyright © 2021 Insect. All rights reserved.
//

import DZNEmptyDataSet
import UIKit

private var context: UInt8 = 0

public extension EmptyDataSetWrapper where Base: UIScrollView {

    var config: EmptyDataSetConfig? {
        base.emptyDataSetConfig
    }

    func setConfig(_ config: EmptyDataSetConfig = EmptyDataSetConfig()) {
        base.emptyDataSetConfig = config
    }

    func setConfigAndRun(_ config: EmptyDataSetConfig = EmptyDataSetConfig()) {
        setConfig(config)
        run()
    }

    func run() {
        base.emptyDataSetSource = config?.proxy
        base.emptyDataSetDelegate = config?.proxy
    }

    func stop() {
        base.emptyDataSetSource = nil
        base.emptyDataSetDelegate = nil
        base.emptyDataSetConfig = nil
    }

    func reload() {
        base.reloadEmptyDataSet()
    }
}

fileprivate extension UIScrollView {

    var emptyDataSetConfig: EmptyDataSetConfig? {
        get {
            objc_getAssociatedObject(self, &context) as? EmptyDataSetConfig
        }

        set {
            objc_setAssociatedObject(self,
                                     &context,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            observeEmptyDataSetConfig()
        }
    }

    private func observeEmptyDataSetConfig() {

        emptyDataSetConfig?.valueChanged = { [weak self] in
            self?.reloadEmptyDataSet()
        }
    }
}
