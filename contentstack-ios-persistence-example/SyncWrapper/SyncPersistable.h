//
//  SyncPersistable.h
//  ContentstackCoreDataDemo
//
//  Created by Uttam Ukkoji on 30/07/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

#ifndef SyncPersistable_h
#define SyncPersistable_h

#endif /* SyncPersistable_h */
#import <CoreData/CoreData.h>
@protocol PersistanceDelegate <NSObject>
@optional
-(void)save; // CoreData Save Operation
-(void)beginWriteTransaction;
-(void)commitWriteTransaction;
@required
-(Class)getSuperClass;
-(id)create:(Class)class;
-(NSDictionary*)relationShipByName:(Class)class;
-(void)delete:(Class)class inUid:(NSArray*)array;
-(void)delete:(NSArray*)array;
-(NSArray*)fetchAll:(Class)class predicate:(NSPredicate*)predicate;
-(Class)classfor:(NSDictionary*)relationshipName forKey:(NSString*)key;
-(BOOL)isToManyRelationfor:(NSDictionary*)relationshipName forKey:(NSString*)key;
@end
