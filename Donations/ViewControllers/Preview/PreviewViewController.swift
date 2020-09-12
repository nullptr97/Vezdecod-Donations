//
//  PreviewViewController.swift
//  Donations
//
//  Created by Ярослав Стрельников on 12.09.2020.
//

import UIKit
import Material

class PreviewViewController: BaseViewController {
    var buttonBottomConstraint: NSLayoutConstraint?
    let snippetView: SnippetView = SnippetView()

    let dismissButton: IconButton = {
        let button = IconButton(image: UIImage(named: "dismiss_24"))
        return button
    }()
    
    let sendButton: IconButton = {
        let button = IconButton(image: UIImage(named: "send_sign_28"))
        return button
    }()
    
    let inputTextView: TextView = {
        let textView = TextView()
        textView.backgroundColor = .clear
        textView.placeholderLabel.font = UIFont.systemFont(ofSize: 15)
        textView.placeholderLabel.textColor = .color(from: 0x818C99)
        textView.placeholderLabel.numberOfLines = 0
        textView.keyboardDismissMode = .interactive
        textView.placeholder = "Ваше сообщение"
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    let barView: View = {
        let view = View()
        
        let postingImageView = UIImageView(image: UIImage(named: "Posting Settings"))
        let spaceImageView = UIImageView(image: UIImage(named: "12 pt"))
        let attachmentBarImageView = UIImageView(image: UIImage(named: "Attachment Bar"))
        
        view.addSubview(postingImageView)
        view.addSubview(spaceImageView)
        view.addSubview(attachmentBarImageView)
        
        postingImageView.autoPinEdge(.top, to: .top, of: view)
        postingImageView.autoPinEdge(.leading, to: .leading, of: view)
        postingImageView.autoPinEdge(.trailing, to: .trailing, of: view)
        postingImageView.autoSetDimension(.height, toSize: 34)
        
        spaceImageView.autoPinEdge(.top, to: .bottom, of: postingImageView)
        spaceImageView.autoPinEdge(.leading, to: .leading, of: view)
        spaceImageView.autoPinEdge(.trailing, to: .trailing, of: view)
        spaceImageView.autoSetDimension(.height, toSize: 12)
        
        attachmentBarImageView.autoPinEdge(.top, to: .bottom, of: spaceImageView)
        attachmentBarImageView.autoPinEdge(.leading, to: .leading, of: view)
        attachmentBarImageView.autoPinEdge(.trailing, to: .trailing, of: view)
        attachmentBarImageView.autoPinEdge(.bottom, to: .bottom, of: view)
        attachmentBarImageView.autoSetDimension(.height, toSize: 56)
        
        return view
    }()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    init(title: String, author: String, image: UIImage?) {
        snippetView.coverImageView.image = image
        snippetView.title = title
        snippetView.author = author
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        modalPresentationStyle = .fullScreen
        setupToolbar(title: "Матвей", isNeedBackButton: false)
        
        view.addSubview(barView)
        buttonBottomConstraint = barView.autoPinEdge(toSuperviewSafeArea: .bottom)
        barView.autoPinEdge(toSuperviewSafeArea: .trailing)
        barView.autoPinEdge(toSuperviewSafeArea: .leading)
        
        setupTextView()
        setupSnippet()
    }
    
    override func setupToolbar(title: String, isNeedBackButton: Bool) {
        super.setupToolbar(title: title, isNeedBackButton: isNeedBackButton)
        toolbar.title = title
        toolbar.leftViews = [dismissButton]
        toolbar.rightViews = [sendButton]
        rightButtonsView.removeFromSuperview()
    }
    
    func setupTextView() {
        view.addSubview(inputTextView)
        
        inputTextView.autoPinEdge(.top, to: .bottom, of: toolbar, withOffset: 12)
        inputTextView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 12)
        inputTextView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
        inputTextView.autoSetDimension(.height, toSize: 20, relation: .greaterThanOrEqual)
    }
    
    func setupSnippet() {
        view.addSubview(snippetView)
        snippetView.autoPinEdge(.top, to: .bottom, of: inputTextView, withOffset: 12)
        snippetView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 12)
        snippetView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 12)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        buttonBottomConstraint?.constant = (endFrame?.size.height ?? 0) > 0 ? -(endFrame?.size.height ?? 0) : 0
        
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }
}
