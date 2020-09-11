//
//  PlaceHolderView.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import UIKit
import Material
import PureLayout

class PlaceholderView: View {
    var placeholderTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .color(from: 0x818C99)
        label.fontSize = 16
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var createCollectionButton: FlatButton = {
        let button = FlatButton()
        button.backgroundColor = .color(from: 0x4986CC)
        button.fontSize = 16
        button.titleColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 7.5, left: 16, bottom: 8.5, right: 16)
        button.setCorners(10)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(placeholderTextLabel)
        addSubview(createCollectionButton)
        
        placeholderTextLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 48)
        placeholderTextLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 32)
        placeholderTextLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -32)
        
        createCollectionButton.autoAlignAxis(toSuperviewAxis: .vertical)
        createCollectionButton.autoPinEdge(.top, to: .bottom, of: placeholderTextLabel, withOffset: 24)
        createCollectionButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -48)
        createCollectionButton.autoSetDimension(.height, toSize: 36)
    }
    
    var placeholderLabelTitle: String {
        get {
            return placeholderTextLabel.text ?? ""
        } set {
            placeholderTextLabel.text = newValue
            placeholderTextLabel.sizeToFit()
        }
    }
    
    var placeholderButtonTitle: String {
        get {
            return createCollectionButton.title ?? ""
        } set {
            createCollectionButton.title = newValue
            createCollectionButton.sizeToFit()
        }
    }
}
