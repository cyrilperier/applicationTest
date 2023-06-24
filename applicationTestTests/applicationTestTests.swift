//
//  applicationTestTests.swift
//  applicationTestTests
//
//  Created by cyril perier on 24/06/2023.
//

import XCTest
@testable import applicationTest

class HomePageViewControllerTests: XCTestCase {
    
    var sut: HomePageViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "HomePageViewController", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testButtonAppearance() {
        // Check that the validation button is initially hidden and disabled
        XCTAssertTrue(sut.validateButton.isHidden)
        XCTAssertFalse(sut.validateButton.isEnabled)
        
        // Simulate the selection of 2 elements
        sut.showButtonValidate(selectedIndexes: 2)
        
        // Check that the validation button is now visible and activated
        XCTAssertFalse(sut.validateButton.isHidden)
        XCTAssertTrue(sut.validateButton.isEnabled)
        
        // Simulate the selection of less than 2 items
        sut.showButtonValidate(selectedIndexes: 1)
        
        // Check that the validation button is now hidden and disabled
        XCTAssertTrue(sut.validateButton.isHidden)
        XCTAssertFalse(sut.validateButton.isEnabled)
    }
}
