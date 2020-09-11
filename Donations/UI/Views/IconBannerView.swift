//
//  IconBannerView.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import UIKit
import Material
import PureLayout

class IconBannerView: PulseView {
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        return imageView
    }()
    var titleBannerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .adaptableBlack
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    var descriptionBannerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .color(from: 0x6D7885)
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    var performImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "chevron_right_24")
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .color(from: 0xF5F5F5)
        setCorners(10)
        drawBorder(10, width: 0.33, color: UIColor.black.withAlphaComponent(0.08))
        
        addSubview(iconImageView)
        addSubview(titleBannerLabel)
        addSubview(descriptionBannerLabel)
        addSubview(performImageView)
        
        iconImageView.autoPinEdge(.top, to: .top, of: self, withOffset: 12)
        iconImageView.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12)
        iconImageView.autoSetDimensions(to: .identity(28))
        
        performImageView.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -12)
        performImageView.autoSetDimensions(to: .identity(24))
        performImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        titleBannerLabel.autoPinEdge(.leading, to: .trailing, of: iconImageView, withOffset: 12)
        titleBannerLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 12)
        titleBannerLabel.autoPinEdge(.trailing, to: .leading, of: performImageView, withOffset: -12)
        
        descriptionBannerLabel.autoPinEdge(.leading, to: .trailing, of: iconImageView, withOffset: 12)
        descriptionBannerLabel.autoPinEdge(.top, to: .bottom, of: titleBannerLabel, withOffset: 0)
        descriptionBannerLabel.autoPinEdge(.trailing, to: .leading, of: performImageView, withOffset: -12)
        descriptionBannerLabel.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -12)
    }
    
    
    var bannerTitle: String {
        get {
            return titleBannerLabel.text ?? ""
        } set {
            titleBannerLabel.text = newValue
            titleBannerLabel.sizeToFit()
        }
    }
    
    var bannerDescription: String {
        get {
            return descriptionBannerLabel.text ?? ""
        } set {
            descriptionBannerLabel.text = newValue
            descriptionBannerLabel.sizeToFit()
        }
    }
    
    var bannerImage: String {
        get {
            return iconImageView.image?.description ?? ""
        } set {
            iconImageView.image = UIImage(named: newValue)
        }
    }
}
