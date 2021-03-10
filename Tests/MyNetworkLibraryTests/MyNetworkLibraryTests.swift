import XCTest
@testable import MyNetworkLibrary

final class NetworkServiceTests: XCTestCase {
    
    let resourse = Resource(method: .get, url: URL(string: "https://google.com.ua")!, body: nil, headers: [:])
    
    func testRequest() {
        let networkService = NetworkClient()
        networkService.request(resourse: resourse) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testValidation() {
        let networkService = NetworkClient()
        networkService.request(resourse: resourse, validStatusCodes: 300..<600) { result in
            switch result {
            case .success(_):
                XCTFail("Error not throw")
            case .failure(_):
                break
            }
        }
    }
    
    func testDecoding() {
        struct Photos: Codable {
            let id, author: String
            let width, height: Int
            let url, downloadURL: String

            enum CodingKeys: String, CodingKey {
                case id, author, width, height, url
                case downloadURL = "download_url"
            }
        }
        let resource = Resource(method: .get, url: URL(string: "https://picsum.photos/id/0/info")!, body: nil, headers: [:])
        let networkService = NetworkClient()
        networkService.requestDecoding(resourse: resource, decodingType: Photos.self) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }

    static var allTests = [
        ("testRequest", testRequest),
        ("testValidation", testValidation),
        ("testDecoding", testDecoding),
    ]
}
