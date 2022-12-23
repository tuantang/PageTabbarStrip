import UIKit

public protocol IndicatorInfoProvider {
    func indicatorInfo() -> IndicatorInfo
}

public struct IndicatorInfo {
    let title: String
    let image: UIImage?
    
    public init(title: String, image: UIImage? = nil) {
        self.title = title
        self.image = image
    }
}
