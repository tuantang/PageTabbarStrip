import UIKit

public class PageButtonBarView: UIView {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        return collectionView
    }()
    
    private var indicatorsInfo: [IndicatorInfo] = []
    var settings: Settings!
    var selectedIndex: Int = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        adjustUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension PageButtonBarView {
    private func adjustUI() {
        /// add collection view to menu view
        addSubview(collectionView)
        /// autolayout for collection view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        /// set delegate for collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        /// Register cell
        collectionView.register(PageButtonBarViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

extension PageButtonBarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return indicatorsInfo.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PageButtonBarViewCell
        cell.settings = settings
        cell.indexPath = indexPath
        cell.bind(to: indicatorsInfo[indexPath.item].title, at: selectedIndex)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = indicatorsInfo[indexPath.item].title.size(of: settings.font.selectedFont)
        return CGSize(width: size.width + 1, height: size.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

