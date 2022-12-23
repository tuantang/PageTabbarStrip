import UIKit

struct Settings {
    struct Font {
        public lazy var selectedFont: UIFont = .boldSystemFont(ofSize: 14)
        public lazy var unselectedFont: UIFont = .systemFont(ofSize: 14)
    }
    
    struct Color {
        public lazy var selectedColor: UIColor = .black
        public lazy var unselectedColor: UIColor = .lightGray
    }
    
    public lazy var showMenu: Bool = true
    
    public lazy var font = Font()
    
    public lazy var color = Color()
}
