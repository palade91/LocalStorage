import XCTest
@testable import LocalStorage

final class LocalStorageTests: XCTestCase {
    
    let storage = LocalStorage()
    
    enum LocalStorageKeys: String, LocalStorageKeysProtocol {
        case testInt
        case testDouble
        case testString
        case testBool
        case testRemove
        case testUser
    }
    
    struct TestUser: Codable, Equatable, Storeable {
        let firstName: String
        let lastName: String
        
        var storeData: Data? {
            let encoder = JSONEncoder()
            let encoded = try? encoder.encode(self)
            return encoded
        }
        
        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }
        
        init?(storeData: Data?) {
            guard let storeData = storeData else { return nil }
            let decoder = JSONDecoder()
            guard let decoded = try? decoder.decode(TestUser.self, from: storeData) else { return nil }
            self = decoded
        }
    }

    func testInt() throws {
        let testInt = 10
        storage.setValue(testInt, forKey: LocalStorageKeys.testInt)

        let storedInt: Int? = storage.getValue(forKey: LocalStorageKeys.testInt)
        XCTAssertEqual(testInt, storedInt)
    }
    
    func testDouble() throws {
        let testDouble = 25.67
        storage.setValue(testDouble, forKey: LocalStorageKeys.testDouble)

        let storedDouble: Double? = storage.getValue(forKey: LocalStorageKeys.testDouble)
        XCTAssertEqual(testDouble, storedDouble)
    }
    
    func testString() throws {
        let testString = "Test"
        storage.setValue(testString, forKey: LocalStorageKeys.testString)
        
        let storedString: String? = storage.getValue(forKey: LocalStorageKeys.testString)
        XCTAssertEqual(testString, storedString)
    }
    
    func testBool() throws {
        let testBool = true
        storage.setValue(testBool, forKey: LocalStorageKeys.testBool)
        
        let storedBool: Bool? = storage.getValue(forKey: LocalStorageKeys.testBool)
        XCTAssertEqual(testBool, storedBool)
    }
    
    func testRemove() throws {
        let testValue = "Remove"
        storage.setValue(testValue, forKey: LocalStorageKeys.testRemove)
        
        let storedValue: String? = storage.getValue(forKey: LocalStorageKeys.testRemove)
        XCTAssertEqual(testValue, storedValue)
        
        storage.remove(key: LocalStorageKeys.testRemove)
        let nilValue: String? = storage.getValue(forKey: LocalStorageKeys.testRemove)
        XCTAssertNil(nilValue)
    }
    
    func testCustomObject() throws {
        let testUser: TestUser = TestUser(firstName: "Name", lastName: "LastName")
        storage.setValueStoreable(testUser, forKey: LocalStorageKeys.testUser)
        
        let storedUser: TestUser? = storage.getValueStoreable(forKey: LocalStorageKeys.testUser)
        XCTAssertEqual(testUser, storedUser)
       
        storage.remove(key: LocalStorageKeys.testUser)
        let nilUser: TestUser? = storage.getValueStoreable(forKey: LocalStorageKeys.testUser)
        XCTAssertNil(nilUser)
    }
}
