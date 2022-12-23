import UIKit

public class PageButtonBarViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    var settings: Settings!
    var indexPath: IndexPath!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        adjustUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func adjustUI() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func bind(to title: String, at selectedIndex: Int) {
        titleLabel.text = title
        
        let isSelected = indexPath.item == selectedIndex
        titleLabel.font = isSelected ? settings.font.selectedFont : settings.font.unselectedFont
        titleLabel.textColor = isSelected ? settings.color.selectedColor : settings.color.unselectedColor
    }
}

