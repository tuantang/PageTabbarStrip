import UIKit

public class PageTabbarStrip: UIViewController {
    
    @IBOutlet weak public var containerView: UIScrollView!
    @IBOutlet weak public var buttonBarView: PageButtonBarView!
    
    private var pageViewController: PageViewController!
    private lazy var viewControllers: [UIViewController] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        /// create PageViewController
        pageViewController = PageViewController(pages: setViewControllers())
        /// config PageViewController
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    /// set viewcontroller for page tabbar
    func setViewControllers() -> [UIViewController] {
        return []
    }
    /// get all ViewContollers in Page Tabbar
    func getViewControllers() -> [UIViewController] {
        return setViewControllers()
    }
    /// override if needed
    func didChangedPage(at index: Int) {}
    /// get IndicatorInfo from all ViewContollers in Page Tabbar
    fileprivate func getIndicatorInfoProvider(viewControllers: [UIViewController]) -> [IndicatorInfo] {
        var indicatorInfos: [IndicatorInfo] = []
        viewControllers.forEach { vc in
            if let vc = vc as? IndicatorInfoProvider {
                indicatorInfos.append(vc.indicatorInfo())
            }
        }
        return indicatorInfos
    }
}
