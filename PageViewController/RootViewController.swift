//
//  ViewController.swift
//  PageViewController
//
//  Created by SEUNG UN HAM on 13/01/2019.
//  Copyright © 2019 BrainTools. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController, PageViewControllerDelegate {
    
    static let identifier = "\(RootViewController.self)"
    
    @IBOutlet weak var firstLineView: UIView!
    @IBOutlet weak var secondLineView: UIView!
    
    private enum SelectedTab {
        case first
        case second
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pageViewController = children.first! as! PageViewController
        pageViewController.pvcDelegate = self
    }
    
    // MARK: - Actions
    
    @IBAction private func clickFirstButton(_ firstButton: UIButton) {
        updateTabUI(selectedTab: .first)
        let pageViewController = children.first! as! PageViewController
        pageViewController.turnPageBackward()
    }
    
    @IBAction private func clickSecondButton(_ secondButton: UIButton) {
        updateTabUI(selectedTab: .second)
        let pageViewController = children.first! as! PageViewController
        pageViewController.turnPageForward()
    }
    
    // MARK: - PageViewControllerDelegate
    
    func pageViewController(_ pageViewController: PageViewController, didTurnToPageNumber pageNumber: Int) {
        switch pageNumber {
        case 0:
            updateTabUI(selectedTab: .first)
        case 1:
            updateTabUI(selectedTab: .second)
        default:
            print("didTurnToPageNumber \(pageNumber)")
        }
    }
    
    private func updateTabUI(selectedTab: SelectedTab) {
        switch selectedTab {
        case .first:
            firstLineView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            secondLineView.backgroundColor = .clear
        case .second:
            firstLineView.backgroundColor = .clear
            secondLineView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }
    
}
