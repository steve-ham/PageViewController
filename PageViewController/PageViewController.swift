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

final class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    weak var pvcDelegate: PageViewControllerDelegate?
    
    private var pageNumber = 0
    
    private lazy var subViewControllers: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")
        return [firstViewController, secondViewController, thirdViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setViewControllers([subViewControllers[1]], direction: .forward, animated: true, completion: nil)
    }
    
    func turnPage(to pageNumber: Int, direction: UIPageViewController.NavigationDirection) {
        self.pageNumber = pageNumber
        setViewControllers([subViewControllers[pageNumber]], direction: direction, animated: true, completion: nil)
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return pageNumber - 1 >= 0 ? subViewControllers[pageNumber - 1] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return pageNumber + 1 <= 2 ? subViewControllers[pageNumber + 1] : nil
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed, let currentViewController = viewControllers?.first,
            let index = subViewControllers.firstIndex(of: currentViewController) {
            pageNumber = index
            pvcDelegate?.pageViewController(self, didTurnToPageNumber: pageNumber)
        }
    }
}
