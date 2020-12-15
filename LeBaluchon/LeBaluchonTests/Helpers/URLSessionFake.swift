//
//  URLSessionFake.swift
//  LeBaluchonTests
//
//  Created by ayite on 18/11/2020.
//

import Foundation

/**
 URLSessionFake class alows you to initalize HttpEgine to send responses without making a real request
 */

class URLSessionFake : URLSession {
    
    // MARK: - Properties
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    // MARK: - Initialization
    
    init(data : Data?, response : URLResponse?, error : Error? ){
        self.data = data
        self.response = response
        self.error = error
    }
    
    // MARK: - Methodes
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHanderler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
}

class URLSessionDataTaskFake : URLSessionDataTask {
    
    // MARK: - Properties
    
    var completionHanderler : ((Data?, URLResponse?, Error?)-> Void)?
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    // MARK: - Methodes
    
    override func resume() {
        completionHanderler?(data, urlResponse, responseError)
    }
    
    override func cancel() {}
    
}
