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

#import "RLMTestCase.h"

@interface PrimitiveArrayPropertyTests : RLMTestCase
@end

@implementation PrimitiveArrayPropertyTests {
    AllPrimitiveArrays *unmanaged;
    AllPrimitiveArrays *managed;
    AllOptionalPrimitiveArrays *optUnmanaged;
    AllOptionalPrimitiveArrays *optManaged;
    RLMRealm *realm;
}

- (void)setUp {
    unmanaged = [[AllPrimitiveArrays alloc] init];
    optUnmanaged = [[AllOptionalPrimitiveArrays alloc] init];
    realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    managed = [AllPrimitiveArrays createInRealm:realm withValue:@[]];
    optManaged = [AllOptionalPrimitiveArrays createInRealm:realm withValue:@[]];
}

- (void)tearDown {
    if (realm.inWriteTransaction) {
        [realm cancelWriteTransaction];
    }
}

#pragma mark - Unmanaged

- (void)testUnmanagedCount {
    XCTAssertEqual(unmanaged.intObj.count, 0U);
    [unmanaged.intObj addObject:@1];
    XCTAssertEqual(unmanaged.intObj.count, 1U);
}

- (void)testUnmanagedType {
    XCTAssertEqual(unmanaged.boolObj.type, RLMPropertyTypeBool);
    XCTAssertEqual(unmanaged.intObj.type, RLMPropertyTypeInt);
    XCTAssertEqual(unmanaged.floatObj.type, RLMPropertyTypeFloat);
    XCTAssertEqual(unmanaged.doubleObj.type, RLMPropertyTypeDouble);
    XCTAssertEqual(unmanaged.stringObj.type, RLMPropertyTypeString);
    XCTAssertEqual(unmanaged.dataObj.type, RLMPropertyTypeData);
    XCTAssertEqual(unmanaged.dateObj.type, RLMPropertyTypeDate);
    XCTAssertEqual(optUnmanaged.boolObj.type, RLMPropertyTypeBool);
    XCTAssertEqual(optUnmanaged.intObj.type, RLMPropertyTypeInt);
    XCTAssertEqual(optUnmanaged.floatObj.type, RLMPropertyTypeFloat);
    XCTAssertEqual(optUnmanaged.doubleObj.type, RLMPropertyTypeDouble);
    XCTAssertEqual(optUnmanaged.stringObj.type, RLMPropertyTypeString);
    XCTAssertEqual(optUnmanaged.dataObj.type, RLMPropertyTypeData);
    XCTAssertEqual(optUnmanaged.dateObj.type, RLMPropertyTypeDate);
}

- (void)testUnmanagedOptional {
    XCTAssertFalse(unmanaged.boolObj.optional);
    XCTAssertFalse(unmanaged.intObj.optional);
    XCTAssertFalse(unmanaged.floatObj.optional);
    XCTAssertFalse(unmanaged.doubleObj.optional);
    XCTAssertFalse(unmanaged.stringObj.optional);
    XCTAssertFalse(unmanaged.dataObj.optional);
    XCTAssertFalse(unmanaged.dateObj.optional);
    XCTAssertTrue(optUnmanaged.boolObj.optional);
    XCTAssertTrue(optUnmanaged.intObj.optional);
    XCTAssertTrue(optUnmanaged.floatObj.optional);
    XCTAssertTrue(optUnmanaged.doubleObj.optional);
    XCTAssertTrue(optUnmanaged.stringObj.optional);
    XCTAssertTrue(optUnmanaged.dataObj.optional);
    XCTAssertTrue(optUnmanaged.dateObj.optional);
}

- (void)testUnmanagedObjectClassName {
    XCTAssertNil(unmanaged.boolObj.objectClassName);
    XCTAssertNil(unmanaged.intObj.objectClassName);
    XCTAssertNil(unmanaged.floatObj.objectClassName);
    XCTAssertNil(unmanaged.doubleObj.objectClassName);
    XCTAssertNil(unmanaged.stringObj.objectClassName);
    XCTAssertNil(unmanaged.dataObj.objectClassName);
    XCTAssertNil(unmanaged.dateObj.objectClassName);
    XCTAssertNil(optUnmanaged.boolObj.objectClassName);
    XCTAssertNil(optUnmanaged.intObj.objectClassName);
    XCTAssertNil(optUnmanaged.floatObj.objectClassName);
    XCTAssertNil(optUnmanaged.doubleObj.objectClassName);
    XCTAssertNil(optUnmanaged.stringObj.objectClassName);
    XCTAssertNil(optUnmanaged.dataObj.objectClassName);
    XCTAssertNil(optUnmanaged.dateObj.objectClassName);
}

- (void)testUnmanagedRealm {
    XCTAssertNil(unmanaged.boolObj.realm);
    XCTAssertNil(unmanaged.intObj.realm);
    XCTAssertNil(unmanaged.floatObj.realm);
    XCTAssertNil(unmanaged.doubleObj.realm);
    XCTAssertNil(unmanaged.stringObj.realm);
    XCTAssertNil(unmanaged.dataObj.realm);
    XCTAssertNil(unmanaged.dateObj.realm);
    XCTAssertNil(optUnmanaged.boolObj.realm);
    XCTAssertNil(optUnmanaged.intObj.realm);
    XCTAssertNil(optUnmanaged.floatObj.realm);
    XCTAssertNil(optUnmanaged.doubleObj.realm);
    XCTAssertNil(optUnmanaged.stringObj.realm);
    XCTAssertNil(optUnmanaged.dataObj.realm);
    XCTAssertNil(optUnmanaged.dateObj.realm);
}

