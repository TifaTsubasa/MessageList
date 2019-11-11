//
//  ViewController.swift
//  NewProject
//
//  Created by tsuf on 2019/11/8.
//  Copyright © 2019 upmer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let activityHeight: CGFloat = 34
  private var currentLoadCount: Int = 0
  
  private weak var tableView: UITableView!
  
  var messages = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    renderTableView()
    
    let addBtn = UIButton(type: .contactAdd)
    addBtn.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    view.addSubview(addBtn)
    addBtn.frame = CGRect(x: 20, y: 100, width: 40, height: 40)
    
    let scrollBtn = UIButton(type: .infoLight)
    scrollBtn.addTarget(self, action: #selector(scrollToTop), for: .touchUpInside)
    view.addSubview(scrollBtn)
    scrollBtn.frame = CGRect(x: view.bounds.width - 60, y: 100, width: 40, height: 40)

    for i in 0...20 {
      messages.append(String(i))
    }
    messages.reverse()
    tableView.reloadData()
//    scrollToBottom()
  }
  
  private func addOldMessage() {
    var array = [String]()
    for i in 1...10 {
      array.append("hello" * i)
    }
    messages.append(contentsOf: array)
  }
  
  @objc private func sendMessage() {
    messages.insert("new message", at: 0)
    tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
  }

  private func renderTableView() {
    let tableView = UITableView(frame: view.bounds, style: .plain)
    self.tableView = tableView
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    view.addSubview(tableView)
    let activity = UIActivityIndicatorView()
    activity.frame = CGRect(x: 0, y: 0, width: 0, height: activityHeight)
    activity.startAnimating()
    tableView.tableFooterView = activity
    tableView.estimatedRowHeight = 72
    tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
    view.addSubview(tableView)
  }
  
  private func loadOlderMessages() {
    var array = [String]()
    for i in 1...10 {
      array.append("older" * i)
    }
    array.reverse()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.messages.append(contentsOf: array)
      self.tableView.reloadData()
    }
  }
  
  @objc private func scrollToTop() {
    let statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    tableView.setContentOffset(CGPoint(x: 0, y: 0 - statusBarHeight), animated: false)
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let height = scrollView.contentSize.height - scrollView.bounds.height
    print(scrollView.contentOffset.y - height, activityHeight)
    guard currentLoadCount != messages.count else { return }
    if (scrollView.contentOffset.y - height) >= 0 {
      currentLoadCount = messages.count
      loadOlderMessages()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell
    cell.contentLabel.text = messages[indexPath.row]
    return cell
  }
}

extension String {
  static func *(lhs: String, rhs: Int) -> String {
    if rhs <= 0 {
      return lhs
    }
    var string = ""
    for _ in 0..<rhs {
      string += lhs
    }
    return string
  }
}
