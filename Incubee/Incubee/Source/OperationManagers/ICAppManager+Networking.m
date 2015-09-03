//
//  ICOperationManager+Networking.m
//  Incubee
//
//  Created by Rithesh Rao on 27/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICAppManager+Networking.h"
#import "ICOperationManager.h"
#import "ICNetworkOperation.h"
#import "ICNetworkConstant.h"

#import "User.h"

@implementation ICAppManager (Networking)

#pragma mark - App Manager Utility -

-(void)addRequestActivityObserver:(ICRequest*)inRequest{
    
    ICRequestStatus *status = inRequest.requestStatus;
    
    [status addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:(__bridge void *)inRequest];
    
}

-(void)addReqComplitionListner:(ICRequest*)aRequest forController:(id)aController atSelector:(SEL)inMethod{
    
    aRequest.respondingController = aController;
    
    aRequest.selector = inMethod;
}

-(void)sendRequestObject:(ICRequest*)inRequest{
    
    ICNetworkOperation *operation = [[ICNetworkOperation alloc] initWithRequest:inRequest];
    
    inRequest.requestStatus.status = REQUEST_WAITING_ON_NETWORK;
    
    [[ICOperationManager sharedInstance].networkOperationQueue addOperation:operation];
    
}

#pragma mark - Network Call -
-(void)getAllIncubees:(ICRequest**)inRequest notifyTo:(id)aViewController atSelector:(SEL)inSelector{
    
    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_INCUBEES;
    
    req.requestMethod = ICRequestMethodGet;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];

    req.isTokenRequired = NO;
    
    [req setRequestingURL:[NSURL URLWithString:kGetAllCompanyURL]];
    
    [self sendRequestObject:req];

    
}

-(void)sendGoogleLogin:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GOOGLE_LOGIN_REQUEST;
    
    req.requestMethod = ICRequestMethodPost;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    [req setRequestingURL:[NSURL URLWithString:kGoogleLoginURL]];
    
    User *user = [[ICDataManager sharedInstance] getUser];

    [req.reqDataDict setValue:user.name forKey:@"name"];
    
    [req.reqDataDict setValue:user.userId forKey:@"id"];
    
    [req.reqDataDict setValue:user.email forKey:@"email"];

    req.isTokenRequired = YES;
    
    [self sendRequestObject:req];

}

-(void)sendGoogleSignUp:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GOOGLE_SIGNUP;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    [req setRequestingURL:[NSURL URLWithString:kGoogleSignUpURL]];
    
    User *user = [[ICDataManager sharedInstance] getUser];
    
    [req.reqDataDict setValue:user.name forKey:@"name"];
    
    [req.reqDataDict setValue:user.userId forKey:@"id"];
    
    [req.reqDataDict setValue:user.email forKey:@"email"];
    
    req.isTokenRequired = YES;
    
    [self sendRequestObject:req];
}

-(void)likeProject:(ICRequest**)inRequest withIncubeeId:(NSString*)inCubeeId notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_LIKE_PROJECT;
    
    req.requestMethod = ICRequestMethodPost;

    req.isTokenRequired = YES;

    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    NSDictionary *d = [[NSDictionary alloc] initWithObjectsAndKeys:inCubeeId,@"incubee_id",nil];
    
    [req setOptionalData:(NSMutableDictionary*)d];
    
    [req setRequestingURL:[NSURL URLWithString:kLikeIncubeeURL(inCubeeId,[[ICDataManager sharedInstance] getUserId])]];
        
    [self sendRequestObject:req];

}

-(void)addCustomerProject:(ICRequest**)inRequest withIncubeeId:(NSString*)inCubeeId notifyTo:(id)aViewController forSelector:(SEL)inSelector{
    
    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_ADD_CUSTOMER_PROJECT;
    
    req.requestMethod = ICRequestMethodPost;
    
    req.isTokenRequired = YES;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    NSDictionary *d = [[NSDictionary alloc] initWithObjectsAndKeys:inCubeeId,@"incubee_id",nil];
    
    [req setOptionalData:(NSMutableDictionary*)d];
    
    [req setRequestingURL:[NSURL URLWithString:kAddCustomer(inCubeeId,[[ICDataManager sharedInstance] getUserId])]];
    
    [self sendRequestObject:req];
    
}


-(void)getAllLikedIncubee:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_LIKED_INCUBEES;
    
    req.requestMethod = ICRequestMethodGet;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    req.isTokenRequired = NO;
    
    [req setRequestingURL:[NSURL URLWithString:kAllLikedIncubees([[ICDataManager sharedInstance] getUserId])]];
    
    [self sendRequestObject:req];

}

-(void)getAllCustomerIncubee:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{
    
    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_CUSTOMER_INCUBEES;
    
    req.requestMethod = ICRequestMethodGet;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    req.isTokenRequired = NO;
    
    [req setRequestingURL:[NSURL URLWithString:kAllCustomerIncubees([[ICDataManager sharedInstance] getUserId])]];
    
    [self sendRequestObject:req];
    
    
}


#pragma mark - Chat -
-(void)getAllChat:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_CHAT;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    [req setRequestingURL:[NSURL URLWithString:kGetAllChatMsg([[ICDataManager sharedInstance] getUserId])]];
    
    [self sendRequestObject:req];
    
}

-(void)sendMsg:(ICRequest**)inRequest textMsg:(NSString*)inMsg to:(NSString*)inTo notifyTo:(id)aViewController forSelector:(SEL)inSelector{
    
    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_SEND_CHAT_MSG;
    
    req.isTokenRequired = YES;
    
    req.requestMethod = ICRequestMethodPost;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    [req setRequestingURL:[NSURL URLWithString:ksendChatMsg([[ICDataManager sharedInstance] getUserId])]];
    
    [self sendRequestObject:req];

    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    
    [d setValue:inMsg forKey:@"body"];
    
    [d setValue:[[ICDataManager sharedInstance] getUserId] forKey:@"eid"];
    
    [d setValue:[[ICDataManager sharedInstance] getUserName] forKey:@"name"];
    
    [d setValue:inTo forKey:@"to"];
    
    [d setValue:@"200" forKey:@"longitude"];
    
    [d setValue:@"100" forKey:@"latitude"];
    
    [d setValue:@"USR" forKey:@"type"];
    
    [req setReqDataDict:(NSMutableDictionary*)d];

}


@end
