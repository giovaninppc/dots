//
//  BookPageController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 11/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

final class BookPageController: UIPageViewController {
    private let orderedViewControllers: [UIViewController] = [
        AllLevelViewController().set(numberOfPages: 2, position: 0, style: .light, place: .vertical),
        WorldPageViewController(model: .tutorial).set(numberOfPages: 2, position: 1, style: .light, place: .vertical)
    ]

    init() {
        super.init(transitionStyle: .pageCurl, navigationOrientation: .vertical, options: nil)
        modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        guard let firstViewController = orderedViewControllers.first else { return }
        setViewControllers(
            [firstViewController],
            direction: .forward,
            animated: false,
            completion: nil
        )
    }
}

extension BookPageController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return orderedViewControllers.last }
        guard orderedViewControllers.count > previousIndex else { return nil }
        return orderedViewControllers[previousIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        guard orderedViewControllersCount != nextIndex else { return orderedViewControllers.first }

        guard orderedViewControllersCount > nextIndex else { return nil }
        return orderedViewControllers[nextIndex]
    }

    func presentationCount(for: UIPageViewController) -> Int {
        orderedViewControllers.count
    }

    func presentationIndex(for: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController) else {
                return 0
        }

        return firstViewControllerIndex
    }
}
