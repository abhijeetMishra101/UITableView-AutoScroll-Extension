//
//  UITableView+AutoScroll.swift
//  ShowMeCats
//
//  Created by Abhijeet Mishra on 28/04/20.
//  Copyright © 2020 Abhijeet Mishra. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    public func makeSelectedCellVisible(for indexPath: IndexPath){
        if isBottomMostCellBelowScreen(for: indexPath) {
            scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        if isTopMostCellAboveScreen(for: indexPath) {
            scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    private func isTopMostCellAboveScreen(for indexPath: IndexPath) -> Bool {
        let topMostPointOfTableView = CGPoint(x: frame.origin.x + frame.size.width/2, y: frame.origin.y)
        let rect = convert(rectForRow(at: indexPath), to: superview)
        return (rect.origin.y < topMostPointOfTableView.y)
    }
    private func isBottomMostCellBelowScreen(for indexPath: IndexPath) -> Bool {
        let bottomMostPointOfTableView = CGPoint(x: frame.origin.x + frame.size.width/2, y: frame.size.height)
        let rect = convert(rectForRow(at: indexPath), to: superview)
        return ((rect.origin.y + rect.size.height) > bottomMostPointOfTableView.y)
    }
}
