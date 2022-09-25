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
    
    // Save
    storage.setValue("test value", forKey: LocalStorageKeys.valueKey)
    
    // Load
    let value: T? = storage.getValue(forKey: LocalStorageKeys.valueKey)
    
    // Remove
    storage.remove(key: LocalStorageKeys.valueKey)
