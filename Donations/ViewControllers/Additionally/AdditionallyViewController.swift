//
//  AdditionallyViewController.swift
//  Donations
//
//  Created by Ярослав Стрельников on 12.09.2020.
//

import UIKit
import Material

class AdditionallyViewController: BaseViewController {
    let descriptions: [String] = ["Автор",
                                  "Сбор завершится",
                                  "Дата окончания"]
    let placeholders: [String] = ["Матвей Правосудов",
                                  "",
                                  "Выберите дату"]
    var mainTable: TableView = {
        let tableView = TableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .adaptableWhite
        return tableView
    }()
    var buttonBottomConstraint: NSLayoutConstraint?

    let addImageButton: FlatButton = {
        let button = FlatButton()
        button.title = "Создать сбор"
        button.backgroundColor = .extendedBlue
        button.titleColor = .white
        button.fontSize = 17
        button.setCorners(10)
        return button
    }()
    let titleText: String
    let image: UIImage?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    init(title: String, image: UIImage?) {
        self.image = image
        self.titleText = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        setupToolbar(title: "Дополнительно", isNeedBackButton: true)
        setupTable()
        setupButton()
    }
    
    override func setupToolbar(title: String, isNeedBackButton: Bool) {
        super.setupToolbar(title: title, isNeedBackButton: isNeedBackButton)
        toolbar.title = title
    }
    
    func setupTable() {
        view.addSubview(mainTable)
        mainTable.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: toolbar.bounds.height + statusBarHeight, left: 0, bottom: 0, right: 0))
        mainTable.register(RadioVariantsTableViewCell.self, forCellReuseIdentifier: RadioVariantsTableViewCell.reuseIdentifier)
        mainTable.register(InputFieldTableViewCell.self, forCellReuseIdentifier: InputFieldTableViewCell.reuseIdentifier)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.keyboardDismissMode = .onDrag
    }
    
    func setupButton() {
        view.addSubview(addImageButton)
        
        buttonBottomConstraint = addImageButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 12)
        addImageButton.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -12)
        addImageButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 12)
        addImageButton.autoSetDimension(.height, toSize: 44)
        addImageButton.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        buttonBottomConstraint?.constant = (endFrame?.size.height ?? 0) > 0 ? -(endFrame?.size.height ?? 0) - 12 : -12
        
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }
    
    @objc func onTapNext() {
        let previewViewController = PreviewViewController(title: titleText, author: "Матвей Правосудов", image: image)
        previewViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(previewViewController, animated: true, completion: nil)
    }
}
extension AdditionallyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0, 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: InputFieldTableViewCell.reuseIdentifier, for: indexPath) as! InputFieldTableViewCell
            let hasNeedChevron = indexPath.section == 2
            cell.setup(placeholder: placeholders[indexPath.section], description: descriptions[indexPath.section], hasNeedChevron: hasNeedChevron)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: RadioVariantsTableViewCell.reuseIdentifier, for: indexPath) as! RadioVariantsTableViewCell
            cell.setup(description: descriptions[indexPath.section])
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}
