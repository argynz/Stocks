import UIKit

class MainScreenController: UIViewController {
    private var mainScreenView: MainScreenView?
    private var stocks: [StockInfo] = []
    private var favouriteStocks: [StockInfo] = []
    private var isFavouritePage: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreenView = MainScreenView()
        mainScreenView?.setupUI(view)
        setupDelegats()
        loadStocksFromJSON()
        setupTargets()
    }
    
    private func setupDelegats() {
        mainScreenView?.tableView.dataSource = self
        mainScreenView?.tableView.delegate = self
    }
    
    private func setupTargets() {
        mainScreenView?.stocksButton.addTarget(self, action: #selector(stocksButtonPressed), for: .touchUpInside)
        mainScreenView?.favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
    }
    
    // MARK: Load data from json
    private func loadStocksFromJSON() {
        guard let url = Bundle.main.url(forResource: "stockProfiles", withExtension: "json") else {
            print("Stocks JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            stocks = try decoder.decode([StockInfo].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    // MARK: Button Functions
    @objc private func stocksButtonPressed(){
        mainScreenView?.stocksButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 28)
        mainScreenView?.stocksButton.setTitleColor(.black, for: .normal)
        
        mainScreenView?.favouriteButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 18)
        mainScreenView?.favouriteButton.setTitleColor(.customGrayColor, for: .normal)
        
        isFavouritePage = false
        
        mainScreenView?.tableView.reloadData()
    }
    
    @objc private func favouriteButtonPressed(){
        mainScreenView?.favouriteButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 28)
        mainScreenView?.favouriteButton.setTitleColor(.black, for: .normal)
        
        mainScreenView?.stocksButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 18)
        mainScreenView?.stocksButton.setTitleColor(.customGrayColor, for: .normal)
        
        isFavouritePage = true
        
        mainScreenView?.tableView.reloadData()
    }
}

extension MainScreenController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFavouritePage ? favouriteStocks.count : stocks.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("The table view could not dequeue a Cell with identifier: \(CustomTableViewCell.identifier)")
        }
        
        let stockInfo = isFavouritePage ? favouriteStocks[indexPath.row] : stocks[indexPath.row]
        cell.configure(with: stockInfo, indexPath.row % 2 == 0)
        return cell
    }
}
