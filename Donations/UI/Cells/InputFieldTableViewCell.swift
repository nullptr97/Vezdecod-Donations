//
//  InputFieldTableViewCell.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import Material
import UIKit

class InputFieldTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = String(describing: InputFieldTableViewCell.self)
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .color(from: 0x6D7885)
        label.fontSize = 14
        return label
    }()
    
    let inputTextView: TextView = {
        let textView = TextView()
        textView.backgroundColor = .color(from: 0xF2F3F5)
        textView.setCorners(10)
        textView.placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        textView.placeholderLabel.textColor = .color(from: 0x818C99)
        textView.placeholderLabel.numberOfLines = 0
        textView.textContainerInsetsPreset = .square16
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.drawBorder(10, width: 0.5, color: UIColor.black.withAlphaComponent(0.12))
        return textView
    }()
    
    var performImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "chevron_right_24")
        imageView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        return imageView
    }()
    
    func setup(placeholder: String = "", description: String = "", hasNeedChevron: Bool = false) {
        contentView.isUserInteractionEnabled = false
        addSubview(descriptionLabel)
        addSubview(inputTextView)
        
        inputTextView.placeholder = placeholder
        inputTextView.sizeToFit()
        
        descriptionLabel.text = description
        descriptionLabel.sizeToFit()
        
        descriptionLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 14)
        descriptionLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -12)
        descriptionLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12)
        
        inputTextView.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 8)
        inputTextView.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -12)
        inputTextView.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12)
        inputTextView.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -12)
        let height = placeholder.height(with: Screen.width - 48, font: UIFont.systemFont(ofSize: 16)) + 24
        inputTextView.autoSetDimension(.height, toSize: height)
        guard hasNeedChevron else { return }
        addSubview(performImageView)
        performImageView.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -22)
        performImageView.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -22)
        inputTextView.placeholderLabel.textColor = .black
        inputTextView.isUserInteractionEnabled = false
    }
    
    var descriptionTitle: String {
        get {
            return descriptionLabel.text ?? ""
        } set {
            descriptionLabel.text = newValue
        }
    }
    
    var placeholderTitle: String {
        get {
            return inputTextView.text ?? ""
        } set {
            inputTextView.placeholder = newValue
            inputTextView.sizeToFit()
        }
    }
}
