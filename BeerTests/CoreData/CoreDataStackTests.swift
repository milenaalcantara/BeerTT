////
////  CoreDataStackTests.swift
////  Beer
////
////  Created by Milena Alcântara on 20/11/25.
////
//
//import XCTest
//import CoreData
//@testable import Beer
//
//final class CoreDataStackTests: XCTestCase {
//
//    var stack: CoreDataStack!
//
//    override func setUp() {
//        super.setUp()
//        stack = CoreDataStack(modelName: "BeerModel", inMemory: true)
//    }
//
//    override func tearDown() {
//        stack = nil
//        super.tearDown()
//    }
//
//    func test_create_createsObject() {
//        let beer = stack.create(FavoriteBeer.self)
//
//        beer.id = "123"
//        beer.title = "Test Beer"
//
//        stack.saveContext()
//
//        let req = FavoriteBeer.fetchRequest()
//        let result = stack.fetch(req)
//
//        XCTAssertEqual(result.count, 1)
//        XCTAssertEqual(result.first?.id, "123")
//    }
//
//    func test_delete_removesObject() {
//        let beer = stack.create(FavoriteBeer.self)
//        beer.id = "1"
//        stack.saveContext()
//
//        stack.delete(beer)
//        stack.saveContext()
//
//        let req = FavoriteBeer.fetchRequest()
//        XCTAssertTrue(stack.fetch(req).isEmpty)
//    }
//
//    func test_deleteAll_removesAllMatchingObjects() {
//        let beer1 = stack.create(FavoriteBeer.self)
//        beer1.id = "1"
//
//        let beer2 = stack.create(FavoriteBeer.self)
//        beer2.id = "2"
//
//        stack.saveContext()
//
//        let req = FavoriteBeer.fetchRequest()
//        stack.deleteAll(req)
//        stack.saveContext()
//
//        XCTAssertTrue(stack.fetch(req).isEmpty)
//    }
//
//    func test_backgroundTask_executesWithoutCrash() {
//        let expectation = XCTestExpectation(description: "Background task executed")
//
//        stack.performBackgroundTask { ctx in
//            let beer = FavoriteBeer(context: ctx)
//            beer.id = "10"
//            try? ctx.save()
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 2.0)
//    }
//}