- (void)testUnmanagedInvalidated {
    RLMArray *array;
    @autoreleasepool {
        AllPrimitiveArrays *obj = [[AllPrimitiveArrays alloc] init];
        array = obj.intObj;
        XCTAssertFalse(array.invalidated);
    }
    XCTAssertFalse(array.invalidated);
}


// unmanaged.boolObj @YES @NO
// unmanaged.intObj @2 @3
// unmanaged.floatObj @2.2f @3.3f
// unmanaged.doubleObj @2.2 @3.3
// unmanaged.stringObj @"a" @"b"
// unmanaged.dataObj data(1) data(2)
// unmanaged.dateObj date(1) date(2)
// optUnmanaged.boolObj @YES @NO NSNull.null
// optUnmanaged.intObj @2 @3 NSNull.null
// optUnmanaged.floatObj @2.2f @3.3f NSNull.null
// optUnmanaged.doubleObj @2.2 @3.3 NSNull.null
// optUnmanaged.stringObj @"a" @"b" NSNull.null
// optUnmanaged.dataObj data(1) data(2) NSNull.null
// optUnmanaged.dateObj date(1) date(2) NSNull.null

static NSDate *date(int i) {
    return [NSDate dateWithTimeIntervalSince1970:i];
}
static NSData *data(int i) {
    return [NSData dataWithBytesNoCopy:calloc(i, 1) length:i freeWhenDone:YES];
}

- (void)testUnmanagedObjectAtIndex {
    RLMAssertThrowsWithReason([unmanaged.intObj objectAtIndex:0],
                              @"Index 0 is out of bounds (must be less than 0).");

    [unmanaged.intObj addObject:@1];
    XCTAssertEqualObjects([unmanaged.intObj objectAtIndex:0], @1);
}

- (void)testUnmanagedFirstObject {
    XCTAssertNil($array.firstObject);

    %r [$array addObjects:$values];
    %r XCTAssertEqualObjects($array.firstObject, $first);

    %o [$array addObject:NSNull.null];
    %o XCTAssertEqualObjects($array.firstObject, NSNull.null);

    %o [$array removeAllObjects];

    %o [$array addObjects:$values];
    %o XCTAssertEqualObjects($array.firstObject, $first);
}

- (void)testUnmanagedLastObject {
    XCTAssertNil($array.lastObject);

    [$array addObjects:$values];
    XCTAssertEqualObjects($array.lastObject, $last);

    %o [$array removeLastObject];
    %o XCTAssertEqualObjects($array.lastObject, $v1);
}

