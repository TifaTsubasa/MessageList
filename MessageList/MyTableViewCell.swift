//
//  MyTableViewCell.swift
//  NewProject
//
//  Created by tsuf on 2019/11/8.
//  Copyright © 2019 upmer. All rights reserved.
//

import UIKit
import FlashUI
import SnapKit

class MyTableViewCell: UITableViewCell {
  
  weak var contentLabel: UILabel!

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    render()
    contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
    accessoryView?.transform = CGAffineTransform(scaleX: 1, y: -1)
  }

  override func willTransition(to state: UITableViewCell.StateMask) {
    super.willTransition(to: state)
  }
  
  override func didTransition(to state: UITableViewCell.StateMask) {
    super.didTransition(to: state)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    render()
    accessoryType = .detailButton
  }
  
  private func render() {
    contentLabel = UILabel()
      .font(UIFont.boldSystemFont(ofSize: 14)).textColor(.darkText)
      .numberOfLines(0).textAlignment(.center).superview(contentView)
    contentLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(16)
      $0.left.equalToSuperview().offset(16)
      $0.right.equalToSuperview().offset(-32)
      $0.bottom.equalToSuperview().offset(-16)
    }
  }
}
