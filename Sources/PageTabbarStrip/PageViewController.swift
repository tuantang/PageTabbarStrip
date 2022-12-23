import UIKit

class PageViewController: UIPageViewController {
    
    var pages: [UIViewController] = []
    var currentIndex: Int = 0
    var previousIndex: Int = 0
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(pages: [UIViewController]) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.pages = pages
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// config delegate scrollview
        view.backgroundColor = .clear
        view.subviews.forEach { view in
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
        
        /// config delegate UIPageViewController
        delegate = self
        dataSource = self
    }
    
    func setPage(at index: Int) {
        if index > previousIndex {
            self.setViewControllers([self.pages[index]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        } else {
            self.setViewControllers([self.pages[index]], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: nil)
        }
        previousIndex = currentIndex
        currentIndex = index
    }
}

extension PageViewController: UIScrollViewDelegate {
    
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = self.pages.firstIndex(of: viewController)!
        let previousIndex = abs((currentIndex - 1) % self.pages.count)
        return currentIndex == 0 ? nil :self.pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = self.pages.firstIndex(of: viewController)!
        let nextIndex = abs((currentIndex + 1) % self.pages.count)
        return currentIndex == self.pages.count - 1 ? nil : self.pages[nextIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let viewControllerIndex = pages.firstIndex(of: pageViewController.viewControllers!.first!) else { return }
        previousIndex = currentIndex
        currentIndex = viewControllerIndex
    }
    
}

