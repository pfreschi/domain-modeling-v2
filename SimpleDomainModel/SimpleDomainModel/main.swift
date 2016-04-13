//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation


public func testMe() -> String {
  return "I have been tested"
}

public class TestMe {
  public func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
    init(amount: Int, currency : String) {
        self.amount = amount
        if (currency == "USD" || currency == "GBP" || currency == "EUR" || currency == "CAN"){
            self.currency = currency
        } else {
            self.currency = "";
        }
    }
  public func convert(to: String) -> Money {
    var result = 0
    if (currency == "USD"){
        if (to == "GBP"){
            for var i = 0; i < amount; i+=2 {
                result+=1
            }
        } else if (to == "EUR"){
            for var i = 0; i < amount; i+=2 {
                result+=3
            }
        } else if (to == "CAN"){
            for var i = 0; i < amount; i+=4 {
                result+=5
            }
        }
    } else if (currency == "GBP"){
        if (to == "USD"){
            for var i = 0; i < amount; i+=1 {
                result+=2
            }
        } else if (to == "EUR") {
            for _ in 0 ..< amount {
                result+=3
            }
        } else if (to == "CAN") {
            for var i = 0; i < amount; i+=2 {
                result+=5
            }
        }
    } else if (currency == "CAN"){
        if (to == "USD"){
            for var i = 0; i < amount; i+=5 {
                result+=4
            }
        } else if (to == "EUR"){
            for var i = 0; i < amount; i+=5 {
                result+=6
            }
        } else if (to == "GBP"){
            for var i = 0; i < amount; i+=5 {
                result+=2
            }
        }
    } else if (currency == "EUR") {
        if (to == "USD"){
            for var i = 0; i < amount; i+=3 {
                result+=2
            }
        } else if (to == "GBP"){
            for var i = 0; i < amount; i+=3 {
                result+=1
            }
        } else if (to == "CAN"){
            for var i = 0; i < amount; i+=6 {
                result+=5
            }
        }
    }
    
    return Money(amount: result, currency: to)
  }
  
  public func add(to: Money) -> Money {
    if (self.currency == to.currency) {
        return Money(amount: self.amount + to.amount, currency: currency)
    } else {
        return Money(amount: self.convert(to.currency).amount + to.amount, currency: to.currency)
    }
  }
    
  public func subtract(from: Money) -> Money {
    if (self.currency == from.currency) {
        return Money(amount: from.amount - self.amount, currency: from.currency)
    } else {
        return Money(amount: from.amount - self.convert(from.currency).amount, currency: from.currency)
    }
  }
}

////////////////////////////////////
// Job
//
public class Job {

  public var title : String
  public var type : JobType
    
  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type

  }
  
  public func calculateIncome(hours: Int) -> Int {
    switch type {
        case .Hourly(let hourly):
            return Int(Double(hours) * hourly)
        case .Salary(let salary):
            return salary
    }
  }
  
  public func raise(amt : Double) {
    switch type {
    case .Hourly(let hourly):
        self.type = .Hourly(hourly + amt)
    case .Salary(let salary):
        self.type = .Salary(salary + Int(amt))
    }
  }
}

////////////////////////////////////
// Person
//
public class Person {
  public var firstName : String = ""
  public var lastName : String = ""
  public var age : Int = 0
  private var _job : Job?
  private var _spouse : Person?

  public var job : Job? {
    get {
        if(age > 16){
            return _job
        } else {
            return nil
        }
    }
    set(value) {
        _job = value
    }
  }
  
  public var spouse : Person? {
    get {
        if (age > 18) {
            return _spouse
        } else {
            return nil
        }
    }
    set(value) {
        _spouse = value!
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
    _job = nil
    _spouse = nil
  }
  
  public func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job) spouse:\(self.spouse)]"
  }
}

////////////////////////////////////
// Family
//
public class Family {
  private var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if (spouse1.spouse == nil && spouse2.spouse == nil){
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        members.append(spouse1)
        members.append(spouse2)
    }
  }
  
  public func haveChild(child: Person) -> Bool {
    var legalAdult = false
    for member in members {
        if (member.age >= 21){
            legalAdult = true
        }
    }
    if (legalAdult){
        self.members.append(child)
    }
    return legalAdult
  }
  
  public func householdIncome() -> Int {
    var total = 0
    for member in members {
        if (member.job != nil) {
            total += (member.job?.calculateIncome(2000))!
        }
    }
    return total
  }
}
