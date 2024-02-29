//
//  CostraCoffeeTests.swift
//  CostraCoffeeTests
//
//  Created by Nafiz on 1/24/24.
//

import XCTest
@testable import CostraCoffee

final class CostraCoffeeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFindCoffee() throws {
        let model: CoffeeModel = CoffeeModel()
        model.findCoffeeById(id: "1")
        model.$selectedItem.sink(receiveValue: { print("ViewModel updated, new value: \($0)") })
        model.objectWillChange.sink(receiveValue: { print("ViewModel updated: \($0)")})
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
