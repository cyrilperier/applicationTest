//
//  TableViewController.swift
//  applicationTest
//
//  Created by cyril perier on 24/06/2023.
//

import UIKit

public enum ConstantTableView {
    public static let numberOfSection: Int = 1
    public static let heightOfRow: CGFloat = 300
}

class TableViewController: UITableViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private var imageTableView: UITableView!
    
    // MARK: - Public Var
    
    var imageArraySelected: [PixabayImage] = []
    
    // MARK: - Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBackButton()
    }
    
    // MARK: - Private Function
    
    private func setupBackButton(){
        let backButton = UIBarButtonItem(title: Wordings.back.rawValue, style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupTableView(){
        imageTableView.delegate = self
        imageTableView.dataSource = self
        imageTableView.register(cellType: TableViewCell.self)
    }
    
    @objc private func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return ConstantTableView.numberOfSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArraySelected.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TableViewCell
        cell.setup(url: URL(string: imageArraySelected[indexPath.row].largeImageURL)!)
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConstantTableView.heightOfRow
    }
 
}
