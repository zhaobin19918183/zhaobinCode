
import UIKit

class CSHeaderReusableView: UICollectionReusableView {
    fileprivate let textLabel = UILabel(frame: CGRect.zero)
    
    var text: String? {
        didSet {
            textLabel.text = text
            textLabel.sizeToFit()
            textLabel.left = 10
            textLabel.centerY = frame.height / 2.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel.left = 10
        textLabel.centerY = frame.height / 2.0
        textLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(textLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.left = 10
        textLabel.centerY = frame.height / 2.0
    }
}
