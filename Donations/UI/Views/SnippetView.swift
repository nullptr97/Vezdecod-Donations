//
//  SnippetView.swift
//  Donations
//
//  Created by Ярослав Стрельников on 12.09.2020.
//

import Foundation
import Material
import UIKit

class SnippetView: View {
    let coverImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .adaptableWhite
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .color(from: 0x818C99)
        label.fontSize = 13
        return label
    }()
    
    let dividerView: View = {
        let view = View()
        view.backgroundColor = .color(from: 0xD7D8D9)
        view.autoSetDimension(.height, toSize: 0.5)
        return view
    }()
    
    let firstHelpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Помогите первым"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    let progressView: UIProgressView = {
        let view = UIProgressView()
        view.progress = 0
        view.progressViewStyle = .bar
        view.progressTintColor = .extendedBlue
        view.trackTintColor = UIColor.extendedBlue.withAlphaComponent(0.3)
        view.setCorners(2)
        return view
    }()
    
    var helpButton: FlatButton = {
        let button = FlatButton()
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.titleColor = .extendedBlue
        button.title = "Помочь"
        button.contentEdgeInsets = UIEdgeInsets(top: 5.5, left: 16, bottom: 6.5, right: 16)
        button.drawBorder(10, width: 0.5, color: .extendedBlue)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawBorder(10, width: 0.5, color: UIColor.black.withAlphaComponent(0.08))
        
        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(dividerView)
        addSubview(helpButton)
        addSubview(firstHelpLabel)
        addSubview(progressView)
        
        coverImageView.autoPinEdge(.top, to: .top, of: self)
        coverImageView.autoPinEdge(.leading, to: .leading, of: self)
        coverImageView.autoPinEdge(.trailing, to: .trailing, of: self)
        coverImageView.autoSetDimension(.height, toSize: 140)
        
        titleLabel.autoPinEdge(.top, to: .bottom, of: coverImageView, withOffset: 8)
        titleLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12)
        titleLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -12)
        
        authorLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        authorLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12)
        authorLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -12)
        
        dividerView.autoPinEdge(.top, to: .bottom, of: authorLabel, withOffset: 8)
        dividerView.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12)
        dividerView.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -12)

        helpButton.autoPinEdge(.top, to: .bottom, of: dividerView, withOffset: 11.5)
        helpButton.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -12)
        helpButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -12)
        helpButton.autoSetDimensions(to: .custom(86, 30))
        
        firstHelpLabel.autoPinEdge(.top, to: .bottom, of: dividerView, withOffset: 11.5)
        firstHelpLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12)
        firstHelpLabel.autoPinEdge(.trailing, to: .leading, of: helpButton, withOffset: -12)
        
        progressView.autoPinEdge(.top, to: .bottom, of: firstHelpLabel, withOffset: 8)
        progressView.autoPinEdge(.leading, to: .leading, of: self, withOffset: 12)
        progressView.autoPinEdge(.trailing, to: .leading, of: helpButton, withOffset: -12)
        progressView.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -14)
        progressView.autoSetDimension(.height, toSize: 4)
    }
    
    var title: String {
        get {
            return titleLabel.text ?? ""
        } set {
            titleLabel.text = newValue
            titleLabel.sizeToFit()
        }
    }
    
    var author: String {
        get {
            return authorLabel.text ?? ""
        } set {
            authorLabel.text = newValue
            authorLabel.sizeToFit()
        }
    }
}
