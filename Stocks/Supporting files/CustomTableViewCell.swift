import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "customCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stockLogo.isHidden = true
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func setupView() {
        mainView.addSubview(stockChange)
        mainView.addSubview(stockPrice)
        mainView.addSubview(stockName)
        mainView.addSubview(stockTicker)
        mainView.addSubview(stockLogo)
        mainView.addSubview(loadingIndicator)
        mainView.addSubview(starImage)
        self.addSubview(mainView)
        setupConstraints()
        stockLogo.isHidden = true
        loadingIndicator.startAnimating()
    }
    
    private let stockTicker: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stockName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stockPrice: UILabel = {
        let label = UILabel()
        label.text = "$131.93"
        label.textColor = .black
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stockChange: UILabel = {
        let label = UILabel()
        label.text = "+$0.12 (1,15%)"
        label.textColor = .customGreenColor
        label.font = UIFont(name: "Montserrat-Bold", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.color = .black
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        return loadingIndicator
    }()
    
    private let stockLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "questionmark.app.fill")
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let starImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "StarFilledGray")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundGrayColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            mainView.heightAnchor.constraint(equalToConstant: 68),
            
            stockLogo.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            stockLogo.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            stockLogo.widthAnchor.constraint(equalToConstant: 52),
            stockLogo.heightAnchor.constraint(equalToConstant: 52),
            
            loadingIndicator.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            loadingIndicator.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 52),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 52),
            
            stockTicker.leadingAnchor.constraint(equalTo: stockLogo.trailingAnchor, constant: 12),
            stockTicker.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 14),
            
            stockName.leadingAnchor.constraint(equalTo: stockLogo.trailingAnchor, constant: 12),
            stockName.topAnchor.constraint(equalTo: stockTicker.bottomAnchor, constant: 4),
            
            starImage.leadingAnchor.constraint(equalTo: stockTicker.trailingAnchor, constant: 6),
            starImage.centerYAnchor.constraint(equalTo: stockTicker.centerYAnchor),
            starImage.widthAnchor.constraint(equalToConstant: 16),
            starImage.heightAnchor.constraint(equalToConstant: 16),
            
            stockPrice.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            stockPrice.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 14),
            
            stockChange.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12),
            stockChange.topAnchor.constraint(equalTo: stockPrice.bottomAnchor, constant: 5)
        ])
    }
    
    func configure(with stockInfo: StockInfo, _ even: Bool) {
        stockTicker.text = stockInfo.ticker
        stockName.text = stockInfo.name
        mainView.backgroundColor = even ? .backgroundGrayColor : .white
        if let url = URL(string: stockInfo.logo) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.stockLogo.image = image
                        self.stockLogo.isHidden = false
                        self.loadingIndicator.stopAnimating()
                        self.loadingIndicator.isHidden = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.stockLogo.image = UIImage(systemName: "questionmark.app.fill")
                        self.stockLogo.isHidden = false
                        self.loadingIndicator.stopAnimating()
                        self.loadingIndicator.isHidden = true
                    }
                }
            }.resume()
        }
    }

}
