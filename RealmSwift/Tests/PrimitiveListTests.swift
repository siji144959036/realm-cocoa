////////////////////////////////////////////////////////////////////////////
//
// Copyright 2017 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import XCTest
import RealmSwift

protocol ObjectFactory {
    static func isManaged() -> Bool
}

final class ManagedObjectFactory: ObjectFactory {
    static func isManaged() -> Bool { return true }
}
final class UnmanagedObjectFactory: ObjectFactory {
    static func isManaged() -> Bool { return false }
}

protocol ValueFactory {
    associatedtype T: RealmCollectionValue
    associatedtype W: RealmCollectionValue = T
    static func array(_ obj: SwiftListObject) -> List<T>
    static func values() -> [T]
}

final class IntFactory: ValueFactory {
    static func array(_ obj: SwiftListObject) -> List<Int> {
        return obj.int
    }

    static func values() -> [Int] {
        return [1, 2, 3]
    }
}

final class Int8Factory: ValueFactory {
    static func array(_ obj: SwiftListObject) -> List<Int8> {
        return obj.int8
    }

    static func values() -> [Int8] {
        return [1, 2, 3]
    }
}

final class Int16Factory: ValueFactory {
    static func array(_ obj: SwiftListObject) -> List<Int16> {
        return obj.int16
    }

    static func values() -> [Int16] {
        return [1, 2, 3]
    }
}

final class Int32Factory: ValueFactory {
    static func array(_ obj: SwiftListObject) -> List<Int32> {
        return obj.int32
    }

    static func values() -> [Int32] {
        return [1, 2, 3]
    }
}

final class Int64Factory: ValueFactory {
    static func array(_ obj: SwiftListObject) -> List<Int64> {
        return obj.int64
    }

    static func values() -> [Int64] {
        return [1, 2, 3]
    }
}

final class FloatFactory: ValueFactory {
    static func array(_ obj: SwiftListObject) -> List<Float> {
        return obj.float
    }

    static func values() -> [Float] {
        return [1.1, 2.2, 3.3]
    }
}

final class DoubleFactory: ValueFactory {
    static func array(_ obj: SwiftListObject) -> List<Double> {
        return obj.double
    }

    static func values() -> [Double] {
        return [1.1, 2.2, 3.3]
    }
}

final class StringFactory: ValueFactory {
    static func array(_ obj: SwiftListObject) -> List<String> {
        return obj.string
    }

    static func values() -> [String] {
        return ["a", "b", "c"]
    }
}

final class DataFactory: ValueFactory {
    static func array(_ obj: SwiftListObject) -> List<Data> {
        return obj.data
    }

    static func values() -> [Data] {
        return ["a".data(using: .utf8)!, "b".data(using: .utf8)!, "c".data(using: .utf8)!]
    }
}

final class DateFactory: ValueFactory {
    static func array(_ obj: SwiftListObject) -> List<Date> {
        return obj.date
    }

    static func values() -> [Date] {
        return [Date(), Date().addingTimeInterval(10), Date().addingTimeInterval(20)]
    }
}

final class OptionalIntFactory: ValueFactory {
    typealias W = Int

    static func array(_ obj: SwiftListObject) -> List<Int?> {
        return obj.intOpt
    }

    static func values() -> [Int?] {
        return [1, nil, 3]
    }
}

final class OptionalInt8Factory: ValueFactory {
    typealias W = Int8

    static func array(_ obj: SwiftListObject) -> List<Int8?> {
        return obj.int8Opt
    }

    static func values() -> [Int8?] {
        return [1, nil, 3]
    }
}

final class OptionalInt16Factory: ValueFactory {
    typealias W = Int16

    static func array(_ obj: SwiftListObject) -> List<Int16?> {
        return obj.int16Opt
    }

    static func values() -> [Int16?] {
        return [1, nil, 3]
    }
}

final class OptionalInt32Factory: ValueFactory {
    typealias W = Int32

