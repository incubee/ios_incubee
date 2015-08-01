//
//  PPDataSavingOperations.m
//  PaparazziPass
//
//  Created by Rithesh Rao on 18/06/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import "ICDataSavingOperations.h"
#import "ICDataManager.h"
#import "ICDataManager+DataSaving.h"

@implementation ICDataSavingOperations

-(id)initWithRequest:(ICRequest*)aRequest{

    self = [super init];
    
    if(self!=nil)
    {
        request = aRequest ;
    }
    
    return self;
}

-(void)main{
    
    [[ICDataManager sharedInstance] saveResponse:request];

//    switch (request.requestId) {
//        case IC_GET_ALL_PROJECTS:
//        {
//            [[ICDataManager sharedInstance] saveResponse:request];
//        }
//            break;
//        case IC_LOGIN_REQUEST:
//        {
//            [[ICDataManager sharedInstance] saveResponse:request];
//        }
//            break;
//            
//        case IC_LIKE_PROJECT:
//        {
//        }
//            break;
//            
//        default:
//            break;
//    }
    

}
@end
