//
//  RepositoryDetailsViewController.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 07..
//

import WebKit

class RepositoryDetailsViewController: UIViewController {

    // MARK: - Injected properties

    @Injected private var viewModel: RepositoryDetailsViewModel

    // MARK: - Outlets

    @IBOutlet weak var webView: WKWebView!

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
    }

    // MARK: - Setup

    private func setupObservables() {
        viewModel.$urlString
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] string in
                self?.load(with: string)
            }).store(in: &viewModel.subscriptions)
    }

    // MARK: - Functions

    private func load(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }

    // MARK: - Instantiate Self From Stroyboard

    public static func createViewController(_ urlString: String) -> RepositoryDetailsViewController? {
        let storyboard = UIStoryboard(name: "RepositoryDetails", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as? RepositoryDetailsViewController
        viewController?.viewModel.urlString = urlString
        return viewController
    }

}
