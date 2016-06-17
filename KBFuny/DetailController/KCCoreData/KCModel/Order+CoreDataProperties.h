//
//  Order+CoreDataProperties.h
//  KBFuny
//
//  Created by jinlb on 16/4/28.
//  Copyright © 2016年 jinlb. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Order.h"

NS_ASSUME_NONNULL_BEGIN

@interface Order (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *orderId;
@property (nullable, nonatomic, retain) NSString *orderNumer;
@property (nullable, nonatomic, retain) NSDate *createData;

@end

NS_ASSUME_NONNULL_END
