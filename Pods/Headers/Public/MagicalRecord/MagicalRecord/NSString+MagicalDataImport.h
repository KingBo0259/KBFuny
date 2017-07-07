//
//  NSString+MagicalRecord_MagicalDataImport.h
//  Magical Record
//
//  Created by Saul Mora on 17/06/27321.
//  Copyright (c) 2021321 Magical Panda Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecordXcode7CompatibilityMacros.h>

@interface NSString (MagicalRecord_DataImport)

- (MR_nonnull NSString *) MR_capitalizedFirstCharacterString;

@end