    static func array(_ obj: SwiftListObject) -> List<Int32?> {
        return obj.int32Opt
    }

    static func values() -> [Int32?] {
        return [1, nil, 3]
    }
}

final class OptionalInt64Factory: ValueFactory {
    typealias W = Int64

    static func array(_ obj: SwiftListObject) -> List<Int64?> {
        return obj.int64Opt
    }

    static func values() -> [Int64?] {
        return [1, nil, 3]
    }
}

final class OptionalFloatFactory: ValueFactory {
    typealias W = Float

    static func array(_ obj: SwiftListObject) -> List<Float?> {
        return obj.floatOpt
    }

    static func values() -> [Float?] {
        return [1.1, nil, 3.3]
    }
}

final class OptionalDoubleFactory: ValueFactory {
    typealias W = Double

    static func array(_ obj: SwiftListObject) -> List<Double?> {
        return obj.doubleOpt
    }

    static func values() -> [Double?] {
        return [1.1, nil, 3.3]
    }
}

final class OptionalStringFactory: ValueFactory {
    typealias W = String

    static func array(_ obj: SwiftListObject) -> List<String?> {
        return obj.stringOpt
    }

    static func values() -> [String?] {
        return ["a", nil, "c"]
    }
}

final class OptionalDataFactory: ValueFactory {
    typealias W = Data

    static func array(_ obj: SwiftListObject) -> List<Data?> {
        return obj.dataOpt
    }

    static func values() -> [Data?] {
        return ["a".data(using: .utf8)!, nil, "c".data(using: .utf8)!]
    }
}

final class OptionalDateFactory: ValueFactory {
    typealias W = Date

    static func array(_ obj: SwiftListObject) -> List<Date?> {
        return obj.dateOpt
    }

    static func values() -> [Date?] {
        return [Date(), nil, Date().addingTimeInterval(20)]
    }
}


class PrimitiveListTestsBase<O: ObjectFactory, V: ValueFactory>: TestCase {
    var realm: Realm?
    var obj: SwiftListObject!
    var array: List<V.T>!
    var values: [V.T]!

    override func setUp() {
        obj = SwiftListObject()
        if O.isManaged() {
            let config = Realm.Configuration(inMemoryIdentifier: "test", objectTypes: [SwiftListObject.self])
            realm = try! Realm(configuration: config)
            realm!.beginWrite()
            realm!.add(obj)
        }
        array = V.array(obj)
        values = V.values()
    }

    override func tearDown() {
        realm?.cancelWrite()
        realm = nil
        array = nil
        obj = nil
    }

    // writing value as! Int? gives "cannot downcast from 'T' to a more optional type 'Optional<Int>'"
    // but doing this nonsense works
    func cast<T, U>(_ value: T) -> U {
        return value as! U
    }

