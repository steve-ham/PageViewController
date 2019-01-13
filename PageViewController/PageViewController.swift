//
//  PageViewController.swift
//  SoftBankMMS
//
//  Created by SEUNG UN HAM on 24/10/2018.
//  Copyright © 2018 Steve Ham. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: NSObjectProtocol {
    func pageViewController(_ pageViewController: PageViewController, didTurnToPageNumber pageNumber: Int)
}

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    weak var pvcDelegate: PageViewControllerDelegate?
    
    private var pageNumber = 0
    private var pageNumberBeforeTransition = 0
    
    lazy var subViewControllers: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        return [firstViewController, secondViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setViewControllers([subViewControllers.first!], direction: .forward, animated: true, completion: nil)
    }
    
    func turnPageBackward() {
        setViewControllers([subViewControllers.first!], direction: .reverse, animated: true, completion: nil)
    }
    
    func turnPageForward() {
        setViewControllers([subViewControllers.last!], direction: .forward, animated: true, completion: nil)
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let index = subViewControllers.index(of: viewController) ?? 0
        
        guard index > 0 else {
            return nil
        }
        
        let beforeIndex = index - 1
        return subViewControllers[beforeIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = subViewControllers.index(of: viewController) ?? 0
        
        guard index < subViewControllers.count - 1 else {
            return nil
        }
        
        let afterIndex = index + 1
        return subViewControllers[afterIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pageNumberBeforeTransition = pageNumber
        pageNumber = subViewControllers.index(of: pendingViewControllers.first!) ?? 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            pvcDelegate?.pageViewController(self, didTurnToPageNumber: pageNumber)
        } else {
            pageNumber = pageNumberBeforeTransition
        }
    }
}
