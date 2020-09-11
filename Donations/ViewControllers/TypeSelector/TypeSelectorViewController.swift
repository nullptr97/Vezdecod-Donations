//
//  TypeSelectorViewController.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import UIKit
import Material

enum CollectionType: String {
    case target = "Целевой сбор"
    case regular = "Регулярный сбор"
    
    func getDescriptions() -> [String] {
        var standartDescriptions = [
            "Название сбора",
            "Сумма, ₽",
            "Цель",
            "Описание",
            "Куда получать деньги"]
        switch self {
        case .target:
            return standartDescriptions
        case .regular:
            standartDescriptions.append("Автор")
            return standartDescriptions
        }
    }
    
    func getPlaceholders() -> [String] {
        var standartPlaceholders = [
            "Название сбора",
            "Сколько нужно в месяц?",
            "Например, поддержка приюта",
            "На что пойдут деньги и как они кому-то помогут?",
            "Счёт VK Pay · 1234"]
        switch self {
        case .target:
            return standartPlaceholders
        case .regular:
            standartPlaceholders.append("Матвей Правосудов")
            return standartPlaceholders
        }
    }
}

class TypeSelectorViewController: BaseViewController {
    lazy var targetBannerView: IconBannerView = IconBannerView()
    lazy var regularBannerView: IconBannerView = IconBannerView()
    let containerView: View = View()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar(title: "Тип сбора", isNeedBackButton: true)
        
        view.addSubview(containerView)
        containerView.autoPinEdge(.leading, to: .leading, of: view)
        containerView.autoPinEdge(.trailing, to: .trailing, of: view)
        containerView.autoAlignAxis(toSuperviewAxis: .horizontal)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        setupBanners()
        setupTargerBanner()
        setupRegularBanner()
    }
    
    override func setupToolbar(title: String, isNeedBackButton: Bool) {
        super.setupToolbar(title: title, isNeedBackButton: isNeedBackButton)
        toolbar.title = title
    }
    
    func setupBanners() {
        containerView.addSubview(targetBannerView)
        containerView.addSubview(regularBannerView)

        targetBannerView.autoPinEdge(.top, to: .top, of: containerView, withOffset: 12)
        targetBannerView.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 12)
        targetBannerView.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -12)
        
        regularBannerView.autoPinEdge(.top, to: .bottom, of: targetBannerView, withOffset: 12)
        regularBannerView.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 12)
        regularBannerView.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -12)
        regularBannerView.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: -12)
    }
    
    func setupTargerBanner() {
        targetBannerView.bannerTitle = "Целевой сбор"
        targetBannerView.bannerDescription = "Когда есть определённая цель"
        targetBannerView.bannerImage = "target_outline_28"
        targetBannerView.isUserInteractionEnabled = true
        
        targetBannerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPerformToTargetCollection)))
    }
    
    func setupRegularBanner() {
        regularBannerView.bannerTitle = "Регулярный сбор"
        regularBannerView.bannerDescription = "Если помощь нужна ежемесячно"
        regularBannerView.bannerImage = "calendar_outline_28"
        regularBannerView.isUserInteractionEnabled = true
        
        regularBannerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPerformToRegularCollection)))
    }
    
    @objc func onPerformToTargetCollection() {
        navigationController?.pushViewController(CollectionViewController(type: .target), animated: true)
    }

    @objc func onPerformToRegularCollection() {
        navigationController?.pushViewController(CollectionViewController(type: .regular), animated: true)
    }
}
