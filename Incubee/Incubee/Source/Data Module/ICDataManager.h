//
//  ICDataManager.h
//  Incubee
//
//  Created by Rithesh Rao on 26/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Google/SignIn.h>

#import "Incubee.h"
#import "IncubeeImage.h"
#import "User.h"
#import "Messages.h"
#import "Customer.h"
#import "Review.h"

@interface ICDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(ICDataManager*)sharedInstance;

-(void)followProject:(NSString*)incubeeId;

-(void)saveProjectList:(NSArray*)inArray;

-(NSArray*)getAllIncubees;

-(NSArray*)getFollowedProjects;

-(NSArray*)getAllCustomer;

-(NSArray*)getImageURLs:(NSString*)inProjectId;

#pragma mark - User -
-(void)createOrUpdateGoogleUser:(GIDGoogleUser *)user;

-(User*)getUser;

-(NSString*)getUserName;

-(NSString*)getUserId;

-(NSString*)getToken;

-(void)setUserAsFounder:(NSString*)inCompanyId;

-(void)setUserMode:(USER_LOGIN_MODE)inUserLoginMode;

-(BOOL)isFounder;

-(BOOL)isInvestor;

-(BOOL)isChatEnabled;

-(NSString*)getFounderId;

-(USER_LOGIN_MODE)getUserLoginMode;

-(NSString*)getUserProfilePic;

#pragma mark - Message - 

-(NSArray*)getMessages:(NSString*)inMsgId;

-(void)saveLikedArray:(NSArray*)inLikedArray;

-(void)saveCustomerArray:(NSArray*)inLikedArray;

-(void)saveChatArray:(NSArray*)inMesgArray;

-(void)updateCustomerDetails:(NSDictionary*)inCustomer;

-(NSString*)getCustomerName:(NSString*)inCustomerId;

-(NSString*)getCustomerPic:(NSString*)inCustomerId;

-(NSString*)getIncubeeName:(NSString*)inIncubeeId;

-(NSArray*)getAllSavedIncubeeChatArray;

#pragma mark - Review -
-(void)saveReviewArray:(NSArray*)inReviewArray;

-(NSArray*)getReviewArray:(NSString*)inIncubeeId;

-(BOOL)isReviewWritten:(NSString*)inIncubeeId;
@end
