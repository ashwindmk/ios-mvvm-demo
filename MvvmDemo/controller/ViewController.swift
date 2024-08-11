import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    private var models = [Person]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(PersonFollowingTableViewCell.self, forCellReuseIdentifier: PersonFollowingTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load model
        configureModels()
        
        // Add table view
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        let names = ["Alice", "Bob", "Clara", "Daniel", "Eric", "Frank"]
        for name in names {
            models.append(Person(name: name))
        }
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("VC: bind")
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PersonFollowingTableViewCell.identifier,
            for: indexPath
        ) as? PersonFollowingTableViewCell else {
            return UITableViewCell()
        }
        
        let model = models[indexPath.row]
        //cell.textLabel?.text = model.name
        cell.configure(with: PersonFollowingViewModel(with: model))
        cell.delegate = self
        return cell
    }
}

// MARK: - Cell click listener
extension ViewController : PersonFollowingTableViewCellDelegate {
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingViewModel) {
        var newViewModel = viewModel
        newViewModel.isFollowing = !viewModel.isFollowing
        cell.prepareForReuse()
        cell.configure(with: newViewModel)
    }
}
