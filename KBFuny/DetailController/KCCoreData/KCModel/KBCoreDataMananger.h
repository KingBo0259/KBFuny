//
//  KBCoreDataMananger.h
//  KBFuny
//
//  Created by jinlb on 16/4/28.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface KBCoreDataMananger : NSObject
@property(nonatomic,strong,readonly)NSManagedObjectContext*managedObjectContext;

@property(nonatomic,strong,readonly)NSManagedObjectModel*managedObjectModel;
@property(nonatomic,strong,readonly)NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(KBCoreDataMananger*)sharedInstance;

-(void)saveContext;

@end
