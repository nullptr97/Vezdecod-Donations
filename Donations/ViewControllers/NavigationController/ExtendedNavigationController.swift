//
//  ExtendedNavigationController.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import UIKit
import Material

class ExtendedNavigationController: UINavigationController, UINavigationControllerDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        invisible = true
        modalPresentationStyle = .fullScreen
    
        view.addGestureRecognizer(fullScreenPanGestureRecognizer)
        delegate = self

        guard let navigationBar = navigationBar as? NavigationBar else { return }

        navigationBar.depthPreset = .none
        navigationBar.heightPreset = .custom(0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private lazy var fullScreenPanGestureRecognizer: UIPanGestureRecognizer = {
        let gestureRecognizer = UIPanGestureRecognizer()
        
        if let cachedInteractionController = self.value(forKey: "_cachedInteractionController") as? NSObject {
            let selector = Selector(("handleNavigationTransition:"))
            if cachedInteractionController.responds(to: selector) {
                gestureRecognizer.addTarget(cachedInteractionController, action: selector)
            }
        }
        return gestureRecognizer
    }()
    
    public func navigationController(_: UINavigationController, didShow _: UIViewController, animated _: Bool) {
        self.fullScreenPanGestureRecognizer.isEnabled = self.viewControllers.count > 1
    }
}
extension UINavigationController {
    var invisible: Bool {
        get {
            return self.isNavigationBarHidden
        } set {
            self.setNavigationBarHidden(newValue, animated: false)
        }
    }
    
    func invisible<T: UINavigationController>(navigationController: T) {
        self.setNavigationBarHidden(true, animated: false)
    }

    func statusbarColor(from color: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = color
        view.addSubview(statusBarView)
    }
}
