//
//  SyncCoreData.h
//  ContentstackCoreDataDemo
//
//  Created by Uttam Ukkoji on 30/07/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyncPersistable.h"
#import <CoreData/CoreData.h>

@interface CoreDataPersistenceHelper : NSObject <PersistanceDelegate>

-(instancetype) initWithContenxt:(NSManagedObjectContext*) context;

@end