    // No conditional conformance means that Optional<T: Equatable> can't
    // itself conform to Equatable
    override func assertEqual<T>(_ expected: T, _ actual: T, fileName: StaticString = #file, lineNumber: UInt = #line) {
        if T.self is Int.Type {
            XCTAssertEqual(expected as! Int, actual as! Int, file: fileName, line: lineNumber)
        }
        else if T.self is Float.Type {
            XCTAssertEqual(expected as! Float, actual as! Float, file: fileName, line: lineNumber)
        }
        else if T.self is Double.Type {
            XCTAssertEqual(expected as! Double, actual as! Double, file: fileName, line: lineNumber)
        }
        else if T.self is Bool.Type {
            XCTAssertEqual(expected as! Bool, actual as! Bool, file: fileName, line: lineNumber)
        }
        else if T.self is Int8.Type {
            XCTAssertEqual(expected as! Int8, actual as! Int8, file: fileName, line: lineNumber)
        }
        else if T.self is Int16.Type {
            XCTAssertEqual(expected as! Int16, actual as! Int16, file: fileName, line: lineNumber)
        }
        else if T.self is Int32.Type {
            XCTAssertEqual(expected as! Int32, actual as! Int32, file: fileName, line: lineNumber)
        }
        else if T.self is Int64.Type {
            XCTAssertEqual(expected as! Int64, actual as! Int64, file: fileName, line: lineNumber)
        }
        else if T.self is String.Type {
            XCTAssertEqual(expected as! String, actual as! String, file: fileName, line: lineNumber)
        }
        else if T.self is Data.Type {
            XCTAssertEqual(expected as! Data, actual as! Data, file: fileName, line: lineNumber)
        }
        else if T.self is Date.Type {
            XCTAssertEqual(expected as! Date, actual as! Date, file: fileName, line: lineNumber)
        }
        else if T.self is [Int].Type {
            XCTAssertEqual(expected as! [Int], actual as! [Int], file: fileName, line: lineNumber)
        }
        else if T.self is [Float].Type {
            XCTAssertEqual(expected as! [Float], actual as! [Float], file: fileName, line: lineNumber)
        }
        else if T.self is [Double].Type {
            XCTAssertEqual(expected as! [Double], actual as! [Double], file: fileName, line: lineNumber)
        }
        else if T.self is [Bool].Type {
            XCTAssertEqual(expected as! [Bool], actual as! [Bool], file: fileName, line: lineNumber)
        }
        else if T.self is [Int8].Type {
            XCTAssertEqual(expected as! [Int8], actual as! [Int8], file: fileName, line: lineNumber)
        }
        else if T.self is [Int16].Type {
            XCTAssertEqual(expected as! [Int16], actual as! [Int16], file: fileName, line: lineNumber)
        }
        else if T.self is [Int32].Type {
            XCTAssertEqual(expected as! [Int32], actual as! [Int32], file: fileName, line: lineNumber)
        }
        else if T.self is [Int64].Type {
            XCTAssertEqual(expected as! [Int64], actual as! [Int64], file: fileName, line: lineNumber)
        }
        else if T.self is [String].Type {
            XCTAssertEqual(expected as! [String], actual as! [String], file: fileName, line: lineNumber)
        }
        else if T.self is [Data].Type {
            XCTAssertEqual(expected as! [Data], actual as! [Data], file: fileName, line: lineNumber)
        }
        else if T.self is [Date].Type {
            XCTAssertEqual(expected as! [Date], actual as! [Date], file: fileName, line: lineNumber)
        }
        else if T.self is Int?.Type {
            XCTAssertEqual(cast(expected) as Int?, cast(actual) as Int?, file: fileName, line: lineNumber)
        }
        else if T.self is Float?.Type {
            XCTAssertEqual(cast(expected) as Float?, cast(actual) as Float?, file: fileName, line: lineNumber)
        }
        else if T.self is Double?.Type {
            XCTAssertEqual(cast(expected) as Double?, cast(actual) as Double?, file: fileName, line: lineNumber)
        }
        else if T.self is Bool?.Type {
            XCTAssertEqual(cast(expected) as Bool?, cast(actual) as Bool?, file: fileName, line: lineNumber)
        }
        else if T.self is Int8?.Type {
            XCTAssertEqual(cast(expected) as Int8?, cast(actual) as Int8?, file: fileName, line: lineNumber)
        }
        else if T.self is Int16?.Type {
            XCTAssertEqual(cast(expected) as Int16?, cast(actual) as Int16?, file: fileName, line: lineNumber)
        }
        else if T.self is Int32?.Type {
            XCTAssertEqual(cast(expected) as Int32?, cast(actual) as Int32?, file: fileName, line: lineNumber)
        }
        else if T.self is Int64?.Type {
            XCTAssertEqual(cast(expected) as Int64?, cast(actual) as Int64?, file: fileName, line: lineNumber)
        }
        else if T.self is String?.Type {
            XCTAssertEqual(cast(expected) as String?, cast(actual) as String?, file: fileName, line: lineNumber)
        }
        else if T.self is Data?.Type {
            XCTAssertEqual(cast(expected) as Data?, cast(actual) as Data?, file: fileName, line: lineNumber)
        }
        else if T.self is Date?.Type {
            XCTAssertEqual(cast(expected) as Date?, cast(actual) as Date?, file: fileName, line: lineNumber)
        }
        else if T.self is [Int?].Type {
            assertEqual(cast(expected) as [Int?], cast(actual) as [Int?], file: fileName, line: lineNumber)
        }
        else if T.self is [Float?].Type {
            assertEqual(cast(expected) as [Float?], cast(actual) as [Float?], file: fileName, line: lineNumber)
        }
        else if T.self is [Double?].Type {
            assertEqual(cast(expected) as [Double?], cast(actual) as [Double?], file: fileName, line: lineNumber)
        }
        else if T.self is [Bool?].Type {
            assertEqual(cast(expected) as [Bool?], cast(actual) as [Bool?], file: fileName, line: lineNumber)
        }
        else if T.self is [Int8?].Type {
            assertEqual(cast(expected) as [Int8?], cast(actual) as [Int8?], file: fileName, line: lineNumber)
        }
        else if T.self is [Int16?].Type {
            assertEqual(cast(expected) as [Int16?], cast(actual) as [Int16?], file: fileName, line: lineNumber)
        }
        else if T.self is [Int32?].Type {
            assertEqual(cast(expected) as [Int32?], cast(actual) as [Int32?], file: fileName, line: lineNumber)
        }
        else if T.self is [Int64?].Type {
            assertEqual(cast(expected) as [Int64?], cast(actual) as [Int64?], file: fileName, line: lineNumber)
        }
        else if T.self is [String?].Type {
            assertEqual(cast(expected) as [String?], cast(actual) as [String?], file: fileName, line: lineNumber)
        }
        else if T.self is [Data?].Type {
            assertEqual(cast(expected) as [Data?], cast(actual) as [Data?], file: fileName, line: lineNumber)
        }
        else if T.self is [Date?].Type {
            assertEqual(cast(expected) as [Date?], cast(actual) as [Date?], file: fileName, line: lineNumber)
        }
        else {
            XCTFail("unsupported type \(T.self)", file: fileName, line: lineNumber)
            fatalError("unsupported type \(T.self)")
        }
    }

