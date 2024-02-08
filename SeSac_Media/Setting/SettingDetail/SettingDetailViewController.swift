//
//  SettingDetailViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 2/9/24.
//

import UIKit

final class SettingDetailViewController: BaseViewController {
    
    let mainView = SettingDetailView()
    
    var titleText: String?
    var contentText: String?
    
    var contentSpace: ((String) -> Void)?
    
    override func loadView() {
        self.view = mainView
        
        navigationItem.titleView = mainView.navTitle
        
        mainView.confirmBtn.addTarget(self, action: #selector(didConfirmBtnTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func didConfirmBtnTapped() {
        guard let text = mainView.inputTextField.text else { return }
        contentSpace?(text)
        
        navigationController?.popViewController(animated: true)
    }
}
