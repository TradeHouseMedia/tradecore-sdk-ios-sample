//
//  TestCasesListViewController.swift
//  TradecoreDemoAppSwift
//
//  Created by Olena Stepaniuk on 14.05.2025.
//

import UIKit

fileprivate let cellID = "TestCaseCell"

class TestCasesListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var adFormatPicker: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let testCases = TestCasesManager.allCases
    private var displayedCases = [TestCase]()
    
    private var filterText = ""
    private var currentAdFormat: AdFormat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        displayedCases = testCases
        
        setupPickers()
    }
    
    private func setupPickers() {
        let allAdFormatsAction = UIAction(title: "All") { [weak self] _ in
            self?.currentAdFormat = nil
            self?.filterTestCases()
        }
        
        let adFormatActions = AdFormat.allCases.map { adFormat in
            UIAction(title: adFormat.description) { [weak self] _ in
                self?.currentAdFormat = adFormat
                self?.filterTestCases()
            }
        }
        
        adFormatPicker.setupPullDown(with: [allAdFormatsAction] + adFormatActions)
    }
    
    private func filterTestCases() {
        displayedCases = testCases
            .filter { currentAdFormat == nil ? true : $0.adFormats.contains(currentAdFormat!) }
            .filter { filterText.isEmpty || $0.title.range(of: filterText, options: .caseInsensitive) != nil }
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension TestCasesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = displayedCases[indexPath.row].title
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let testCase = displayedCases[indexPath.row]
        
        let viewController = testCase.configurationClosure()
        viewController.view.backgroundColor = .white
        viewController.title = testCase.title
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension TestCasesListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterText = searchBar.text ?? ""
        filterTestCases()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterText = searchBar.text ?? ""
        filterTestCases()
        searchBar.endEditing(true)
    }
}
