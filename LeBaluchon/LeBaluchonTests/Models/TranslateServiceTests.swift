//
//  TranslateServiceTests.swift
//  LeBaluchonTests
//
//  Created by ayite on 20/11/2020.
//
@testable import LeBaluchon
import XCTest

class TranslateServiceTests: XCTestCase {

    func translateRequest(data : Data?, response: URLResponse?,error : Error? )-> TranslateService {
        let httpEngine = HTTPEngine(session: URLSessionFake(data: data, response: response, error: error))
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let translateService = TranslateService(httpClient: httpClient)
        
        return translateService
    }
    
    //============================================================================================================
    //                                    MARK: - TEST getTranslationData TranslateService
    //============================================================================================================

    
    func testGetData_WhenUrlSessionThrowAnError_ThenShouldReturnFaillureCallBack() {
        
        let translateService = translateRequest(data: nil, response: nil, error: FakeResponseData.error)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        translateService.getTranslationData { (result) in
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
        translateService.getTranslationData { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowAnBadResponse_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            print(error.description)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUrlSessionThrowIncorrectData_ThenShouldReturnFaillureCallBack() {
        
        let translateService = translateRequest(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        translateService.getTranslationData { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowAnNoData_ThenShouldReturnFaillureCallBack")
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
        translateService.getTranslationData { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowAnNoData_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUrlSessionThrowData_ThenShouldReturnSuccesCallBack() {
        
        let translateService = translateRequest(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        translateService.getTranslationData { (result) in
            guard case .success(let translate) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowData_ThenShouldReturnSuccesCallBack")
                return
            }
            
            XCTAssertNotNil(translate)
            XCTAssert(translate.data.translations[0].translatedText == "France is a very beautiful country")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
