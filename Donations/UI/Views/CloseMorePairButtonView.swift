//
//  CloseMorePairButtonView.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import UIKit
import Material
import PureLayout

class CloseMorePairButtonView: View {
    var coreView: View = {
        let view = View()
        view.setCorners(10)
        view.backgroundColor = UIColor.color(from: 0x282B2E).withAlphaComponent(0.12)
        return view
    }()
    var dividerView: View = {
        let view = View()
        view.setCorners(0.5)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        return view
    }()
    var exitButton: FlatButton = {
        let button = FlatButton()
        button.backgroundColor = .clear
        button.image = UIImage(named: "cancel_24")
        return button
    }()
    var moreButton: FlatButton = {
        let button = FlatButton()
        button.backgroundColor = .clear
        button.image = UIImage(named: "more_horizontal_24")
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        translatesAutoresizingMaskIntoConstraints = false
        autoSetDimension(.width, toSize: 86)
        
        addSubview(coreView)
        coreView.addSubview(moreButton)
        coreView.addSubview(dividerView)
        coreView.addSubview(exitButton)
        
        coreView.autoSetDimensions(to: CGSize(width: 88, height: 32))
        coreView.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -4)
        coreView.autoPinEdge(.leading, to: .leading, of: self, withOffset: 4)
        coreView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        dividerView.autoCenterInSuperview()
        dividerView.autoSetDimension(.width, toSize: 1)
        dividerView.autoPinEdge(.top, to: .top, of: coreView, withOffset: 4)
        dividerView.autoPinEdge(.bottom, to: .bottom, of: coreView, withOffset: -4)
        
        moreButton.autoPinEdge(.top, to: .top, of: coreView, withOffset: 0)
        moreButton.autoPinEdge(.leading, to: .leading, of: coreView, withOffset: 0)
        moreButton.autoPinEdge(.trailing, to: .leading, of: dividerView, withOffset: 0)
        moreButton.autoPinEdge(.bottom, to: .bottom, of: coreView, withOffset: 0)
        
        exitButton.autoPinEdge(.top, to: .top, of: coreView, withOffset: 0)
        exitButton.autoPinEdge(.leading, to: .trailing, of: dividerView, withOffset: 0)
        exitButton.autoPinEdge(.trailing, to: .trailing, of: coreView, withOffset: 0)
        exitButton.autoPinEdge(.bottom, to: .bottom, of: coreView, withOffset: 0)
    }
}
