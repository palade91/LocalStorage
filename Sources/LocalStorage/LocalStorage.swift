import Foundation

public protocol LocalStorageKeysProtocol {
    var rawValue: String { get }
}

public struct LocalStorage {
    
    private let userDefaults = UserDefaults.standard

    public init() { }
    
    // Setter
    public func setValue<T>(_ value: T?, forKey key: LocalStorageKeysProtocol) {
        self.userDefaults.set(value, forKey: key.rawValue)
    }
    
    // Getter
    public func getValue<T>(forKey key: LocalStorageKeysProtocol) -> T? {
        return self.userDefaults.object(forKey: key.rawValue) as? T
    }
    
    // Remove
    func remove(key: LocalStorageKeysProtocol) {
        self.userDefaults.set(nil, forKey: key.rawValue)
    }
}
