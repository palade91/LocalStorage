# LocalStorage

## Installation

1. From the File menu, navigate through **Swift Packages** and select **Add Package Dependency**
2. Enter package repository URL: `git@github.com:palade91/LocalStorage.git`
3. Confirm the version and let Xcode resolve the package

## Example Usage

    let storage = LocalStorage()
    
    enum LocalStorageKeys: String, LocalStorageKeysProtocol {
        case valueKey
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
    
    // Save
    storage.setValue("test value", forKey: LocalStorageKeys.valueKey)
    storage.setValueStoreable(TestUser(firstName: "Name", lastName: "LastName"), forKey: LocalStorageKeys.testUser)
        
    // Load
    let value: T? = storage.getValue(forKey: LocalStorageKeys.valueKey)
    let user: TestUser? = storage.getValueStoreable(forKey: LocalStorageKeys.testUser)
    
    // Remove
    storage.remove(key: LocalStorageKeys.valueKey)
