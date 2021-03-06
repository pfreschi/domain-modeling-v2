//
//  MoneyTests.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

import SimpleDomainModel

//////////////////
// MoneyTests
//
class MoneyTests: XCTestCase {
  
  let tenUSD = Money(amount: 10, currency: "USD")
  let twelveUSD = Money(amount: 12, currency: "USD")
  let fiveGBP = Money(amount: 5, currency: "GBP")
  let fifteenEUR = Money(amount: 15, currency: "EUR")
  let fifteenCAN = Money(amount: 15, currency: "CAN")
  
  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: "USD")
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == "USD")
    XCTAssert(oneUSD.description == "USD1")
    
    let tenGBP = Money(amount: 10, currency: "GBP")
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == "GBP")
    XCTAssert(tenGBP.description == "GBP10")
  }
  
  func testUSDtoGBP() {
    let gbp = tenUSD.convert("GBP")
    XCTAssert(gbp.currency == "GBP")
    XCTAssert(gbp.amount == 5)
    XCTAssert(gbp.description == "GBP5")
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert("EUR")
    XCTAssert(eur.currency == "EUR")
    XCTAssert(eur.amount == 15)
    XCTAssert(eur.description == "EUR15")
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert("CAN")
    XCTAssert(can.currency == "CAN")
    XCTAssert(can.amount == 15)
    XCTAssert(can.description == "CAN15")
  }
  func testGBPtoUSD() {
    let usd = fiveGBP.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
    XCTAssert(usd.description == "USD10")
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
    XCTAssert(usd.description == "USD10")
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 12)
  }
  
  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert("EUR")
    let usd = eur.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert("GBP")
    let usd = gbp.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert("CAN")
    let usd = can.convert("USD")
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
  }
  
  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == "USD")
    XCTAssert(total.description == "USD20")
  }
  
  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == "GBP")
    XCTAssert(total.description == "GBP10")
  }
  
    func testAddGBPtoGBP() {
        let total = fiveGBP.add(fiveGBP)
        XCTAssert(total.amount == 10)
        XCTAssert(total.currency == "GBP")
        XCTAssert(total.description == "GBP10")
    }
    
    func testSubtractUSDtoUSD() {
        let total = tenUSD.subtract(tenUSD)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "USD")
        XCTAssert(total.description == "USD0")
    }
    
    func extensionTestsForMoney() {
        let tenusd = 10.0.USD
        XCTAssert(tenusd.currency == "USD")
        XCTAssert(tenusd.amount == 10)
        let twentyGBP = 20.0.GBP
        XCTAssert(twentyGBP.currency == "GBP")
        XCTAssert(twentyGBP.amount == 20)
        let tenyen = 10.0.YEN
        XCTAssert(tenyen.currency == "USD")
        XCTAssert(tenyen.amount == 10)
        let thirtyeur = 30.0.EUR
        XCTAssert(thirtyeur.currency == "EUR")
        XCTAssert(thirtyeur.amount == 30)
    }
}