    override func assertEqual<T>(_ expected: T?, _ actual: T?, fileName: StaticString = #file, lineNumber: UInt = #line) {
        if expected == nil {
            XCTAssertNil(actual, file: fileName, line: lineNumber)
        }
        else if actual == nil {
            XCTFail("nil")
        }
        else {
            assertEqual(expected!, actual!, fileName: fileName, lineNumber: lineNumber)
        }
    }

    func assertEqual<T>(_ expected: T, _ actual: T?) {
        guard let actual = actual else {
            XCTFail("nil")
            return
        }
        assertEqual(expected, actual)
    }
}

class PrimitiveListTests<O: ObjectFactory, V: ValueFactory>: PrimitiveListTestsBase<O, V> {
    func testInvalidated() {
        XCTAssertFalse(array.isInvalidated)
        if let realm = obj.realm {
            realm.delete(obj)
            XCTAssertTrue(array.isInvalidated)
        }
    }

    func testIndexOf() {
        XCTAssertNil(array.index(of: values[0]))

        array.append(values[0])
        assertEqual(0, array.index(of: values[0]))

        array.append(values[1])
        assertEqual(0, array.index(of: values[0]))
        assertEqual(1, array.index(of: values[1]))
    }

    func testIndexMatching() {
        return; // not implemented
        XCTAssertNil(array.index(matching: "self = %@", values[0]))

        array.append(values[0])
        assertEqual(0, array.index(matching: "self = %@", values[0]))

        array.append(values[1])
        assertEqual(0, array.index(matching: "self = %@", values[0]))
        assertEqual(1, array.index(matching: "self = %@", values[1]))
    }

