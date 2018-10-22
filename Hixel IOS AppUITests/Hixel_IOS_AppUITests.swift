//
//  Hixel_IOS_AppUITests.swift
//  Hixel IOS AppUITests
//
//  Created by Naveen Gaur on 6/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import XCTest

class Hixel_IOS_AppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        app.scrollViews.otherElements.tables.otherElements.containing(.staticText, identifier:"Overall Summary").children(matching: .button).element.tap()
        app.buttons["Back"].tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Compare"].tap()
        
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Apple Inc"]/*[[".cells.staticTexts[\"Apple Inc\"]",".staticTexts[\"Apple Inc\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Rolls Royce"]/*[[".cells.staticTexts[\"Rolls Royce\"]",".staticTexts[\"Rolls Royce\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["BMW"]/*[[".cells.staticTexts[\"BMW\"]",".staticTexts[\"BMW\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery2.buttons["Clear"].tap()
        tabBarsQuery.buttons["Portfolio"].tap()
                // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app1 = XCUIApplication()
        app.textFields["Username"].tap()
        app.secureTextFields["Password"].tap()
        app.otherElements.containing(.staticText, identifier:"Corp Report").children(matching: .button).element(boundBy: 1).tap()
        
        let tabBarsQuery3 = app.tabBars
        let compareButton = tabBarsQuery.buttons["Compare"]
        compareButton.tap()
        tabBarsQuery.buttons["Settings"].tap()
        compareButton.tap()
        
        let portfolioButton = tabBarsQuery.buttons["Portfolio"]
        portfolioButton.tap()
        compareButton.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["APPLE INC"]/*[[".cells.staticTexts[\"APPLE INC\"]",".staticTexts[\"APPLE INC\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["MICROSOFT CORP"]/*[[".cells.staticTexts[\"MICROSOFT CORP\"]",".staticTexts[\"MICROSOFT CORP\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        _ = app.tables
        tablesQuery.buttons["Compare"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let selectedCompaniesElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Selected Companies:")
        selectedCompaniesElementsQuery.children(matching: .collectionView).element(boundBy: 0).children(matching: .cell).element(boundBy: 1).staticTexts["APPLE INC"].swipeLeft()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Selected Companies:").element.swipeUp()
        selectedCompaniesElementsQuery.children(matching: .other).element(boundBy: 5)/*@START_MENU_TOKEN@*/.press(forDuration: 1.7);/*[[".tap()",".press(forDuration: 1.7);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        selectedCompaniesElementsQuery.children(matching: .collectionView).element(boundBy: 1).children(matching: .cell).element(boundBy: 1).staticTexts["Score"].swipeLeft()
        
        let elementsQuery = scrollViewsQuery.otherElements
        let backButton1Button = elementsQuery.buttons["back button1"]
        backButton1Button.tap()
        tablesQuery.staticTexts["Selected Companies:"].tap()
        portfolioButton.tap()
        
        let tablesQuery4 = elementsQuery.tables
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Nasdaq: AAPL"]/*[[".cells.staticTexts[\"Nasdaq: AAPL\"]",".staticTexts[\"Nasdaq: AAPL\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        backButton1Button.tap()
        scrollViewsQuery.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .searchField).element.tap()
        tablesQuery2.staticTexts["Overview"].tap()
      
        
    }
    
}
