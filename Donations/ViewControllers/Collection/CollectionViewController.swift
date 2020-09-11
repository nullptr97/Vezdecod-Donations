//
//  File.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import Material
import UIKit

class CollectionViewController: BaseViewController {
    let collectionType: CollectionType
    let descriptions: [String]
    let placeholders: [String]
    var mainTable: TableView = {
        let tableView = TableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .adaptableWhite
        return tableView
    }()
    var imagePicker: ImagePicker!
    var keyboardHeight: CGFloat = 0
    
    init(type: CollectionType) {
        collectionType = type
        descriptions = type.getDescriptions()
        placeholders = type.getPlaceholders()
        super.init(nibName: nil, bundle: nil)
        setupToolbar(title: type.rawValue, isNeedBackButton: true)
        NotificationCenter.default.addObserver(self,
               selector: #selector(keyboardNotification(notification:)),
               name: UIResponder.keyboardWillChangeFrameNotification,
               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        setupTable()
    }
    
    override func setupToolbar(title: String, isNeedBackButton: Bool) {
        super.setupToolbar(title: title, isNeedBackButton: isNeedBackButton)
        toolbar.title = title
        toolbar.dividerThickness = 0.0
    }
    
    func setupTable() {
        view.addSubview(mainTable)
        mainTable.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: toolbar.bounds.height + statusBarHeight, left: 0, bottom: 0, right: 0))
        mainTable.register(CoverTableViewCell.self, forCellReuseIdentifier: CoverTableViewCell.reuseIdentifier)
        mainTable.register(InputFieldTableViewCell.self, forCellReuseIdentifier: InputFieldTableViewCell.reuseIdentifier)
        mainTable.register(ConfrimTableViewCell.self, forCellReuseIdentifier: ConfrimTableViewCell.reuseIdentifier)
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        mainTable.contentInset.bottom = endFrame?.size.height ?? 0
        keyboardHeight = endFrame?.size.height ?? 0
        
        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }
}
extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 2:
            return 1
        case 1:
            return descriptions.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CoverTableViewCell.reuseIdentifier, for: indexPath) as! CoverTableViewCell
            cell.setup()
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: InputFieldTableViewCell.reuseIdentifier, for: indexPath) as! InputFieldTableViewCell
            let hasNeedChevron = collectionType == .target ? (indexPath.row == descriptions.count - 1) : (indexPath.row == descriptions.count - 1 || indexPath.row == descriptions.count - 2)
            cell.setup(placeholder: placeholders[indexPath.row], description: descriptions[indexPath.row], hasNeedChevron: hasNeedChevron)
            cell.inputTextView.delegate = self
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ConfrimTableViewCell.reuseIdentifier, for: indexPath) as! ConfrimTableViewCell
            cell.setup()
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
extension CollectionViewController: ImagePickerDelegate, CoverDelegate {
    func onTapAddCover(from cell: CoverTableViewCell, with sender: UIView) {
        imagePicker.present(from: sender)
    }
    
    func didSelect(image: UIImage?) {
        let imageView = UIImageView()
        let cell = mainTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! CoverTableViewCell
        cell.coverView.addSubview(imageView)
        imageView.frame = cell.coverView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
    }
}
extension CollectionViewController: TextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        mainTable.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y + (textView.frame.origin.y)), animated: true)
    }
}