    func testSubscript() {
        array.append(objectsIn: values)
        for i in 0..<values.count {
            assertEqual(array[i], values[i])
        }
        assertThrows(array[values.count], reason: "Index 3 is out of bounds")
        assertThrows(array[-1], reason: "negative value")
    }

    func testFirst() {
        array.append(objectsIn: values)
        assertEqual(array.first, values.first)
        array.removeAll()
        XCTAssertNil(array.first)
    }

    func testLast() {
        array.append(objectsIn: values)
        assertEqual(array.last, values.last)
        array.removeAll()
        XCTAssertNil(array.last)

    }

    func testValueForKey() {
        assertEqual(array.value(forKey: "self").count, 0)
        array.append(objectsIn: values)
        assertEqual(values!, array.value(forKey: "self") as [AnyObject] as! [V.T])

        assertThrows(array.value(forKey: "not self"), named: "NSUnknownKeyException")
    }

    func testSetValueForKey() {
        // does this even make any sense?

    }

    func testFilter() {
        // not implemented

    }

    func testInsert() {
        assertEqual(Int(0), array.count)

        array.insert(values[0], at: 0)
        assertEqual(Int(1), array.count)
        assertEqual(values[0], array[0])

        array.insert(values[1], at: 0)
        assertEqual(Int(2), array.count)
        assertEqual(values[1], array[0])
        assertEqual(values[0], array[1])

        array.insert(values[2], at: 2)
        assertEqual(Int(3), array.count)
        assertEqual(values[1], array[0])
        assertEqual(values[0], array[1])
        assertEqual(values[2], array[2])

        assertThrows(_ = array.insert(values[0], at: 4))
        assertThrows(_ = array.insert(values[0], at: -1))
    }

    func testRemove() {
        assertThrows(array.remove(at: 0))
        assertThrows(array.remove(at: -1))

        array.append(objectsIn: values)

        assertThrows(array.remove(at: -1))
        assertEqual(values[0], array[0])
        assertEqual(values[1], array[1])
        assertEqual(values[2], array[2])
        assertThrows(array[3])

        array.remove(at: 0)
        assertEqual(values[1], array[0])
        assertEqual(values[2], array[1])
        assertThrows(array[2])
        assertThrows(array.remove(at: 2))

        array.remove(at: 1)
        assertEqual(values[1], array[0])
        assertThrows(array[1])
    }

    func testRemoveLast() {
        array.removeLast()

        array.append(objectsIn: values)
        array.removeLast()

        assertEqual(array.count, 2)
        assertEqual(values[0], array[0])
        assertEqual(values[1], array[1])

        array.removeLast(2)
        assertEqual(array.count, 0)
    }

    func testRemoveAll() {
        array.removeAll()
        array.append(objectsIn: values)
        array.removeAll()
        assertEqual(array.count, 0)
    }

    func testReplace() {
        assertThrows(array.replace(index: 0, object: values[0]),
                     reason: "Index 0 is out of bounds")

        array.append(objectsIn: values)
        array.replace(index: 1, object: values[0])
        assertEqual(array[0], values[0])
        assertEqual(array[1], values[0])
        assertEqual(array[2], values[2])

        assertThrows(array.replace(index: 3, object: values[0]),
                     reason: "Index 3 is out of bounds")
        assertThrows(array.replace(index: -1, object: values[0]),
                     reason: "Cannot pass a negative value")
    }

    func testMove() {
        assertThrows(array.move(from: 1, to: 0), reason: "out of bounds")

        array.append(objectsIn: values)
        array.move(from: 2, to: 0)
        assertEqual(array[0], values[2])
        assertEqual(array[1], values[0])
        assertEqual(array[2], values[1])

        assertThrows(array.move(from: 3, to: 0), reason: "Index 3 is out of bounds")
        assertThrows(array.move(from: 0, to: 3), reason: "Index 3 is out of bounds")
        assertThrows(array.move(from: -1, to: 0), reason: "negative value")
        assertThrows(array.move(from: 0, to: -1), reason: "negative value")
    }

