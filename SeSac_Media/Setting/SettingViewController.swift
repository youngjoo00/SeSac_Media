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
            // 처음에는 셀에 직접 접근해서 text 를 바꾸려고 했는데, 고정관념을 깨고 해당 셀이 가진 contentList에 접근해서 셀을 조작하면 되는것이었다..
            self.contentList[selectedIndexPath.row] = text
            tableView.reloadData()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
