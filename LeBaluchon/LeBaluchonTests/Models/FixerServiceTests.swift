//
//  FixerServiceTests.swift
//  LeBaluchonTests
//
//  Created by ayite on 20/11/2020.
//
@testable import LeBaluchon
import XCTest

class FixerServiceTests: XCTestCase {

    func fixerRequest(data : Data?, response: URLResponse?,error : Error? )-> FixerService {
        let httpEngine = HTTPEngine(session: URLSessionFake(data: data, response: response, error: error))
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let fixerService = FixerService(httpClient: httpClient)
        
        return fixerService
    }
    
    //============================================================================================================
    //                                    MARK: - TEST getFixerData FixerService
    //============================================================================================================

    
    func testGetData_WhenUrlSessionThrowAnError_ThenShouldReturnFaillureCallBack() {
        
        let fixerService = fixerRequest(data: nil, response: nil, error: FakeResponseData.error)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        fixerService.getFixerData { (result) in
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
        
        let weatherService = fixerRequest(data: FakeResponseData.incorrectData, response: FakeResponseData.responseKO, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        weatherService.getFixerData { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowABadResponse_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            print(error.description)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUrlSessionThrowNoData_ThenShouldReturnFaillureCallBack() {
        
        let fixerService = fixerRequest(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        fixerService.getFixerData { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowNoData_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            print(error.description)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUrlSessionThrowData_ThenShouldReturnSuccesCallBack() {
        
        let fixerService = fixerRequest(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        fixerService.getFixerData { (result) in
            guard case .success(let fixer) = result else {
                XCTFail("testGetData_WhenUrlSessionThrowData_ThenShouldReturnSuccesCallBack")
                return
            }
            
            XCTAssertNotNil(fixer)
            XCTAssert(fixer.rates["USD"] == 1.185501)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