    func testSwap() {
        assertThrows(array.swap(0, 1), reason: "out of bounds")

        array.append(objectsIn: values)
        array.swap(0, 2)
        assertEqual(array[0], values[2])
        assertEqual(array[1], values[1])
        assertEqual(array[2], values[0])

        assertThrows(array.swap(3, 0), reason: "Index 3 is out of bounds")
        assertThrows(array.swap(0, 3), reason: "Index 3 is out of bounds")
        assertThrows(array.swap(-1, 0), reason: "negative value")
        assertThrows(array.swap(0, -1), reason: "negative value")
    }
}

class MinMaxPrimitiveListTests<O: ObjectFactory, V: ValueFactory>: PrimitiveListTestsBase<O, V> where V.T: MinMaxType {
    func testMin() {
        XCTAssertNil(array.min())
        array.append(objectsIn: values.reversed())
        assertEqual(array.min(), values.first)
    }

    func testMax() {
        XCTAssertNil(array.max())
        array.append(objectsIn: values.reversed())
        assertEqual(array.max(), values.last)
    }
}

class OptionalMinMaxPrimitiveListTests<O: ObjectFactory, V: ValueFactory>: PrimitiveListTestsBase<O, V> where V.W: MinMaxType {
    // V.T and V.W? are the same thing, but the type system doesn't know that
    // and the protocol constraint is on V.W
    var array2: List<V.W?> {
        return unsafeDowncast(array!, to: List<V.W?>.self)
    }

    func testMin() {
        XCTAssertNil(array2.min())
        array.append(objectsIn: values.reversed())
        assertEqual(array2.min(), values.first! as! V.W)
    }

    func testMax() {
        XCTAssertNil(array2.max())
        array.append(objectsIn: values.reversed())
        assertEqual(array2.max(), values.last! as! V.W)
    }
}

class AddablePrimitiveListTests<O: ObjectFactory, V: ValueFactory>: PrimitiveListTestsBase<O, V> where V.T: AddableType {
    func testSum() {
        assertEqual(array.sum(), V.T())
        array.append(objectsIn: values)

        // Expressing "can be added and converted to a floating point type" as
        // a protocol requirement is awful, so sidestep it all with obj-c
        let expected = ((values as NSArray).value(forKeyPath: "@sum.self")! as! NSNumber).doubleValue
        let actual: V.T = array.sum()
        XCTAssertEqualWithAccuracy((actual as! NSNumber).doubleValue, expected, accuracy: 0.01)
    }

    func testAverage() {
        XCTAssertNil(array.average())
        array.append(objectsIn: values)

        let expected = ((values as NSArray).value(forKeyPath: "@avg.self")! as! NSNumber).doubleValue
        XCTAssertEqualWithAccuracy(array.average()!, expected, accuracy: 0.01)

    }
}

class SortablePrimitiveListTests<O: ObjectFactory, V: ValueFactory>: PrimitiveListTestsBase<O, V> where V.T: Comparable {
    func testSorted() {
        var shuffled = values!
        shuffled.removeFirst()
        shuffled.append(values!.first!)
        array.append(objectsIn: shuffled)

        assertEqual(Array(array.sorted(ascending: true)), values)
        assertEqual(Array(array.sorted(ascending: false)), values.reversed())
    }
}

