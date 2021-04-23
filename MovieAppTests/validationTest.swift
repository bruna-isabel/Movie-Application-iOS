//
//  validationTest.swift
//  MovieAppTests
//
//  Created by Bruna Coimbra on 23/04/2021.
//
@testable import MovieApp
import XCTest

class validationTest: XCTestCase {
    
    var fieldValidation: Utilities!

    override func setUp() {
        
        super.setUp()
        fieldValidation =  Utilities()
    }
    
    override func tearDown() {
        super.tearDown()
        fieldValidation = nil
    }
    
    func test_is_valid_password() throws {
        XCTAssert( fieldValidation.passwordValidation("password123!"))
        XCTAssertFalse( fieldValidation.passwordValidation("pass"))
        XCTAssertFalse( fieldValidation.passwordValidation("!!%&$&/"))
    }
    
    func test_is_valid_email() throws {
        XCTAssert( fieldValidation.emailValidation("john@demo.com"))
        XCTAssertFalse( fieldValidation.emailValidation("john.com"))
        XCTAssertFalse( fieldValidation.emailValidation("john@com"))
    }
    

}
