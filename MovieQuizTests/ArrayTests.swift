//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by gimon on 12.02.2024.
//

import XCTest
@testable import MovieQuiz

final class ArrayTests: XCTestCase {
    private func testGetValueInRange() throws {
        //Given
        let array = [1, 1, 2, 3, 5]
        //When
        let value = array[safe: 2]
        //Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
    }
    
    private func testGetValueOfRange() throws {
        //Given
        let array = [1, 1, 2, 3, 5]
        //When
        let value = array[safe: 20]
        //Then
        XCTAssertNil(value)
    }
}
