//
//  UserDefaults+Ex.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol KeyNameSpaceable {
    associatedtype Key: RawRepresentable where Key.RawValue == String
}

extension KeyNameSpaceable {
    private static func namespace(key: String) -> String {
        return "\(Self.self)." + key
    }
    
    static func namespace(key: Key) -> String {
        return namespace(key: key.rawValue)
    }
}

protocol UserDefaultable: KeyNameSpaceable {
    associatedtype ValueType
}

extension UserDefaultable {
    static func set(value: ValueType, key: Key) {
        let key = namespace(key: key)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func remove(key: Key) {
        let key = namespace(key: key)
        UserDefaults.standard.removeObject(forKey: key)
    }
}

extension UserDefaultable where ValueType == Bool {
    static func value(key: Key) -> ValueType {
        let key = namespace(key: key)
        return UserDefaults.standard.bool(forKey: key)
    }
}

extension UserDefaultable where ValueType == String {
    static func value(key: Key) -> ValueType {
        let key = namespace(key: key)
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
}

extension UserDefaultable where ValueType == Int {
    static func value(key: Key) -> ValueType {
        let key = namespace(key: key)
        return UserDefaults.standard.integer(forKey: key)
    }
}

extension UserDefaultable where ValueType == Dictionary<String, Any>? {
    static func value(key: Key) -> ValueType {
        let key = namespace(key: key)
        return UserDefaults.standard.value(forKey: key) as? [String: Any]
    }
}

extension UserDefaultable where ValueType: Sequence {
    static func value(key: Key) -> ValueType {
        let key = namespace(key: key)
        return UserDefaults.standard.array(forKey: key) as! ValueType
    }
}

extension UserDefaults {
    
    struct BoolType: UserDefaultable {
        typealias ValueType = Bool
        private init() {}
        
        enum Key: String {
            case keyA
        }
    }
    
    struct StringType: UserDefaultable {
        typealias ValueType = String
        private init() {}
        
        enum Key: String {
            case accessToken
        }
    }
    
    struct IntType: UserDefaultable {
        typealias ValueType = Int
        private init() {}
        
        enum Key: String {
            case keyA
        }
    }
    
    struct ArrayType<ElementType>: UserDefaultable {
        typealias ValueType = Array<ElementType>
        private init() {}
        
        enum Key: String {
            case cookies
        }
    }
    
    struct DictionaryType: UserDefaultable {
        typealias ValueType = [String: Any]?
        private init() {}
        
        enum Key: String {
            case httpCookieHeaders
        }
    }
    
}
