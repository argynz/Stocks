import UIKit

class CustomSearchView: UIView {
    private let mainView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        let attribute: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.black, .font: UIFont(name: "Montserrat-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 16)]
        textField.attributedPlaceholder = NSAttributedString(string: "Find company or ticker", attributes: attribute)
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(mainView)
        mainView.addSubview(searchIconImageView)
        mainView.addSubview(searchTextField)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            searchIconImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            searchIconImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            searchIconImageView.widthAnchor.constraint(equalToConstant: 24),
            searchIconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchIconImageView.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            searchTextField.topAnchor.constraint(equalTo: mainView.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
}