func addTests<OF: ObjectFactory>(_ suite: XCTestSuite, _ type: OF.Type) {
    _ = PrimitiveListTests<OF, IntFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, Int8Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, Int16Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, Int32Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, Int64Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, FloatFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, DoubleFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, StringFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, DataFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, DateFactory>.defaultTestSuite().tests.map(suite.addTest)

    _ = MinMaxPrimitiveListTests<OF, IntFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = MinMaxPrimitiveListTests<OF, Int8Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = MinMaxPrimitiveListTests<OF, Int16Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = MinMaxPrimitiveListTests<OF, Int32Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = MinMaxPrimitiveListTests<OF, Int64Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = MinMaxPrimitiveListTests<OF, FloatFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = MinMaxPrimitiveListTests<OF, DoubleFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = MinMaxPrimitiveListTests<OF, DateFactory>.defaultTestSuite().tests.map(suite.addTest)

    _ = AddablePrimitiveListTests<OF, IntFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = AddablePrimitiveListTests<OF, Int8Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = AddablePrimitiveListTests<OF, Int16Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = AddablePrimitiveListTests<OF, Int32Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = AddablePrimitiveListTests<OF, Int64Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = AddablePrimitiveListTests<OF, FloatFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = AddablePrimitiveListTests<OF, DoubleFactory>.defaultTestSuite().tests.map(suite.addTest)

    _ = PrimitiveListTests<OF, OptionalIntFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, OptionalInt8Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, OptionalInt16Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, OptionalInt32Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, OptionalInt64Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, OptionalFloatFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, OptionalDoubleFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, OptionalStringFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, OptionalDataFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = PrimitiveListTests<OF, OptionalDateFactory>.defaultTestSuite().tests.map(suite.addTest)

    _ = OptionalMinMaxPrimitiveListTests<OF, OptionalIntFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = OptionalMinMaxPrimitiveListTests<OF, OptionalInt8Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = OptionalMinMaxPrimitiveListTests<OF, OptionalInt16Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = OptionalMinMaxPrimitiveListTests<OF, OptionalInt32Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = OptionalMinMaxPrimitiveListTests<OF, OptionalInt64Factory>.defaultTestSuite().tests.map(suite.addTest)
    _ = OptionalMinMaxPrimitiveListTests<OF, OptionalFloatFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = OptionalMinMaxPrimitiveListTests<OF, OptionalDoubleFactory>.defaultTestSuite().tests.map(suite.addTest)
    _ = OptionalMinMaxPrimitiveListTests<OF, OptionalDateFactory>.defaultTestSuite().tests.map(suite.addTest)
}

class UnmanagedPrimitiveListTests: TestCase {
    override class func defaultTestSuite() -> XCTestSuite {
        let suite = XCTestSuite(name: "Unmanaged Primitive Lists")
        addTests(suite, UnmanagedObjectFactory.self)
        return suite
    }
}

class ManagedPrimitiveListTests: TestCase {
    override class func defaultTestSuite() -> XCTestSuite {
        let suite = XCTestSuite(name: "Managed Primitive Lists")
        addTests(suite, ManagedObjectFactory.self)

        _ = SortablePrimitiveListTests<ManagedObjectFactory, IntFactory>.defaultTestSuite().tests.map(suite.addTest)
        _ = SortablePrimitiveListTests<ManagedObjectFactory, Int8Factory>.defaultTestSuite().tests.map(suite.addTest)
        _ = SortablePrimitiveListTests<ManagedObjectFactory, Int16Factory>.defaultTestSuite().tests.map(suite.addTest)
        _ = SortablePrimitiveListTests<ManagedObjectFactory, Int32Factory>.defaultTestSuite().tests.map(suite.addTest)
        _ = SortablePrimitiveListTests<ManagedObjectFactory, Int64Factory>.defaultTestSuite().tests.map(suite.addTest)
        _ = SortablePrimitiveListTests<ManagedObjectFactory, FloatFactory>.defaultTestSuite().tests.map(suite.addTest)
        _ = SortablePrimitiveListTests<ManagedObjectFactory, DoubleFactory>.defaultTestSuite().tests.map(suite.addTest)
        _ = SortablePrimitiveListTests<ManagedObjectFactory, StringFactory>.defaultTestSuite().tests.map(suite.addTest)
        _ = SortablePrimitiveListTests<ManagedObjectFactory, DateFactory>.defaultTestSuite().tests.map(suite.addTest)

//        _ = SortablePrimitiveListTests<ManagedObjectFactory, OptionalIntFactory>.defaultTestSuite().tests.map(suite.addTest)
//        _ = SortablePrimitiveListTests<ManagedObjectFactory, OptionalInt8Factory>.defaultTestSuite().tests.map(suite.addTest)
//        _ = SortablePrimitiveListTests<ManagedObjectFactory, OptionalInt16Factory>.defaultTestSuite().tests.map(suite.addTest)
//        _ = SortablePrimitiveListTests<ManagedObjectFactory, OptionalInt32Factory>.defaultTestSuite().tests.map(suite.addTest)
//        _ = SortablePrimitiveListTests<ManagedObjectFactory, OptionalInt64Factory>.defaultTestSuite().tests.map(suite.addTest)

        return suite
    }
}

