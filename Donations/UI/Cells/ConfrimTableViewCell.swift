//
//  ConfrimTableCellView.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import UIKit
import Material

class ConfrimTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = String(describing: ConfrimTableViewCell.self)
    weak var delegate: TableViewCellDelegate?
    
    let addImageButton: FlatButton = {
        let button = FlatButton()
        button.title = "Далее"
        button.backgroundColor = .extendedBlue
        button.titleColor = .white
        button.fontSize = 17
        button.setCorners(10)
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        addImageButton.image = nil
    }

    func setup() {
        contentView.isUserInteractionEnabled = false
        addSubview(addImageButton)
        addImageButton.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12 ))
        addImageButton.autoSetDimension(.height, toSize: 44)
        addImageButton.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
    }
    
    @objc func onTapNext() {
        delegate?.onTapNext(from: self)
    }
}
