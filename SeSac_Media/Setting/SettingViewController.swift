//
//  SettingViewController.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit

final class SettingViewController: BaseViewController {

    let mainView = SettingView()
    
    var contentList = Array(repeating: "", count: Setting.allCases.count)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = mainView.navTitle
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        mainView.profileEditBtn.addTarget(self, action: #selector(didProfileEditBtnTapped), for: .touchUpInside)
    }
    
}

extension SettingViewController {
    
    @objc private func didProfileEditBtnTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: "프로필 이미지 수정", style: .default) { action in
            let vc = ProfileSearchViewController()
            
            vc.imageSpace = { image in
                let url = URL(string: image)
                self.mainView.profileImageView.kf.setImage(with: url)
            }
            self.transition(viewController: vc, style: .push)
        }
        
        let delete = UIAlertAction(title: "프로필 이미지 삭제", style: .default) { action in
            self.mainView.profileImageView.image = UIImage(systemName: "person")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        
        let row = indexPath.row
        cell.titleLabel.text = Setting.allCases[row].rawValue
        cell.contentLabel.text = contentList[row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SettingDetailViewController()
        
        let string = Setting.allCases[indexPath.row].rawValue
        vc.mainView.navTitle.text = "\(string) 수정"
        vc.mainView.titleLabel.text = string
        vc.mainView.inputTextField.setPlaceholder(placeholder: "\(string)을 입력해주세요", color: .white)
        
        let selectedIndexPath = indexPath
        
        vc.contentSpace = { text in
            self.contentList[selectedIndexPath.row] = text
            tableView.reloadData()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
