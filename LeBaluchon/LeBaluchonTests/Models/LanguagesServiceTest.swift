//
//  LanguagesServiceTest.swift
//  LeBaluchonTests
//
//  Created by ayite on 30/11/2020.
//

import Foundation


@testable import LeBaluchon
import XCTest

class LanguagesServiceTests: XCTestCase {

    func translateRequest(data : Data?, response: URLResponse?,error : Error? )-> TranslateService {
        let httpEngine = HTTPEngine(session: URLSessionFake(data: data, response: response, error: error))
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let translateService = TranslateService(httpClient: httpClient)
        
        return translateService
    }
    
    //============================================================================================================
    //                                    MARK: - TEST getLanguagesData TranslateService
    //============================================================================================================

    
    func testGetData_WhenUrlSessionThrowAnError_ThenShouldReturnFaillureCallBack() {
        
        let translateService = translateRequest(data: nil, response: nil, error: FakeResponseData.error)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        translateService.getLanguagesData { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowAnError_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUrlSessionThrowABadResponse_ThenShouldReturnFaillureCallBack() {
        
        let translateService = translateRequest(data: FakeResponseData.incorrectData, response: FakeResponseData.responseKO, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        translateService.getLanguagesData { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowABadResponse_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUrlSessionThrowIncorrectData_ThenShouldReturnFaillureCallBack() {
        
        let translateService = translateRequest(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        translateService.getLanguagesData { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowNoData_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUrlSessionThrowNoData_ThenShouldReturnFaillureCallBack() {
        
        let translateService = translateRequest(data: nil, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        translateService.getLanguagesData { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowNoData_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUrlSessionThrowData_ThenShouldReturnSuccesCallBack() {
        
        let translateService = translateRequest(data: FakeResponseData.languagesCorrectData, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        translateService.getLanguagesData { (result) in
            guard case .success(let languages) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowData_ThenShouldReturnSuccesCallBack")
                return
            }
            
            XCTAssertNotNil(languages)
            XCTAssert(languages.data.languages[0].name == "Afrikaans")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
