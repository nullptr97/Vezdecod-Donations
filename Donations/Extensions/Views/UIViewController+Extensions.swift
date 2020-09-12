//
//  UIViewController+Extensions.swift
//  Donations
//
//  Created by Ярослав Стрельников on 12.09.2020.
//

import Foundation
import UIKit

extension UIViewController {
    @objc public func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
