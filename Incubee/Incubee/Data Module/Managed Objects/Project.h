//
//  Project.h
//  Incubee
//
//  Created by Rithesh Rao on 26/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectImage;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * companyDescription;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * companyUrl;
@property (nonatomic, retain) NSString * contactEmail;
@property (nonatomic, retain) NSString * field;
@property (nonatomic, retain) NSString * founder;
@property (nonatomic, retain) NSString * funding;
@property (nonatomic, retain) NSString * high_concept;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * logo_url;
@property (nonatomic, retain) NSString * project_status;
@property (nonatomic, retain) NSString * twitter_url;
@property (nonatomic, retain) NSString * video;
@property (nonatomic, retain) NSString * videoUrl;
@property (nonatomic, retain) NSSet *projImages;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addProjImagesObject:(ProjectImage *)value;
- (void)removeProjImagesObject:(ProjectImage *)value;
- (void)addProjImages:(NSSet *)values;
- (void)removeProjImages:(NSSet *)values;

@end
