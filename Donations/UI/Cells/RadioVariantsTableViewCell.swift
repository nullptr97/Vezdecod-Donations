//
//  File.swift
//  Donations
//
//  Created by Ярослав Стрельников on 12.09.2020.
//

import Foundation
import UIKit
import Material

class RadioVariantsTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = String(describing: RadioVariantsTableViewCell.self)
    weak var delegate: TableViewCellDelegate?

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .color(from: 0x6D7885)
        label.fontSize = 14
        return label
    }()

    let completedSummRadioButton: RadioButton = {
        let button = RadioButton()
        button.isSelected = true
        button.title = "Когда соберём сумму"
        button.selectedPulseColor = .extendedBlue
        button.titleColor = .black
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 12)
        button.fontSize = 16
        button.setCorners(10)
        return button
    }()
    
    let dateRadioButton: RadioButton = {
        let button = RadioButton()
        button.isSelected = false
        button.title = "В определённую дату"
        button.selectedPulseColor = .extendedBlue
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 12)
        button.titleColor = .black
        button.fontSize = 16
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func setup(description: String = "") {
        contentView.isUserInteractionEnabled = false

        addSubview(completedSummRadioButton)
        addSubview(dateRadioButton)
        addSubview(descriptionLabel)
        
        descriptionLabel.text = description
        descriptionLabel.sizeToFit()
        
        descriptionLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 14)
        descriptionLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -12)
        descriptionLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12)

        completedSummRadioButton.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 8)
        completedSummRadioButton.autoPinEdge(.leading, to: .leading, of: self)
        completedSummRadioButton.autoPinEdge(.trailing, to: .trailing, of: self)
        completedSummRadioButton.autoSetDimension(.height, toSize: 44)
        
        dateRadioButton.autoPinEdge(.top, to: .bottom, of: completedSummRadioButton)
        dateRadioButton.autoPinEdge(.leading, to: .leading, of: self)
        dateRadioButton.autoPinEdge(.trailing, to: .trailing, of: self)
        dateRadioButton.autoPinEdge(.bottom, to: .bottom, of: self)
        dateRadioButton.autoSetDimension(.height, toSize: 44)
    }
    
    @objc func onTapNext() {
    }
}

