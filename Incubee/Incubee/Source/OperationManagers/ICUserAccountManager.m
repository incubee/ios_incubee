//
//  ICUserAccountManager.m
//  Incubee
//
//  Created by Rithesh Rao on 16/07/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICUserAccountManager.h"
#import "ICAppManager.h"
#import "ICAppManager+Networking.h"

@implementation ICUserAccountManager

static ICUserAccountManager *sharedUserAccountManagerInstance = nil;

+(ICUserAccountManager*)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedUserAccountManagerInstance = [[self alloc] init];
        
    });
    
    return sharedUserAccountManagerInstance;
}
- (id)init {
    
    if (self = [super init])
    {
        _userLoginBadgeCount = 0;
    }
    
    return self;
}

#pragma mark - GIDSignInDelegate -

// The sign-in flow has finished and was successful if |error| is |nil|.
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error{
    
    NSLog(@"%@ : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));

    if(error==nil)
    {
        NSLog(@"Logged in Succesfully : %@",user);
        
        [[ICDataManager sharedInstance] createOrUpdateGoogleUser:user];
        
        [[ICAppManager sharedInstance] sendGoogleLogin:nil notifyTo:self forSelector:@"loginResponse:"];

    }
    else
    {
        NSLog(@"SignIn Failed : %@",error.localizedDescription);
    }
    

}

// Finished disconnecting |user| from the app successfully if |error| is |nil|.
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error{

        NSLog(@"%@ : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));

}

#pragma mark - User Badge Count -
-(void)updateLoginBadgeCount{

    _userLoginBadgeCount++;
    
    if(_userLoginBadgeCount >=20)
    {
        _userLoginBadgeCount = 0;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowLogin" object:nil];
    }
    
}

- (void)loginResponse:(ICRequest*)inRequest{
    
    if(inRequest.error == nil)
    {
        NSLog(@"Signup + Logged In");
    }
    else
    {
        if(inRequest.error.code == 1003)
        {
            [[ICAppManager sharedInstance] sendGoogleSignUp:nil notifyTo:self forSelector:@"googleSignup:"];
        }
        else
        {
            
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
            
        }
        
    }
    
}

- (void)googleSignup:(ICRequest*)inRequest{

    if(inRequest.error == nil)
    {
        [[ICAppManager sharedInstance] sendGoogleLogin:nil notifyTo:self forSelector:@"loginResponse:"];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];

    }
    
}
@end