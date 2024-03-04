import UIKit
import Const

class MainScreenView{
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var searchView = CustomSearchView()
    
    private var buttonsView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var stocksButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stocks", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 28)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var favouriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Favourite", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 18)
        button.setTitleColor(.customGrayColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupSubviews(_ containerView: UIView) {
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(searchView)
        stackView.addArrangedSubview(buttonsView)
        stackView.addArrangedSubview(tableView)
        buttonsView.addSubview(stocksButton)
        buttonsView.addSubview(favouriteButton)
    }
    
    private func setupConstraints(_ containerView: UIView) {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            
            searchView.heightAnchor.constraint(equalToConstant: 78),
            
            buttonsView.heightAnchor.constraint(equalToConstant: 60),
             
            tableView.topAnchor.constraint(equalTo: buttonsView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            stocksButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor, constant: 20),
            stocksButton.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: -4),
            
            favouriteButton.leadingAnchor.constraint(equalTo: stocksButton.trailingAnchor, constant: 20),
            favouriteButton.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: -4),
        ])
    }
    
    func setupUI(_ containerView: UIView) {
        containerView.backgroundColor = .white
        setupSubviews(containerView)
        setupConstraints(containerView)
    }
}
