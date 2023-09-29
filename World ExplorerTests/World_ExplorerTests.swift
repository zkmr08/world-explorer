//
//  World_ExplorerTests.swift
//  World ExplorerTests
//
//  Created by Zakaria Marouf on 23/09/23.
//

import XCTest
@testable import World_Explorer

final class World_ExplorerTests: XCTestCase {
    
    func testCanParseData() throws {
        // (Given) Arrange
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "WECountriesJson", ofType: "json") else {
            fatalError("Json not found")
        }
        print("\n\n\(pathString)\n\n")
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Json not found")
        }
        let jsonData = json.data(using: .utf8)!
        
        // When (Act)
        let result = try! JSONDecoder().decode([WECountry].self, from: jsonData)
        
        // Then (Assert)
        XCTAssert(result.count == 250)
        XCTAssertEqual(result.first?.name.common, "British Indian Ocean Territory")
        XCTAssertEqual(result.first?.name.official, "British Indian Ocean Territory")
        XCTAssertNotEqual(result.first?.population, 1000000)
        XCTAssertEqual(result.first?.region.rawValue, "Africa")
        XCTAssertNil(result.first?.capital?.first, "Diego Garcia")
    }
}
