//
//  CoverTableViewCell.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import Material
import UIKit

protocol CoverDelegate: class {
    func onTapAddCover(from cell: CoverTableViewCell, with sender: UIView)
}

class CoverTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = String(describing: CoverTableViewCell.self)
    weak var delegate: CoverDelegate?
    
    let coverView: DashedLineView = {
        let view = DashedLineView()
        view.backgroundColor = .adaptableWhite
        view.setCorners(10)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let addImageButton: RaisedButton = {
        let button = RaisedButton(image: UIImage(named: "picture_outline_28"), tintColor: .extendedBlue)
        button.title = "Загрузить обложку"
        button.titleColor = .color(from: 0x3F8AE0)
        button.fontSize = 16
        button.isUserInteractionEnabled = false
        return button
    }()
    
    func setup() {
        contentView.isUserInteractionEnabled = false
        addSubview(coverView)
        coverView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 4, left: 12, bottom: 12, right: 12))
        coverView.autoSetDimension(.height, toSize: 140)
        coverView.addSubview(addImageButton)
        addImageButton.autoCenterInSuperview()
        addImageButton.autoSetDimension(.height, toSize: 28)
        addImageButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        
        coverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapAddCover)))
    }
    
    @objc func onTapAddCover() {
        delegate?.onTapAddCover(from: self, with: coverView)
    }
}