/*
//    func testFastEnumerationWithMutation() {
//        guard let array = array, let str1 = str1, let str2 = str2 else {
//            fatalError("Test precondition failure")
//        }
//
//        array.append(objectsIn: [str1, str2, str1, str2, str1, str2, str1, str2, str1,
//            str2, str1, str2, str1, str2, str1, str2, str1, str2, str1, str2])
//        var str = ""
//        for obj in array {
//            str += obj.stringCol
//            array.append(objectsIn: [str1])
//        }
//
//        assertEqual(str, "12121212121212121212")
//    }

    func testAppendObject() {
        guard let array = array, let str1 = str1, let str2 = str2 else {
            fatalError("Test precondition failure")
        }
        for str in [str1, str2, str1] {
            array.append(str)
        }
        assertEqual(Int(3), array.count)
        assertEqual(str1, array[0])
        assertEqual(str2, array[1])
        assertEqual(str1, array[2])
    }

    func testAppendArray() {
        guard let array = array, let str1 = str1, let str2 = str2 else {
            fatalError("Test precondition failure")
        }
        array.append(objectsIn: [str1, str2, str1])
        assertEqual(Int(3), array.count)
        assertEqual(str1, array[0])
        assertEqual(str2, array[1])
        assertEqual(str1, array[2])
    }

    func testAppendResults() {
        guard let array = array, let str1 = str1, let str2 = str2 else {
            fatalError("Test precondition failure")
        }
        array.append(objectsIn: realmWithTestPath().objects(SwiftStringObject.self))
        assertEqual(Int(2), array.count)
        assertEqual(str1, array[0])
        assertEqual(str2, array[1])
    }

    func testReplaceRange() {
        guard let array = array, let str1 = str1, let str2 = str2 else {
            fatalError("Test precondition failure")
        }

        array.append(objectsIn: [str1, str1])

        array.replaceSubrange(0..<1, with: [str2])
        assertEqual(Int(2), array.count)
        assertEqual(str2, array[0])
        assertEqual(str1, array[1])

        array.replaceSubrange(1..<2, with: [str2])
        assertEqual(Int(2), array.count)
        assertEqual(str2, array[0])
        assertEqual(str2, array[1])

        array.replaceSubrange(0..<0, with: [str2])
        assertEqual(Int(3), array.count)
        assertEqual(str2, array[0])
        assertEqual(str2, array[1])
        assertEqual(str2, array[2])

        array.replaceSubrange(0..<3, with: [])
        assertEqual(Int(0), array.count)

        assertThrows(array.replaceSubrange(200..<201, with: [str2]))
        assertThrows(array.replaceSubrange(-200..<200, with: [str2]))
        assertThrows(array.replaceSubrange(0..<200, with: [str2]))
    }

    func testChangesArePersisted() {
        guard let array = array, let str1 = str1, let str2 = str2 else {
            fatalError("Test precondition failure")
        }
        if let realm = array.realm {
            array.append(objectsIn: [str1, str2])

            let otherArray = realm.objects(SwiftArrayPropertyObject.self).first!.array
            assertEqual(Int(2), otherArray.count)
        }
    }
}*/
