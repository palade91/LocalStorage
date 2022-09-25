import Foundation

public protocol LocalStorageKeysProtocol {
    var rawValue: String { get }
}

public protocol Storeable {
    var storeData: Data? { get }
    init?(storeData: Data?)
}

public struct LocalStorage {
    
    private let userDefaults = UserDefaults.standard

    public init() { }
    
    // Setter
    public func setValue<T>(_ value: T?, forKey key: LocalStorageKeysProtocol) {
        self.userDefaults.set(value, forKey: key.rawValue)
    }
    
    func setValueStoreable<T>(_ value: T?, forKey key: LocalStorageKeysProtocol) where T: Storeable {
        self.userDefaults.set(value?.storeData, forKey: key.rawValue)
    }
    
    // Getter
    public func getValue<T>(forKey key: LocalStorageKeysProtocol) -> T? {
        return self.userDefaults.object(forKey: key.rawValue) as? T
    }
    
    func getValueStoreable<T>(forKey key: LocalStorageKeysProtocol) -> T? where T: Storeable {
        let data: Data? = self.userDefaults.data(forKey: key.rawValue)
        return T(storeData: data)
    }
    
    // Remove
    func remove(key: LocalStorageKeysProtocol) {
        self.userDefaults.set(nil, forKey: key.rawValue)
    }
}
