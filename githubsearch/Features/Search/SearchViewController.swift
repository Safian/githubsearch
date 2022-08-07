//
//  SearchViewController.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Injected properties

    @Injected private var viewModel: SearchViewModel
    @Injected private var navigationManager: NavigationManager

    // MARK: - Outlets

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
    }

    // MARK: - Setup functions

    private func setupObservables() {
        viewModel.$cellDatas
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] data in
                self?.reload()
            }).store(in: &viewModel.subscriptions)

        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] error in
                guard let error = error else { return }
                self?.showError(with: error)
            }).store(in: &viewModel.subscriptions)

        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
            .sink(receiveValue: { [weak self] result in
                if let textField = result.object as? UITextField, let text = textField.text {
                    self?.viewModel.searchText = text
                }
            }).store(in: &viewModel.subscriptions)
    }

    // MARK: - Functions

    private func showError(with error: String) {
        let alert = UIAlertController(title: "Error",
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close",
                                      style: .default,
                                      handler: nil))
        present(alert,
                animated: true,
                completion: nil)

    }

    private func reload() {
        tableView.reloadData()
        progressIndicator.isHidden = true
    }

    private func loadNextPage() {
        progressIndicator.isHidden = false
        progressIndicator.startAnimating()
        viewModel.loadNextPage()
    }
}


// MARK: - TableViewDataSource extension

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellDatas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.setup(with: viewModel.cellDatas[indexPath.row])
        return cell
    }
}

// MARK: - TableViewDelegate extension

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = viewModel.cellDatas[indexPath.row].repositoryUrl else { return }
        navigationManager.navigateToRepositoryDetail(with: urlString, navigationController: navigationController)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == tableView,
            scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height,
            !viewModel.isLastPage
        else { return }

        loadNextPage()
    }
}