- (void)testUnmanagedAddObject {
    RLMAssertThrowsWithReason([$array addObject:$wrong], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");
    %r RLMAssertThrowsWithReason([$array addObject:NSNull.null], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");

    [$array addObject:$v0];
    XCTAssertEqualObjects($array[0], $v0);

    %o [$array addObject:NSNull.null];
    %o XCTAssertEqualObjects($array[1], NSNull.null);
}

- (void)testUnmanagedAddObjects {
    RLMAssertThrowsWithReason([$array addObjects:@[$wrong]], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");
    %r RLMAssertThrowsWithReason([$array addObjects:@[NSNull.null]], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");

    [$array addObjects:$values];
    XCTAssertEqualObjects($array[0], $v0);
    XCTAssertEqualObjects($array[1], $v1);
    %o XCTAssertEqualObjects($array[2], NSNull.null);
}

- (void)testUnmanagedInsertObject {
    RLMAssertThrowsWithReason([$array insertObject:$wrong atIndex:0], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");
    %r RLMAssertThrowsWithReason([$array insertObject:NSNull.null atIndex:0], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");
    RLMAssertThrowsWithReason([$array insertObject:$v0 atIndex:1], ^n @"Index 1 is out of bounds (must be less than 1).");

    [$array insertObject:$v0 atIndex:0];
    XCTAssertEqualObjects($array[0], $v0);

    [$array insertObject:$v1 atIndex:0];
    XCTAssertEqualObjects($array[0], $v1);
    XCTAssertEqualObjects($array[1], $v0);

    %o [$array insertObject:NSNull.null atIndex:1];
    %o XCTAssertEqualObjects($array[0], $v1);
    %o XCTAssertEqualObjects($array[1], NSNull.null);
    %o XCTAssertEqualObjects($array[2], $v0);
}

- (void)testUnmanagedRemoveObject {
    RLMAssertThrowsWithReason([$array removeObjectAtIndex:0], ^n @"Index 0 is out of bounds (must be less than 0).");

    [$array addObjects:$values];
    %r XCTAssertEqual($array.count, 2U);
    %o XCTAssertEqual($array.count, 3U);

    %r RLMAssertThrowsWithReason([$array removeObjectAtIndex:2], ^n @"Index 2 is out of bounds (must be less than 2).");
    %o RLMAssertThrowsWithReason([$array removeObjectAtIndex:3], ^n @"Index 3 is out of bounds (must be less than 3).");

    [$array removeObjectAtIndex:0];
    %r XCTAssertEqual($array.count, 1U);
    %o XCTAssertEqual($array.count, 2U);

    XCTAssertEqualObjects($array[0], $v1);
    %o XCTAssertEqualObjects($array[1], NSNull.null);
}

- (void)testUnmanagedRemoveLastObject {
    XCTAssertNoThrow([$array removeLastObject]);

    [$array addObjects:$values];
    %r XCTAssertEqual($array.count, 2U);
    %o XCTAssertEqual($array.count, 3U);

    [$array removeLastObject];
    %r XCTAssertEqual($array.count, 1U);
    %o XCTAssertEqual($array.count, 2U);

    XCTAssertEqualObjects($array[0], $v0);
    %o XCTAssertEqualObjects($array[1], $v1);
}

- (void)testUnmanagedReplace {
    RLMAssertThrowsWithReason([$array replaceObjectAtIndex:0 withObject:$v0], ^n @"Index 0 is out of bounds (must be less than 0).");

    [$array addObject:$v0]; ^nl [$array replaceObjectAtIndex:0 withObject:$v1]; ^nl XCTAssertEqualObjects($array[0], $v1); ^nl 

    %o [$array replaceObjectAtIndex:0 withObject:NSNull.null]; ^nl XCTAssertEqualObjects($array[0], NSNull.null);

    RLMAssertThrowsWithReason([$array replaceObjectAtIndex:0 withObject:$wrong], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");
    %r RLMAssertThrowsWithReason([$array replaceObjectAtIndex:0 withObject:NSNull.null], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");
}

- (void)testUnmanagedMove {
    RLMAssertThrowsWithReason([$array moveObjectAtIndex:0 toIndex:1], ^n @"Index 0 is out of bounds (must be less than 0).");
    RLMAssertThrowsWithReason([$array moveObjectAtIndex:1 toIndex:0], ^n @"Index 1 is out of bounds (must be less than 0).");

    [$array addObjects:@[$v0, $v1, $v0, $v1]];

    [$array moveObjectAtIndex:2 toIndex:0];

    XCTAssertEqualObjects([$array valueForKey:@"self"], ^n (@[$v0, $v0, $v1, $v1]));
}

- (void)testUnmanagedExchange {
    RLMAssertThrowsWithReason([$array exchangeObjectAtIndex:0 withObjectAtIndex:1], ^n @"Index 0 is out of bounds (must be less than 0).");
    RLMAssertThrowsWithReason([$array exchangeObjectAtIndex:1 withObjectAtIndex:0], ^n @"Index 1 is out of bounds (must be less than 0).");

    [$array addObjects:@[$v0, $v1, $v0, $v1]];

    [$array exchangeObjectAtIndex:2 withObjectAtIndex:1];

    XCTAssertEqualObjects([$array valueForKey:@"self"], ^n (@[$v0, $v0, $v1, $v1]));
}

- (void)testUnmanagedIndexOfObject {
    XCTAssertEqual(NSNotFound, [$array indexOfObject:$v0]);

    RLMAssertThrowsWithReason([$array indexOfObject:$wrong], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");

    %r RLMAssertThrowsWithReason([$array indexOfObject:NSNull.null], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");
    %o XCTAssertEqual(NSNotFound, [$array indexOfObject:NSNull.null]);

    [$array addObjects:$values];

    XCTAssertEqual(1U, [$array indexOfObject:$v1]);
}

- (void)testUnmanagedIndexOfObjectWhere {
    XCTAssertEqual(NSNotFound, [$array indexOfObjectWhere:@"TRUEPREDICATE"]);

    [$array addObjects:$values];

    XCTAssertEqual(0U, [$array indexOfObjectWhere:@"TRUEPREDICATE"]);
    XCTAssertEqual(NSNotFound, [$array indexOfObjectWhere:@"FALSEPREDICATE"]);
}

- (void)testUnmanagedIndexOfObjectWithPredicate {
    XCTAssertEqual(NSNotFound, [$array indexOfObjectWithPredicate:[NSPredicate predicateWithValue:YES]]);

    [$array addObjects:$values];

    XCTAssertEqual(0U, [$array indexOfObjectWithPredicate:[NSPredicate predicateWithValue:YES]]);
    XCTAssertEqual(NSNotFound, [$array indexOfObjectWithPredicate:[NSPredicate predicateWithValue:NO]]);
}

- (void)testUnmanagedSort {
    %unman RLMAssertThrowsWithReason([$array sortedResultsUsingKeyPath:@"self" ascending:NO], ^n @"This method may only be called on RLMArray instances retrieved from an RLMRealm");
    %unman RLMAssertThrowsWithReason([$array sortedResultsUsingDescriptors:@[]], ^n @"This method may only be called on RLMArray instances retrieved from an RLMRealm");
    %man RLMAssertThrowsWithReason([$array sortedResultsUsingKeyPath:@"not self" ascending:NO], ^n @"self only");

    %man %r [$array addObjects:@[$v0, $v1, $v0]];
    %man %o [$array addObjects:@[$v0, $v1, NSNull.null, $v1, $v0]];

    %man %r XCTAssertEqualObjects([[$array sortedResultsUsingDescriptors:@[]] valueForKey:@"self"], ^n (@[$v0, $v1, $v0]));
    %man %o XCTAssertEqualObjects([[$array sortedResultsUsingDescriptors:@[]] valueForKey:@"self"], ^n (@[$v0, $v1, NSNull.null, $v1, $v0]));

    %man %r XCTAssertEqualObjects([[$array sortedResultsUsingKeyPath:@"self" ascending:NO] valueForKey:@"self"], ^n (@[$v1, $v0, $v0]));
    %man %o XCTAssertEqualObjects([[$array sortedResultsUsingKeyPath:@"self" ascending:NO] valueForKey:@"self"], ^n (@[$v1, $v1, $v0, $v0, NSNull.null]));

    %man %r XCTAssertEqualObjects([[$array sortedResultsUsingKeyPath:@"self" ascending:YES] valueForKey:@"self"], ^n (@[$v0, $v0, $v1]));
    %man %o XCTAssertEqualObjects([[$array sortedResultsUsingKeyPath:@"self" ascending:YES] valueForKey:@"self"], ^n (@[NSNull.null, $v0, $v0, $v1, $v1]));
}

- (void)testUnmanagedFilter {
    %unman RLMAssertThrowsWithReason([$array objectsWhere:@"TRUEPREDICATE"], ^n @"This method may only be called on RLMArray instances retrieved from an RLMRealm");
    %unman RLMAssertThrowsWithReason([$array objectsWithPredicate:[NSPredicate predicateWithValue:YES]], ^n @"This method may only be called on RLMArray instances retrieved from an RLMRealm");

    // FIXME: managed filter
}

- (void)testUnmanagedNotifications {
    %unman RLMAssertThrowsWithReason([$array addNotificationBlock:^(__unused id a, __unused id c, __unused id e) { }], ^n @"This method may only be called on RLMArray instances retrieved from an RLMRealm");
}

- (void)testUnmanagedMin {
    %nominmax RLMAssertThrowsWithReason([$array minOfProperty:@"self"], ^n @"minOfProperty: is not supported for $type array");

    %minmax XCTAssertNil([$array minOfProperty:@"self"]);

    %minmax [$array addObjects:$values];

    %minmax XCTAssertEqualObjects([$array minOfProperty:@"self"], $v0);
}

- (void)testUnmanagedMax {
    %nominmax RLMAssertThrowsWithReason([$array maxOfProperty:@"self"], ^n @"maxOfProperty: is not supported for $type array");

    %minmax XCTAssertNil([$array maxOfProperty:@"self"]);

    %minmax [$array addObjects:$values];

    %minmax XCTAssertEqualObjects([$array maxOfProperty:@"self"], $v1);
}

- (void)testUnmanagedSum {
    %nosum RLMAssertThrowsWithReason([$array sumOfProperty:@"self"], ^n @"sumOfProperty: is not supported for $type array");

    %sum XCTAssertEqualObjects([$array sumOfProperty:@"self"], @0);

    %sum [$array addObjects:$values];

    %sum XCTAssertEqualObjects([$array sumOfProperty:@"self"], @($s0 + $s1));
}

- (void)testUnmanagedAverage {
    %noavg RLMAssertThrowsWithReason([$array averageOfProperty:@"self"], ^n @"averageOfProperty: is not supported for $type array");

    %avg XCTAssertNil([$array averageOfProperty:@"self"]);

    %avg [$array addObjects:$values];

    %avg XCTAssertEqualWithAccuracy([$array averageOfProperty:@"self"].doubleValue, ($s0 + $s1) / 2.0, .001);
}

- (void)testUnmanagedFastEnumeration {
    for (int i = 0; i < 10; ++i) {
        [$array addObjects:$values];
    }

    { ^nl NSUInteger i = 0; ^nl NSArray *values = $values; ^nl for (id value in $array) { ^nl XCTAssertEqualObjects(values[i++ % values.count], value); ^nl } ^nl XCTAssertEqual(i, $array.count); ^nl } ^nl 
}

- (void)testUnmanagedFastEnumerationWithMutation {
    // this is sort of an open question
}

- (void)testUnmanagedValueForKey {
    XCTAssertEqualObjects([$array valueForKey:@"self"], @[]);

    [$array addObjects:$values];

    XCTAssertEqualObjects([$array valueForKey:@"self"], ($values));

    RLMAssertThrowsWithReason([$array valueForKey:@"count"], ^n @"this class is not key value coding-compliant for the key count");

    // FIXME: collection kvc stuff
}

- (void)testUnmanagedSetValueForKey {
    RLMAssertThrowsWithReason([$array setValue:@0 forKey:@"not self"], ^n @"idk");
    RLMAssertThrowsWithReason([$array setValue:$wrong forKey:@"self"], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");
    %r RLMAssertThrowsWithReason([$array setValue:NSNull.null forKey:@"self"], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");

    [$array addObjects:$values];

    [$array setValue:$v0 forKey:@"self"];

    XCTAssertEqualObjects($array[0], $v0);
    XCTAssertEqualObjects($array[1], $v0);
    %o XCTAssertEqualObjects($array[2], $v0);

    %o [$array setValue:NSNull.null forKey:@"self"];
    %o XCTAssertEqualObjects($array[0], NSNull.null);
}

- (void)testUnmanagedAssignment {
    $array = (id)$values; ^nl XCTAssertEqualObjects([$array valueForKey:@"self"], ($values)); ^nl 

    $array = $array; ^nl XCTAssertEqualObjects([$array valueForKey:@"self"], ($values)); ^nl 
}

- (void)testUnmanagedDescription {

}

#pragma mark - Managed

- (void)testAllMethodsCheckThread {
    RLMArray *array = managed.intObj;
    [self dispatchAsyncAndWait:^{
        RLMAssertThrowsWithReason([array count], @"thread");
        RLMAssertThrowsWithReason([array objectAtIndex:0], @"thread");
        RLMAssertThrowsWithReason([array firstObject], @"thread");
        RLMAssertThrowsWithReason([array lastObject], @"thread");

        RLMAssertThrowsWithReason([array addObject:@0], @"thread");
        RLMAssertThrowsWithReason([array addObjects:@[@0]], @"thread");
        RLMAssertThrowsWithReason([array insertObject:@0 atIndex:0], @"thread");
        RLMAssertThrowsWithReason([array removeObjectAtIndex:0], @"thread");
        RLMAssertThrowsWithReason([array removeLastObject], @"thread");
        RLMAssertThrowsWithReason([array removeAllObjects], @"thread");
        RLMAssertThrowsWithReason([array replaceObjectAtIndex:0 withObject:@0], @"thread");
        RLMAssertThrowsWithReason([array moveObjectAtIndex:0 toIndex:1], @"thread");
        RLMAssertThrowsWithReason([array exchangeObjectAtIndex:0 withObjectAtIndex:1], @"thread");

        RLMAssertThrowsWithReason([array indexOfObject:[IntObject allObjects].firstObject], @"thread");
        RLMAssertThrowsWithReason([array indexOfObjectWhere:@"TRUEPREDICATE"], @"thread");
        RLMAssertThrowsWithReason([array indexOfObjectWithPredicate:[NSPredicate predicateWithValue:NO]], @"thread");
        RLMAssertThrowsWithReason([array objectsWhere:@"TRUEPREDICATE"], @"thread");
        RLMAssertThrowsWithReason([array objectsWithPredicate:[NSPredicate predicateWithValue:NO]], @"thread");
        RLMAssertThrowsWithReason([array sortedResultsUsingKeyPath:@"self" ascending:YES], @"thread");
        RLMAssertThrowsWithReason([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"intCol" ascending:YES]]], @"thread");
        RLMAssertThrowsWithReason(array[0], @"thread");
        RLMAssertThrowsWithReason(array[0] = @0, @"thread");
        RLMAssertThrowsWithReason([array valueForKey:@"intCol"], @"thread");
        RLMAssertThrowsWithReason([array setValue:@1 forKey:@"intCol"], @"thread");
        RLMAssertThrowsWithReason({for (__unused id obj in array);}, @"thread");
    }];
}

- (void)testAllMethodsCheckForInvalidation {
    RLMArray *array = managed.intObj;
    [realm cancelWriteTransaction];
    [realm invalidate];

    XCTAssertNoThrow([array objectClassName]);
    XCTAssertNoThrow([array realm]);
    XCTAssertNoThrow([array isInvalidated]);

    RLMAssertThrowsWithReason([array count], @"invalidated");
    RLMAssertThrowsWithReason([array objectAtIndex:0], @"invalidated");
    RLMAssertThrowsWithReason([array firstObject], @"invalidated");
    RLMAssertThrowsWithReason([array lastObject], @"invalidated");

    RLMAssertThrowsWithReason([array addObject:@0], @"invalidated");
    RLMAssertThrowsWithReason([array addObjects:@[@0]], @"invalidated");
    RLMAssertThrowsWithReason([array insertObject:@0 atIndex:0], @"invalidated");
    RLMAssertThrowsWithReason([array removeObjectAtIndex:0], @"invalidated");
    RLMAssertThrowsWithReason([array removeLastObject], @"invalidated");
    RLMAssertThrowsWithReason([array removeAllObjects], @"invalidated");
    RLMAssertThrowsWithReason([array replaceObjectAtIndex:0 withObject:@0], @"invalidated");
    RLMAssertThrowsWithReason([array moveObjectAtIndex:0 toIndex:1], @"invalidated");
    RLMAssertThrowsWithReason([array exchangeObjectAtIndex:0 withObjectAtIndex:1], @"invalidated");

    RLMAssertThrowsWithReason([array indexOfObject:[IntObject allObjects].firstObject], @"invalidated");
    RLMAssertThrowsWithReason([array indexOfObjectWhere:@"TRUEPREDICATE"], @"invalidated");
    RLMAssertThrowsWithReason([array indexOfObjectWithPredicate:[NSPredicate predicateWithValue:YES]], @"invalidated");
    RLMAssertThrowsWithReason([array objectsWhere:@"TRUEPREDICATE"], @"invalidated");
    RLMAssertThrowsWithReason([array objectsWithPredicate:[NSPredicate predicateWithValue:YES]], @"invalidated");
    RLMAssertThrowsWithReason([array sortedResultsUsingKeyPath:@"intCol" ascending:YES], @"invalidated");
    RLMAssertThrowsWithReason([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"intCol" ascending:YES]]], @"invalidated");
    RLMAssertThrowsWithReason(array[0], @"invalidated");
    RLMAssertThrowsWithReason(array[0] = @0, @"invalidated");
    RLMAssertThrowsWithReason([array valueForKey:@"intCol"], @"invalidated");
    RLMAssertThrowsWithReason([array setValue:@1 forKey:@"intCol"], @"invalidated");
    RLMAssertThrowsWithReason({for (__unused id obj in array);}, @"invalidated");

    [realm beginWriteTransaction];
}

- (void)testMutatingMethodsCheckForWriteTransaction {
    RLMArray *array = managed.intObj;
    [array addObject:@0];
    [realm commitWriteTransaction];

    XCTAssertNoThrow([array objectClassName]);
    XCTAssertNoThrow([array realm]);
    XCTAssertNoThrow([array isInvalidated]);

    XCTAssertNoThrow([array count]);
    XCTAssertNoThrow([array objectAtIndex:0]);
    XCTAssertNoThrow([array firstObject]);
    XCTAssertNoThrow([array lastObject]);

    XCTAssertNoThrow([array indexOfObject:[IntObject allObjects].firstObject]);
    XCTAssertNoThrow([array indexOfObjectWhere:@"TRUEPREDICATE"]);
    XCTAssertNoThrow([array indexOfObjectWithPredicate:[NSPredicate predicateWithValue:YES]]);
    XCTAssertNoThrow([array objectsWhere:@"TRUEPREDICATE"]);
    XCTAssertNoThrow([array objectsWithPredicate:[NSPredicate predicateWithValue:YES]]);
    XCTAssertNoThrow([array sortedResultsUsingKeyPath:@"self" ascending:YES]);
    XCTAssertNoThrow([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"self" ascending:YES]]]);
    XCTAssertNoThrow(array[0]);
    XCTAssertNoThrow([array valueForKey:@"self"]);
    XCTAssertNoThrow({for (__unused id obj in array);});


    RLMAssertThrowsWithReason([array addObject:@0], @"write transaction");
    RLMAssertThrowsWithReason([array addObjects:@[@0]], @"write transaction");
    RLMAssertThrowsWithReason([array insertObject:@0 atIndex:0], @"write transaction");
    RLMAssertThrowsWithReason([array removeObjectAtIndex:0], @"write transaction");
    RLMAssertThrowsWithReason([array removeLastObject], @"write transaction");
    RLMAssertThrowsWithReason([array removeAllObjects], @"write transaction");
    RLMAssertThrowsWithReason([array replaceObjectAtIndex:0 withObject:@0], @"write transaction");
    RLMAssertThrowsWithReason([array moveObjectAtIndex:0 toIndex:1], @"write transaction");
    RLMAssertThrowsWithReason([array exchangeObjectAtIndex:0 withObjectAtIndex:1], @"write transaction");

    RLMAssertThrowsWithReason(array[0] = @0, @"write transaction");
    RLMAssertThrowsWithReason([array setValue:@1 forKey:@"intCol"], @"write transaction");
}

- (void)testDeleteOwningObject {
    RLMArray *array = managed.intObj;
    XCTAssertFalse(array.isInvalidated);
    [realm deleteObject:managed];
    XCTAssertTrue(array.isInvalidated);
}

- (void)testDeleteOwningObjectDuringEnumeration {
}

- (void)testNotificationSentInitially {
    [realm commitWriteTransaction];

    id expectation = [self expectationWithDescription:@""];
    id token = [managed.intObj addNotificationBlock:^(RLMArray *array, RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssertNil(change);
        XCTAssertNil(error);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:2.0 handler:nil];
    [(RLMNotificationToken *)token stop];
}

- (void)testNotificationSentAfterCommit {
    [realm commitWriteTransaction];

    __block bool first = true;
    __block id expectation = [self expectationWithDescription:@""];
    id token = [managed.intObj addNotificationBlock:^(RLMArray *array, RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssertNil(error);
        if (first) {
            XCTAssertNil(change);
        }
        else {
            XCTAssertEqualObjects(change.insertions, @[@0]);
        }

        first = false;
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    expectation = [self expectationWithDescription:@""];
    [self dispatchAsyncAndWait:^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            RLMArray *array = [(AllPrimitiveArrays *)[AllPrimitiveArrays allObjectsInRealm:realm].firstObject intObj];
            [array addObject:@0];
        }];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    [(RLMNotificationToken *)token stop];
}

- (void)testNotificationNotSentForUnrelatedChange {
    [realm commitWriteTransaction];

    id expectation = [self expectationWithDescription:@""];
    id token = [managed.intObj addNotificationBlock:^(__unused RLMArray *array, __unused RLMCollectionChange *change, __unused NSError *error) {
        // will throw if it's incorrectly called a second time due to the
        // unrelated write transaction
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    // All notification blocks are called as part of a single runloop event, so
    // waiting for this one also waits for the above one to get a chance to run
    [self waitForNotification:RLMRealmDidChangeNotification realm:realm block:^{
        [self dispatchAsyncAndWait:^{
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                [AllPrimitiveArrays createInRealm:realm withValue:@[]];
            }];
        }];
    }];
    [(RLMNotificationToken *)token stop];
}

- (void)testNotificationSentOnlyForActualRefresh {
    [realm commitWriteTransaction];

    __block id expectation = [self expectationWithDescription:@""];
    id token = [managed.intObj addNotificationBlock:^(RLMArray *array, __unused RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssertNil(error);
        // will throw if it's called a second time before we create the new
        // expectation object immediately before manually refreshing
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    // Turn off autorefresh, so the background commit should not result in a notification
    realm.autorefresh = NO;

    // All notification blocks are called as part of a single runloop event, so
    // waiting for this one also waits for the above one to get a chance to run
    [self waitForNotification:RLMRealmRefreshRequiredNotification realm:realm block:^{
        [self dispatchAsyncAndWait:^{
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                RLMArray *array = [(AllPrimitiveArrays *)[AllPrimitiveArrays allObjectsInRealm:realm].firstObject intObj];
                [array addObject:@0];
            }];
        }];
    }];

    expectation = [self expectationWithDescription:@""];
    [realm refresh];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    [(RLMNotificationToken *)token stop];
}

- (void)testDeletingObjectWithNotificationsRegistered {
    [managed.intObj addObjects:@[@10, @20]];
    [realm commitWriteTransaction];

    __block bool first = true;
    __block id expectation = [self expectationWithDescription:@""];
    id token = [managed.intObj addNotificationBlock:^(RLMArray *array, RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssertNil(error);
        if (first) {
            XCTAssertNil(change);
        }
        else {
            XCTAssertEqualObjects(change.deletions, (@[@0, @1]));
        }
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    [realm beginWriteTransaction];
    [realm deleteObject:managed];
    [realm commitWriteTransaction];

    expectation = [self expectationWithDescription:@""];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    [(RLMNotificationToken *)token stop];
}

#if 0
- (void)testValueForKey {
    RLMRealm *realm = self.realmWithTestPath;

    [realm beginWriteTransaction];
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    XCTAssertEqualObjects([company.employees valueForKey:@"name"], @[]);
    [realm addObject:company];
    [realm commitWriteTransaction];

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], @[]);

    // managed
    NSMutableArray *ages = [NSMutableArray array];
    [realm beginWriteTransaction];
    for (int i = 0; i < 30; ++i) {
        [ages addObject:@(i)];
        EmployeeObject *eo = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Joe",  @"age": @(i), @"hired": @YES}];
        [company.employees addObject:eo];
    }
    [realm commitWriteTransaction];

    RLM_GENERIC_ARRAY(EmployeeObject) *employeeObjects = [company valueForKey:@"employees"];
    NSMutableArray *kvcAgeProperties = [NSMutableArray array];
    for (EmployeeObject *employee in employeeObjects) {
        [kvcAgeProperties addObject:@(employee.age)];
    }
    XCTAssertEqualObjects(kvcAgeProperties, ages);

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], ages);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] firstObject] isEqualToObject:company.employees.firstObject]);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] lastObject] isEqualToObject:company.employees.lastObject]);

    XCTAssertEqual([[company.employees valueForKeyPath:@"@count"] integerValue], 30);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@min.age"] integerValue], 0);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@max.age"] integerValue], 29);
    XCTAssertEqualWithAccuracy([[company.employees valueForKeyPath:@"@avg.age"] doubleValue], 14.5, 0.1f);

    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@unionOfObjects.age"],
                          (@[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23, @24, @25, @26, @27, @28, @29]));
    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@distinctUnionOfObjects.name"], (@[@"Joe"]));

    RLMAssertThrowsWithReasonMatching([company.employees valueForKeyPath:@"@sum.dogs.@sum.age"], @"Nested key paths.*not supported");

    // unmanaged object
    company = [[CompanyObject alloc] init];
    ages = [NSMutableArray array];
    for (int i = 0; i < 30; ++i) {
        [ages addObject:@(i)];
        EmployeeObject *eo = [[EmployeeObject alloc] initWithValue:@{@"name": @"Joe",  @"age": @(i), @"hired": @YES}];
        [company.employees addObject:eo];
    }

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], ages);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] firstObject] isEqualToObject:company.employees.firstObject]);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] lastObject] isEqualToObject:company.employees.lastObject]);

    XCTAssertEqual([[company.employees valueForKeyPath:@"@count"] integerValue], 30);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@min.age"] integerValue], 0);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@max.age"] integerValue], 29);
    XCTAssertEqualWithAccuracy([[company.employees valueForKeyPath:@"@avg.age"] doubleValue], 14.5, 0.1f);

    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@unionOfObjects.age"],
                          (@[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23, @24, @25, @26, @27, @28, @29]));
    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@distinctUnionOfObjects.name"], (@[@"Joe"]));

    RLMAssertThrowsWithReasonMatching([company.employees valueForKeyPath:@"@sum.dogs.@sum.age"], @"Nested key paths.*not supported");
}

