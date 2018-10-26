//
//  SyncManager.h
//  ContentstackCoreDataDemo
//
//  Created by Uttam Ukkoji on 06/07/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Contentstack/Contentstack.h>
#import "SyncProtocol.h"
#import "SyncPersistable.h"
#import "CoreDataPersistenceHelper.h"
#import "RealmPersistenceHelper.h"

@interface SyncManageSwiftSupport  : NSObject
+ (BOOL)isSwiftClassName:(NSString *_Nonnull)className;
+ (NSString *_Nonnull)demangleClassName:(NSString *_Nonnull)className;
@end

@interface SyncManager : NSObject
-(instancetype _Nonnull )initWithStack:(Stack*_Nonnull)stack persistance:(id<PersistanceDelegate> _Nonnull)delegate;
-(void)sync:(void (^_Nullable) (double percentageComplete, BOOL isSyncCompleted, NSError  * BUILT_NULLABLE_P error))completion;
@end




