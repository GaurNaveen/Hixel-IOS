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
        let window = app.children(matching: .window).element(boundBy: 0)
        let element = window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2)
        element.swipeLeft()
        element.swipeLeft()
        
        let getStartedButton = app.buttons["Get Started!"]
        getStartedButton.tap()
        app.buttons["back button1"].tap()
        
        let element2 = window.children(matching: .other).element(boundBy: 3).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2)
        element2.swipeLeft()
        element2.swipeLeft()
        getStartedButton.tap()
        
        
       
        
      
        
    }
    
    func UITests()
    {
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
        
        
        let _ = XCUIApplication()
        app.textFields["Username"].tap()
        app.secureTextFields["Password"].tap()
        app.otherElements.containing(.staticText, identifier:"Corp Report").children(matching: .button).element(boundBy: 1).tap()
        
        let _ = app.tabBars
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
        
        let _ = elementsQuery.tables
        tablesQuery2/*@START_MENU_TOKEN@*/.staticTexts["Nasdaq: AAPL"]/*[[".cells.staticTexts[\"Nasdaq: AAPL\"]",".staticTexts[\"Nasdaq: AAPL\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        backButton1Button.tap()
        scrollViewsQuery.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .searchField).element.tap()
        tablesQuery2.staticTexts["Overview"].tap()
        
    }
    
    
    func comparisonTest()
    {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        
        let app2 = XCUIApplication()
        app2.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["INTEL CORP"]/*[[".cells.staticTexts[\"INTEL CORP\"]",".staticTexts[\"INTEL CORP\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Button"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let companiesSelectedElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Companies Selected")
        companiesSelectedElementsQuery.children(matching: .other).element(boundBy: 5)/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let elementsQuery = scrollViewsQuery.otherElements
        let radarChart2DatasetsIntelCorpIntelCorpElement = elementsQuery.otherElements["Radar Chart. 2 datasets. INTEL CORP, INTEL CORP"]
        radarChart2DatasetsIntelCorpIntelCorpElement/*@START_MENU_TOKEN@*/.press(forDuration: 1.0);/*[[".tap()",".press(forDuration: 1.0);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let moreInfoButton = elementsQuery.buttons["More Info"]
        moreInfoButton.tap()
        app.alerts[" Health "].buttons["OK"].tap()
        companiesSelectedElementsQuery.children(matching: .other).element(boundBy: 7)/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeDown()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let collectionViewsQuery = app2.scrollViews.otherElements.collectionViews
        let performanceStaticText = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Performance"]/*[[".cells.staticTexts[\"Performance\"]",".staticTexts[\"Performance\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        performanceStaticText.tap()
        moreInfoButton.tap()
        app.alerts[" Performance "].buttons["OK"].tap()
        performanceStaticText.swipeLeft()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Strength"]/*[[".cells.staticTexts[\"Strength\"]",".staticTexts[\"Strength\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        moreInfoButton.tap()
        app.alerts[" Strength "].buttons["OK"].tap()
        
        let cellsQuery = elementsQuery.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Strength").element.swipeLeft()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Safety"]/*[[".cells.staticTexts[\"Safety\"]",".staticTexts[\"Safety\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        moreInfoButton.tap()
        app.alerts[" Safety "].buttons["OK"].tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Safety").element.swipeLeft()
        cellsQuery.otherElements.containing(.staticText, identifier:"Return").element.tap()
        moreInfoButton.tap()
        app.alerts[" Returns "].buttons["OK"].tap()
        radarChart2DatasetsIntelCorpIntelCorpElement.swipeDown()
        elementsQuery.buttons["Back"].tap()
        
        let app3 = XCUIApplication()
        let collectionViewsQuery2 = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Tesla, Inc."]/*[[".cells.staticTexts[\"Tesla, Inc.\"]",".staticTexts[\"Tesla, Inc.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["INTEL CORP"]/*[[".cells.staticTexts[\"INTEL CORP\"]",".staticTexts[\"INTEL CORP\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Button"].tap()
        app.scrollViews.otherElements.buttons["Back"].tap()
        
    }
    
    
    func profileView()
    {
        
        let app = XCUIApplication()
        let element3 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        let element = element3.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .button).matching(identifier: "Button").element(boundBy: 0).tap()
        element.children(matching: .button).matching(identifier: "Button").element(boundBy: 1).tap()
        element.children(matching: .button).matching(identifier: "Button").element(boundBy: 2).tap()
        
        let element2 = element3.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element
        element2.children(matching: .secureTextField).element(boundBy: 0).tap()
        
        let secureTextField = element2.children(matching: .secureTextField).element(boundBy: 1)
        secureTextField.tap()
        secureTextField.tap()
        
        let secureTextField2 = element2.children(matching: .secureTextField).element(boundBy: 2)
        secureTextField2.tap()
        secureTextField2.tap()
        app.buttons["cancel"].tap()
        app.buttons["Log Out"].tap()
    }
    
    
    func profileViewUITest2()
    {
        
        let app = XCUIApplication()
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 2)
        let element = element2.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .button).matching(identifier: "Button").element(boundBy: 0).tap()
        element.children(matching: .button).matching(identifier: "Button").element(boundBy: 1).tap()
        element.children(matching: .button).matching(identifier: "Button").element(boundBy: 2).tap()
        
        let element3 = element2.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element
        let secureTextField = element3.children(matching: .secureTextField).element(boundBy: 0)
        secureTextField.tap()
        
        let secureTextField2 = element3.children(matching: .secureTextField).element(boundBy: 1)
        secureTextField2.tap()
        secureTextField2.tap()
        secureTextField.tap()
        secureTextField2.tap()
        secureTextField2.tap()
        
        let secureTextField3 = element3.children(matching: .secureTextField).element(boundBy: 2)
        secureTextField3.tap()
        secureTextField3.tap()
        app.buttons["Confirm"].tap()
        app.buttons["cancel"].tap()
        app.buttons["Log Out"].tap()
        
        
    }
    
}
