//
//  ICChatTableViewCell.m
//  Incubee
//
//  Created by Rithesh Rao on 20/08/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICChatTableViewCell.h"
#import "Messages.h"

@implementation ICChatTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        return self;
    }

    return nil;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMessage:(Messages *)message{

    _message = message;
    
    if([_message.dir isEqualToString:@"O"])
    {
        _incomingView.hidden = YES;
        
        _outgoingView.hidden = NO;
        
        _outgoingChatLable.text = _message.body;
        
        UIImage *im  = [[UIImage imageNamed:@"OutgoingChatBubble"] stretchableImageWithLeftCapWidth:5 topCapHeight:13];

        _outgoingBubbleImageView.image = im;
    }
    else
    {
        
        _incomingView.hidden = NO;
        
        _outgoingView.hidden = YES;
        
        _incomingChatLable.text = _message.body;
        
        UIImage *im  = [[UIImage imageNamed:@"IncomingChatBubble"] stretchableImageWithLeftCapWidth:15 topCapHeight:13];
        
        _incomingBubbleImageView.image = im;
    }
    
}

@end