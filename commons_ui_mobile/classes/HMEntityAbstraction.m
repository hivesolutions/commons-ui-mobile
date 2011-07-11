// Hive Mobile
// Copyright (C) 2008 Hive Solutions Lda.
//
// This file is part of Hive Mobile.
//
// Hive Mobile is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Mobile is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Mobile. If not, see <http://www.gnu.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMEntityAbstraction.h"

@implementation HMEntityAbstraction

@synthesize entityDelegate = _entityDelegate;

- (id)init {
    // calls the super
    self = [super init];

    // returns self
    return self;
}

- (id)initWithEntityDelegate:(NSObject<HMEntityDelegate> *)entityDelegate {
    // calls the super
    self = [super init];

    // sets the attributes;
    self.entityDelegate = entityDelegate;

    // returns self
    return self;
}

- (void)dealloc {
    // calls the super
    [super dealloc];
}

- (NSString *)constructClassUrl:(NSString *)entityName serializerName:(NSString *)serializerName {
    // retrieves the base url
    NSString *baseUrl = [HMEntityAbstraction getBaseUrl];

    // creates the url from the object id
    NSString *url = [NSString stringWithFormat:@"%@/%@.%@", baseUrl, entityName, serializerName];

    // returns the url
    return url;
}

- (NSString *)constructObjectUrl:(NSString *)entityName serializerName:(NSString *)serializerName {
    // retrieves the base url
    NSString *baseUrl = [HMEntityAbstraction getBaseUrl];

    // retrieves the entity object id
    NSNumber *entityObjectId = [self.entityDelegate.entity objectForKey:@"object_id"];

    // creates the url from the object id
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@.%@", baseUrl, entityName, entityObjectId.stringValue, serializerName];

    // returns the url
    return url;
}

- (NSString *)constructObjectCompositeUrl:(NSString *)entityName operationName:(NSString *)operationName serializerName:(NSString *)serializerName {
    // retrieves the base url
    NSString *baseUrl = [HMEntityAbstraction getBaseUrl];

    // retrieves the entity object id
    NSNumber *entityObjectId = [self.entityDelegate.entity objectForKey:@"object_id"];

    // creates the url from the object id
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@.%@", baseUrl, entityName, entityObjectId.stringValue, operationName, serializerName];

    // returns the url
    return url;
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType entityName:(NSString *)entityName serializerName:(NSString *)serializerName {
    // allocates the url
    NSString *url = nil;

    // switches over the operation type
    // in order to retrieve the apropriate url
    switch(operationType) {
        // in case it's a create operation
        case HMItemOperationCreate:
            url = [self constructClassUrl:entityName serializerName:serializerName];

            // breaks the swtich
            break;

        // in case it's a read operation
        case HMItemOperationRead:
            url = [self constructObjectUrl:entityName serializerName:serializerName];

            // breaks the swtich
            break;

        // in case it's an update operation
        case HMItemOperationUpdate:
            url = [self constructObjectCompositeUrl:entityName operationName:@"update" serializerName:serializerName];

            // breaks the swtich
            break;

        // in case it's a delete operation
        case HMItemOperationDelete:
            url = [self constructObjectCompositeUrl:entityName operationName:@"delete" serializerName:serializerName];

            // breaks the swtich
            break;

        // in case it's none of the above operations
        default:
            // breaks the switch
            break;
    }

    // returns the url
    return url;
}

+ (NSString *)getBaseUrl {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // retrieves the base url
    NSString *baseUrl = [preferences valueForKey:@"baseUrl"];

    // returns the base url
    return baseUrl;
}

@end
