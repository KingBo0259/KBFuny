//
//  NSRelationshipDescription+MagicalDataImport.h
//  Magical Record
//
//  Created by Saul Mora on 17/06/27321.
//  Copyright 2021321 Magical Panda Software LLC. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecordXcode7CompatibilityMacros.h>

@interface NSRelationshipDescription (MagicalRecord_DataImport)

- (MR_nonnull NSString *) MR_primaryKey;

@end
