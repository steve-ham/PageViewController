//
//  ViewController.swift
//  PageViewController
//
//  Created by SEUNG UN HAM on 13/01/2019.
//  Copyright © 2019 BrainTools. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController, PageViewControllerDelegate, UIScrollViewDelegate {
    
    static let identifier = "\(RootViewController.self)"
    
    @IBOutlet private weak var buttonsStackView: UIStackView!
    @IBOutlet private weak var firstLineView: UIView!
    @IBOutlet private weak var secondLineView: UIView!
    @IBOutlet private weak var thirdLineView: UIView!
    
    private enum SelectedTab: Int {
        case first
        case second
        case third
    }
    private var selectedTab: SelectedTab = .first
    
    private lazy var pageViewController: PageViewController = {
        let pageViewController = children.first! as! PageViewController
        pageViewController.pvcDelegate = self
        let scrollView = pageViewController.view.subviews.first as! UIScrollView
        scrollView.delegate = self
        return pageViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.turnPage(to: 0, direction: .reverse)
    }
    
    // MARK: - Actions
    
    @IBAction private func clickFirstButton(_ firstButton: UIButton) {
        selectedTab = .first
        updateUI()
        pageViewController.turnPage(to: 0, direction: .reverse)
    }
    
    @IBAction private func clickSecondButton(_ secondButton: UIButton) {
        selectedTab = .second
        updateUI()
        pageViewController.turnPage(to: 1, direction: selectedTab == .first ? .forward : .reverse)
    }
    
    @IBAction private func clickThirdButton(_ thirdButton: UIButton) {
        selectedTab = .third
        updateUI()
        pageViewController.turnPage(to: 2, direction: .forward)
        
    }
    // MARK: - PageViewControllerDelegate
    
    func pageViewController(_ pageViewController: PageViewController, didTurnToPageNumber pageNumber: Int) {
        buttonsStackView.isUserInteractionEnabled = true
        if let tab = SelectedTab(rawValue: pageNumber) {
            selectedTab = tab
            updateUI()
        }
    }
    
    private func updateUI() {
        switch selectedTab {
        case .first:
            firstLineView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            secondLineView.backgroundColor = .clear
            thirdLineView.backgroundColor = .clear
        case .second:
            firstLineView.backgroundColor = .clear
            secondLineView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            thirdLineView.backgroundColor = .clear
        case .third:
            firstLineView.backgroundColor = .clear
            secondLineView.backgroundColor = .clear
            thirdLineView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        buttonsStackView.isUserInteractionEnabled = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        buttonsStackView.isUserInteractionEnabled = true
    }
    
}
