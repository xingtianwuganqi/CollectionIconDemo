//
//  HomeTableController.swift
//  CollectionIconDemo
//
//  Created by jingjun on 2020/10/19.
//  Copyright © 2020 jingjun. All rights reserved.
//

import UIKit

class HomeTableController: UIViewController {
    
    let titles : [String] = ["搜索标签样式","仿推特图片展示"]
    
    lazy var tableview : UITableView = {
        let tableview = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tableview.estimatedRowHeight = 0
        tableview.estimatedSectionFooterHeight = 0
        tableview.estimatedSectionHeaderHeight = 0
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = UIColor.white
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.addSubview(self.tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

    }


}
extension HomeTableController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = ViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = CollectionImgController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
