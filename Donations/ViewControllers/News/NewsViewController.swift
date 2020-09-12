//
//  NewsViewController.swift
//  Donations
//
//  Created by Ярослав Стрельников on 12.09.2020.
//

import UIKit

class NewsViewController: BaseViewController {
    let toolbarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "1. Default"))
        imageView.autoSetDimension(.height, toSize: 56)
        return imageView
    }()
    let tabbarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "5 Tabs"))
        imageView.autoSetDimension(.height, toSize: 55)
        return imageView
    }()
    let snippetView: SnippetView
    
    init(snippetView: SnippetView) {
        self.snippetView = snippetView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(toolbarImageView)
        toolbarImageView.autoPinEdge(toSuperviewSafeArea: .top)
        toolbarImageView.autoPinEdge(toSuperviewSafeArea: .leading)
        toolbarImageView.autoPinEdge(toSuperviewSafeArea: .trailing)
        
        view.addSubview(snippetView)
        snippetView.autoPinEdge(.top, to: .bottom, of: toolbarImageView, withOffset: 12)
        snippetView.autoPinEdge(.leading, to: .leading, of: toolbarImageView, withOffset: 12)
        snippetView.autoPinEdge(.trailing, to: .trailing, of: toolbarImageView, withOffset: -12)
        
        view.addSubview(tabbarImageView)
        tabbarImageView.autoPinEdge(toSuperviewSafeArea: .bottom)
        tabbarImageView.autoPinEdge(toSuperviewSafeArea: .leading)
        tabbarImageView.autoPinEdge(toSuperviewSafeArea: .trailing)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
