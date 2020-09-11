//
//  BaseViewController.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import UIKit
import Material

class BaseViewController: ViewController {
    var rightButtonsView: CloseMorePairButtonView = CloseMorePairButtonView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 96, height: 44)))
    var toolbar: Toolbar = Toolbar(frame: CGRect(origin: .zero, size: CGSize(width: Screen.width, height: 52)))
    var backButton: IconButton = IconButton(image: UIImage(named: "Back Icon"), tintColor: .extendedBlue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .adaptableWhite
        view.addSubview(toolbar)
        
        toolbar.autoPinEdge(.top, to: .top, of: view, withOffset: 22)
        toolbar.autoPinEdge(.leading, to: .leading, of: view)
        toolbar.autoPinEdge(.trailing, to: .trailing, of: view)
        toolbar.backgroundColor = .adaptableWhite
    }
    
    func setupToolbar(title: String, isNeedBackButton: Bool) {
        toolbar.title = title
        toolbar.titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
        toolbar.rightViews = [rightButtonsView]
        toolbar.leftViews = isNeedBackButton ? [backButton] : []
        toolbar.dividerColor = .color(from: 0xD7D8D9)
        toolbar.dividerThickness = 0.33
        toolbar.dividerContentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
}
extension CGSize {
    static func custom(_ width: CGFloat, _ height: CGFloat) -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    static func identity(_ value: CGFloat) -> CGSize {
        return CGSize(width: value, height: value)
    }
}
