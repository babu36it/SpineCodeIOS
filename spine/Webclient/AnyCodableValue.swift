//
//  AnyCodableValue.swift

import Foundation

enum AnyCodableValue: Codable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object(Dictionary<String, AnyCodableValue>)
    case array([AnyCodableValue])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = try ((try? container.decode(String.self)).map(AnyCodableValue.string))
            .or((try? container.decode(Int.self)).map(AnyCodableValue.int))
            .or((try? container.decode(Double.self)).map(AnyCodableValue.double))
            .or((try? container.decode(Bool.self)).map(AnyCodableValue.bool))
            .or((try? container.decode(Dictionary<String, AnyCodableValue>.self)).map(AnyCodableValue.object))
            .or((try? container.decode([AnyCodableValue].self)).map(AnyCodableValue.array))
            .resolve(with: DecodingError.typeMismatch(AnyCodableValue.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON")))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .double(let x):
            try container.encode(x)
        case .bool(let x):
            try container.encode(x)
        case .object(let x):
            try container.encode(x)
        case .array(let x):
            try container.encode(x)
        }
    }
    
    // Get safe Values
    var stringValue: String {
        switch self {
        case .string(let s):
            return s
        case .int(let s):
            return "\(s)"
        case .double(let s):
            return "\(s)"
        case .object(let s):
            return "\(s)"
        case .array(let s):
            return "\(s)"
        default:
            return ""
        }
    }
    
    var intValue: Int {
        switch self {
        case .int(let s):
            return s
        case .string(let s):
            return (Int(s) ?? 0)
        case .double(let s):
            return (Int(s))
        default:
            return 0
        }
    }
    
    var doubleValue: Double {
        switch self {
        case .double(let s):
            return s
        case .string(let s):
            return (Double(s) ?? 0.0)
        case .int(let s):
            return (Double(s))
        default:
            return 0.0
        }
    }
    
    var boolValue: Bool {
        switch self {
        case .bool(let s):
            return s
        case .int(let s):
            return s == 1
        case .string(let s):
            let bool = (Int(s) ?? 0) == 1
            return bool
        default:
            return false
        }
    }
}

extension Optional {
    func or(_ other: Optional) -> Optional {
        switch self {
        case .none: return other
        case .some: return self
        }
    }
}

extension Optional {
    func resolve(with error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .none: throw error()
        case .some(let wrapped): return wrapped
        }
    }
}
