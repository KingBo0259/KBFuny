//
//  KBCoreDataMananger.m
//  KBFuny
//
//  Created by jinlb on 16/4/28.
//  Copyright © 2016年 jinlb. All rights reserved.
//

#import "KBCoreDataMananger.h"

@implementation KBCoreDataMananger
@synthesize managedObjectContext=_managedObjectContext;
@synthesize managedObjectModel=_managedObjectModel;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;

#pragma mark Instance
+(KBCoreDataMananger*)sharedInstance{
    static KBCoreDataMananger*_sharedInstace=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken
                  , ^{
                      _sharedInstace=[KBCoreDataMananger new];
                  });
    
    return _sharedInstace;

}


#pragma mark 托管对象

-(NSManagedObjectModel*)managedObjectModel{

    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *model=[[NSBundle mainBundle] URLForResource:[self coreDataName] withExtension:@"momd"];
    
    _managedObjectModel=[[NSManagedObjectModel alloc]initWithContentsOfURL:model];
    
    return _managedObjectModel;

}


-(NSString*)coreDataName{

    return @"KCModel";

}

#pragma mark 持久化存储协调器

-(NSURL*)applicationDocumentsDirectory{
    
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSPersistentStoreCoordinator*)persistentStoreCoordinator{

    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    //create coordinator and store
    _persistentStoreCoordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *storeURL=[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"KBCoredata.sqlite"];
    
    NSError *error=nil;
    NSString* failureReason=@"These was  an error  creating or loading the appliation's saved data.";
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        
        dict[NSUnderlyingErrorKey] = error;
        
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        
        // Replace this with code to handle the error appropriately.
        
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
//        abort();
        
        
    
    }
    return _persistentStoreCoordinator;
}

#pragma mark 托管上下文
-(NSManagedObjectContext*)managedObjectContext{

    if (_managedObjectContext) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator=[self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    
    /*
     * 上下问设置为 ;privateQueueConcurrencyType 后  就可以使用 performBlock  或则 performBlockAndWait;
     */
    _managedObjectContext=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - coreData Saving support
-(void)saveContext{

    NSManagedObjectContext *managedObjectContext=self.managedObjectContext;
    if (!managedObjectContext) return;
    
    NSError *error=nil;
    if ([managedObjectContext hasChanges]&&![managedObjectContext save:&error]) {
        
    }


}
@end
