//
//  RxTheme+.swift
//  RxThemeTutorial
//
//  Created by Alex Nagy on 03/04/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//

import RxSwift
import RxCocoa
import RxTheme

// Simple example
//
// themedClass: UIButton
// themable: borderColor
// themableType: CGColor
// themed: button
//

extension Reactive where Base: UIButton {
    var borderColor: Binder<CGColor?> {
        return Binder(self.base) { button, borderColor in
            button.layer.borderColor = borderColor
        }
    }
}

extension ThemeProxy where Base: UIButton {
    var borderColor: Observable<CGColor?> {
        get { return .empty() }
        set {
            let disposable = newValue
                .takeUntil(base.rx.deallocating)
                .observeOn(MainScheduler.instance)
                .bind(to: base.rx.borderColor)
            hold(disposable, for: "borderColor")
        }
    }
}
