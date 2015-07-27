//
//  Item.h
//  Catalog88
//
//  Created by Admin MacBook Pro on 7/25/15.
//  Copyright (c) 2015 elidc93. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;

@end