- (void)testValueForCollectionOperationKeyPath {
    RLMRealm *realm = [RLMRealm defaultRealm];

    [realm beginWriteTransaction];
    EmployeeObject *e1 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"A", @"age": @20, @"hired": @YES}];
    EmployeeObject *e2 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"B", @"age": @30, @"hired": @NO}];
    EmployeeObject *e3 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"C", @"age": @40, @"hired": @YES}];
    EmployeeObject *e4 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"D", @"age": @50, @"hired": @YES}];
    PrimaryCompanyObject *c1 = [PrimaryCompanyObject createInRealm:realm withValue:@{@"name": @"ABC AG", @"employees": @[e1, e2, e3, e2]}];
    PrimaryCompanyObject *c2 = [PrimaryCompanyObject createInRealm:realm withValue:@{@"name": @"ABC AG 2", @"employees": @[e1, e4]}];

    ArrayOfPrimaryCompanies *companies = [ArrayOfPrimaryCompanies createInRealm:realm withValue:@[@[c1, c2]]];
    [realm commitWriteTransaction];

    // count operator
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@count"] integerValue], 4);

    // numeric operators
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@min.age"] intValue], 20);
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@max.age"] intValue], 40);
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@sum.age"] integerValue], 120);
    XCTAssertEqualWithAccuracy([[c1.employees valueForKeyPath:@"@avg.age"] doubleValue], 30, 0.1f);

    // collection
    XCTAssertEqualObjects([c1.employees valueForKeyPath:@"@unionOfObjects.name"],
                          (@[@"A", @"B", @"C", @"B"]));
    XCTAssertEqualObjects([[c1.employees valueForKeyPath:@"@distinctUnionOfObjects.name"] sortedArrayUsingSelector:@selector(compare:)],
                          (@[@"A", @"B", @"C"]));
    XCTAssertEqualObjects([companies.companies valueForKeyPath:@"@unionOfArrays.employees"],
                          (@[e1, e2, e3, e2, e1, e4]));
    NSComparator cmp = ^NSComparisonResult(id obj1, id obj2) { return [[obj1 name] compare:[obj2 name]]; };
    XCTAssertEqualObjects([[companies.companies valueForKeyPath:@"@distinctUnionOfArrays.employees"] sortedArrayUsingComparator:cmp],
                          (@[e1, e2, e3, e4]));

    // invalid key paths
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@invalid.name"],
                                      @"Unsupported KVC collection operator found in key path '@invalid.name'");
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@sum"],
                                      @"Missing key path for KVC collection operator sum in key path '@sum'");
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@sum."],
                                      @"Missing key path for KVC collection operator sum in key path '@sum.'");
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@sum.employees.@sum.age"],
                                      @"Nested key paths.*not supported");
}

