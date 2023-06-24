//
//  HomePageViewController.swift
//  applicationTest
//
//  Created by cyril perier on 23/06/2023.
//

import UIKit
import Reusable
import RxSwift
import Toast_Swift

class HomePageViewController: UIViewController {

    // MARK: - Public IBOutlet
    @IBOutlet public var validateButton: UIButton!
    
    // MARK: - Private IBOutlet

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var searchTextField: UITextField!
    @IBOutlet private var titleHomePageLabel: UILabel!
    @IBOutlet private var searchButton: UIButton!
    
    // MARK: - Public Var
    
    public var imageArraySelected: [PixabayImage] = []
    
    // MARK: - Private Var
   
    private lazy var myCollectionViewDataSource = MyCollectionViewDataSource(imageArray:imageArray,homePageViewController: self)
    private let disposeBag = DisposeBag()
    private var inputValue: String?
    private var imageArray: [PixabayResponse] = [] {
        didSet {
            myCollectionViewDataSource?.imageArray = imageArray
            DispatchQueue.main.async {
                       self.collectionView.reloadData()
                   }
        }
    }
   
    // MARK: - Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomePage()
        setupCollectionView()
    }
    
    func showButtonValidate(selectedIndexes: Int){
        
        if selectedIndexes >= 2 {
            validateButton.isHidden = false
            validateButton.isEnabled = true
        } else {
            validateButton.isHidden = true
            validateButton.isEnabled = false
        }
        
    }
    
    // MARK: - Private Function
    
    private func setupHomePage() {
        searchButton.setTitle(Wordings.search.rawValue, for: .normal)
        titleHomePageLabel.text = Wordings.titleHomePage.rawValue
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    setupeValidateButton()
        
    }
    
    private func setupeValidateButton(){
        validateButton.isHidden = true
        validateButton.isEnabled = false
        validateButton.setTitle(Wordings.validate.rawValue, for: .normal)
    }
    
    private func setupCollectionView(){
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = myCollectionViewDataSource
        collectionView.delegate = myCollectionViewDataSource
        collectionView.register(cellType: MyCollectionViewCell.self)
        collectionView.reloadData()
        
    }
    
    @objc private func textFieldDidChange(_ searchTextField: UITextField) {
            inputValue = searchTextField.text
        }
    
    private func resetBeforSearch(){
        imageArray = []
        imageArraySelected = []
        myCollectionViewDataSource?.selectedIndexes = []
        setupeValidateButton()
    }
    
    // MARK: - IBAction
    
    @IBAction func searchAction() {
        resetBeforSearch()
        let apiClient = PixabayApiClient()
        apiClient.getPixbayPicture(search: inputValue ?? "")
            .subscribe(
                onNext: { response in
                    
                    self.imageArray.append(response)
                   
                },
                onError: { error in
                    DispatchQueue.main.async {
                        self.view.makeToast(Wordings.errorPixaBay.rawValue, duration: 4.0, position: .bottom)
                           }
                }
            ).disposed(by: disposeBag)
    }
    
    @IBAction func validateAction() {
        let tableViewController = TableViewController(style: .plain)
        tableViewController.imageArraySelected = imageArraySelected
            let navigationController = UINavigationController(rootViewController: tableViewController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
    }

}

