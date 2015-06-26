//
//  ProjectImage.h
//  Incubee
//
//  Created by Rithesh Rao on 26/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface ProjectImage : NSManagedObject

@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) Project *project;

@end
