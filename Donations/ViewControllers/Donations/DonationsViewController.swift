//
//  ViewController.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import UIKit
import Material

class DonationsViewController: BaseViewController {
    lazy var placeholderView: PlaceholderView = PlaceholderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar(title: "Пожертвования", isNeedBackButton: false)
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(placeholderView)
        placeholderView.autoPinEdge(.leading, to: .leading, of: view)
        placeholderView.autoPinEdge(.trailing, to: .trailing, of: view)
        
        placeholderView.autoAlignAxis(toSuperviewAxis: .horizontal)
        placeholderView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        placeholderView.placeholderLabelTitle = """
            У Вас пока нет сборов.
            Начните доброе дело.
            """
        placeholderView.placeholderButtonTitle = "Создать сбор"
        placeholderView.createCollectionButton.addTarget(self, action: #selector(performToTypeSelector(_:)), for: .touchUpInside)
    }
    
    override func setupToolbar(title: String, isNeedBackButton: Bool) {
        super.setupToolbar(title: title, isNeedBackButton: isNeedBackButton)
        toolbar.title = title
    }
    
    @objc func performToTypeSelector(_ sender: FlatButton) {
        navigationController?.pushViewController(TypeSelectorViewController(), animated: true)
    }
}

