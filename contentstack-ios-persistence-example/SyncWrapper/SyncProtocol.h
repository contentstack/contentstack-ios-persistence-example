//
//  SyncProtocol.h
//  ContentstackCoreDataDemo
//
//  Created by Uttam Ukkoji on 30/07/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

#ifndef SyncProtocol_h
#define SyncProtocol_h

@protocol ContentStackProtocol<NSObject>
@required
@property (nonatomic)NSString *title;
@property (nonatomic)NSString *url;
@property (nonatomic)NSString *uid;
@property (nonatomic)NSString *publishLocale;
@property (nonatomic)NSDate *createdAt;
@property (nonatomic)NSDate *updatedAt;
@end

@protocol SyncStoreProtocol<NSObject>
@required
@property (nonatomic)NSString* paginationToken;
@property (nonatomic)NSString* syncToken;
@end

@protocol EntryProtocol<ContentStackProtocol>
@required
@property (nonatomic)NSString *locale;
+(NSString*)contentTypeid;
+(NSDictionary *)fieldMapping;
@end

@protocol EntryGroupProtocol
@required
+(NSDictionary *)fieldMapping;
@end

@protocol AssetProtocol<ContentStackProtocol>
@required
@property (nonatomic)NSString *fileName;
@property (nonatomic)NSString *url;
@end
#endif /* SyncProtocol_h */

