//
//  WeatherServiceTests.swift
//  LeBaluchonTests
//
//  Created by ayite on 18/11/2020.
//

@testable import LeBaluchon
import XCTest

class WeatherServiceTests: XCTestCase {
    
     private func weatherRequest(data : Data?, response: URLResponse?,error : Error? )-> WeatherService {
        let httpEngine = HTTPEngine(session: URLSessionFake(data: data, response: response, error: error))
        let httpClient = HTTPClient(httpEngine: httpEngine)
        let weatherService = WeatherService(httpClient: httpClient)
        
        return weatherService
    }
    
    //============================================================================================================
    //                                      MARK: - TEST getDataCity WeatherService
    //============================================================================================================

    func testGetDataCityOne_WhenUrlSessionThrowAnError_ThenShouldReturnFaillureCallBack() {
        
        let weatherService = weatherRequest(data: nil, response: nil, error: FakeResponseData.error)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        weatherService.getDataCity { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetDataCity_WhenUrlSessionThrowAnError_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDataCity_WhenUrlSessionThrowABadResponse_ThenShouldReturnFaillureCallBack() {
        
        let weatherService = weatherRequest(data: FakeResponseData.incorrectData, response: FakeResponseData.responseKO, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        weatherService.getDataCity { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetDataCity_WhenUrlSessionThrowAnBadResponse_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDataCity_WhenUrlSessionThrowIncorrectData_ThenShouldReturnFaillureCallBack() {
        
        let weatherService = weatherRequest(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        weatherService.getDataCity { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetDataCity_WhenUrlSessionThrowAnNoData_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDataCity_WhenUrlSessionThrowNoData_ThenShouldReturnFaillureCallBack() {
        
        let weatherService = weatherRequest(data: nil, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        weatherService.getDataCity { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetDataCity_WhenUrlSessionThrowAnNoData_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDataCity_WhenUrlSessionThrowData_ThenShouldReturnSuccesCallBack() {
        
        let weatherService = weatherRequest(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        weatherService.getDataCity { (result) in
            guard case .success(let city) = result else {
                XCTFail("testGetDataCity_WhenUrlSessionThrowData_ThenShouldReturnSuccesCallBack")
                return
            }
            XCTAssertNotNil(city)
            XCTAssert(city.name == "Paris")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    //============================================================================================================
    //                                    MARK: - TEST getDataTwoCity WeatherService
    //============================================================================================================
    
    
    func testGetDataTwoCity_WhenUrlSessionThrowAnError_ThenShouldReturnFaillureCallBack() {
        
        let weatherService = weatherRequest(data: nil, response: nil, error: FakeResponseData.error)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        weatherService.getDataTwoCities { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetDataTwoCity_WhenUrlSessionThrowAnError_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDataTwoCity_WhenUrlSessionThrowABadResponse_ThenShouldReturnFaillureCallBack() {
        
        let weatherService = weatherRequest(data: nil, response: FakeResponseData.responseKO, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        weatherService.getDataTwoCities { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetDataTwoCity_WhenUrlSessionThrowAnBadResponse_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDataTwoCity_WhenUrlSessionThrowIncorrectData_ThenShouldReturnFaillureCallBack() {
        
        let weatherService = weatherRequest(data: nil, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        weatherService.getDataTwoCities { (result) in
            guard case .failure(let error) = result else {
                XCTFail("testGetDataTwoCity_WhenUrlSessionThrowAnNoData_ThenShouldReturnFaillureCallBack")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    func testGetDataTwoCity_WhenUrlSessionThrowData_ThenShouldReturnSuccesCallBack() {
        
        let weatherService = weatherRequest(data: FakeResponseData.weatherTwoCitiesCorrectData, response: FakeResponseData.responseOk, error: nil)
        
        let expectation = XCTestExpectation(description: "Waiting ...")
        weatherService.getDataTwoCities { (result) in
            guard case .success(let twoCities) = result else {
                XCTFail("testGetDataTwoCity_WhenUrlSessionThrowData_ThenShouldReturnSuccesCallBack")
                return
            }
            XCTAssertNotNil(twoCities)
            XCTAssert(twoCities.list[0].name == "Paris")
            XCTAssert(twoCities.list[1].name == "New York")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}

