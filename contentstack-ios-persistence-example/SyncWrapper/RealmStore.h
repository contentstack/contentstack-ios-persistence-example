//
//  SyncRealm.h
//  ContentstackCoreDataDemo
//
//  Created by Uttam Ukkoji on 30/07/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyncPersistable.h"
#import <Realm/Realm.h>
@interface RealmStore : NSObject <PersistanceDelegate>
-(instancetype)initWithRealm:(RLMRealm*)realm;
@end

