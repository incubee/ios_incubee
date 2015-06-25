//
//  ICCardViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 23/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICCardViewController.h"

#define SWIPE_MOVE 100.0f


@interface ICCardViewController ()

@end

@implementation ICCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIPanGestureRecognizer *gestureRecognizerA = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    
    [_cardView addGestureRecognizer:gestureRecognizerA];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)twitterTapped:(id)sender {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (IBAction)facebookTapped:(id)sender {
    
    NSArray * activityItems = @[[NSString stringWithFormat:@"This is Awesome Project."], [NSURL URLWithString:[_project valueForKey:@"company_url"]],[NSURL URLWithString:[_project valueForKey:@"twitter_url"]]];
    NSArray * applicationActivities =nil;
    NSArray * excludeActivities = @[UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage,
                                    UIActivityTypeMail,
                                    UIActivityTypePrint,
                                    UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact,
                                    UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,
                                    UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop
                                    ];
    
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityController.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityController animated:YES completion:nil];
    
}


-(void)dragging:(UIPanGestureRecognizer *)gesture
{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        _panCoord = [gesture locationInView:self.view];

        _originalFrame = _cardView.frame;
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint newCoord = [gesture locationInView:self.view];
        
        float dX = newCoord.x-_panCoord.x;
        
        float dY = newCoord.y-_panCoord.y;
        
        if(dX > SWIPE_MOVE)
        {
            [_delegate followProject];
        }
        else if( dX < (-(SWIPE_MOVE)))
        {
            [_delegate followProject];
        }
        _cardView.frame = _originalFrame;
        
    }
    else if(gesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint newCoord = [gesture locationInView:gesture.view];
        
        float dX = newCoord.x-_panCoord.x;
        
        float dY = newCoord.y-_panCoord.y;
        
        _cardView.frame = CGRectMake(_cardView.frame.origin.x+dX, _cardView.frame.origin.y+dY, _cardView.frame.size.width, _cardView.frame.size.height);
        
        
    }
    
}

-(void)showProject{

    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:[_project valueForKey:@"video"]]];
    
    [_moviePlayer.view setFrame:CGRectMake(0, 0, _moviePlayerView.frame.size.width, _moviePlayerView.frame.size.height)];
    _moviePlayer.controlStyle =  MPMovieControlStyleEmbedded;
    _moviePlayer.shouldAutoplay=YES;
    _moviePlayer.repeatMode = NO;
    [_moviePlayer setFullscreen:YES animated:NO];
    _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [_moviePlayer prepareToPlay];
    
    
    [_moviePlayer.view setBackgroundColor:[UIColor redColor]];
    
    [self.moviePlayerView addSubview:_moviePlayer.view];

//    [_moviePlayer play];
    
    
    _projectTitleLable.text = [_project valueForKey:@"company_name"];
    
    _projectOwnerLable.text = [_project valueForKey:@"founder"];
    
    _projectDescLable.text = [_project valueForKey:@"description"];
    
    NSArray *imArray = [_project valueForKey:@"images"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
    NSString *urlString1 = [imArray objectAtIndex:0];
    NSString *urlString2 = [imArray objectAtIndex:1];
    NSString *urlString3 = [imArray objectAtIndex:2];
    NSString *urlString4 = [imArray objectAtIndex:3];
        
    NSData *downloadedData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString1]];
    NSData *downloadedData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString2]];
    NSData *downloadedData3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString3]];
    NSData *downloadedData4 = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString4]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (downloadedData1)
            {
                _im1.image = [UIImage imageWithData:downloadedData1];
            }
            
            if (downloadedData2)
            {
                _im2.image = [UIImage imageWithData:downloadedData2];
            }

            if (downloadedData3)
            {
                _im3.image = [UIImage imageWithData:downloadedData3];
            }

            if (downloadedData4)
            {
                _im4.image = [UIImage imageWithData:downloadedData4];
            }

            
        });
    });

    
}


-(void)stopShowingProj{

    [_moviePlayer stop];
    
    [_moviePlayer.view removeFromSuperview];
    
    _moviePlayer = nil;

}
@end