- (void)testArrayDescription {
    RLMRealm *realm = [RLMRealm defaultRealm];

    [realm beginWriteTransaction];
    RLMArray<EmployeeObject *> *employees = [CompanyObject createInDefaultRealmWithValue:@[@"company"]].employees;
    RLMArray<NSNumber *> *ints = [AllPrimitiveArrays createInDefaultRealmWithValue:@[]].intObj;
    for (NSInteger i = 0; i < 1012; ++i) {
        EmployeeObject *person = [[EmployeeObject alloc] init];
        person.name = @"Mary";
        person.age = 24;
        person.hired = YES;
        [employees addObject:person];
        [ints addObject:@(i + 100)];
    }
    [realm commitWriteTransaction];

    RLMAssertMatches(employees.description,
                     @"(?s)RLMArray\\<EmployeeObject\\> \\<0x[a-z0-9]+\\> \\(\n"
                     @"\t\\[0\\] EmployeeObject \\{\n"
                     @"\t\tname = Mary;\n"
                     @"\t\tage = 24;\n"
                     @"\t\thired = 1;\n"
                     @"\t\\},\n"
                     @".*\n"
                     @"\t... 912 objects skipped.\n"
                     @"\\)");
    RLMAssertMatches(ints.description,
                     @"(?s)RLMArray\\<int\\> \\<0x[a-z0-9]+\\> \\(\n"
                     @"\t\\[0\\] 100,\n"
                     @"\t\\[1\\] 101,\n"
                     @"\t\\[2\\] 102,\n"
                     @".*\n"
                     @"\t... 912 objects skipped.\n"
                     @"\\)");
}

- (void)testAssignIncorrectType {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm
                                                          withValue:@[@"", @[@[@"a"]], @[@[@0]]]];
    RLMAssertThrowsWithReason(array.intArray = (id)array.array,
                              @"Object of type (StringObject) does not match List type");
    RLMAssertThrowsWithReason(array[@"intArray"] = array[@"array"],
                              @"Invalid property value");
    [realm cancelWriteTransaction];
}

#endif
@end
