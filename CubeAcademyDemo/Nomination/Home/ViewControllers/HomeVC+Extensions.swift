import Foundation

import UIKit

//MARK: UITableView Delegate and DataSource

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.nominations?.count ?? 0
        if count > 0 {
            self.tableView.isHidden = false
            self.noNominationView.isHidden = true
            return count
        }
        self.tableView.isHidden = true
        self.noNominationView.isHidden = false
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSLocalizedString("nomination_cell", comment: ""), for: indexPath) as? NominationTableViewCell else {
            fatalError()
        }
        
        cell.nominationCellModel = viewModel?.nominations?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87.0
    }
}

// Adding dependency for View Controller
extension HomeVC {
    
    func generateNominationViewModel() -> NominationDataViewModel {
        let viewModel = NominationViewModel(useCase: generateNominationUseCase())
        return viewModel
    }
    
    func generateNominationUseCase() -> NominationUseCaseModel {
        let networkManager = NetworkManager()
        let useCase = NominationUseCase(networkManager:networkManager)
        return useCase
    }
}

// Success Handling
extension HomeVC: CallbackStatus {
    
    func handleSuccess(_ type: APIType) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // Failure Handling
    func handleFailure(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: NSLocalizedString("alert", comment: ""), message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.tableView.isHidden = true
            self.noNominationView.isHidden = false
        }
    }
}
