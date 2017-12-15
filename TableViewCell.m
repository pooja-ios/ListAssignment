//
//  TableViewCell.m
//  ListAssignment
//
//  Created by pooja on 30/11/2017.
//  Copyright © 2017 pooja. All rights reserved.
//

#import "TableViewCell.h"
#import "CommonMethods.h"

@interface TableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *desc;
@property (nonatomic, strong) IBOutlet UISwitch *switchBtn;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setup:(NSDictionary *)data
{
    self.title.text = [data objectForKey:@"title"];
    self.desc.text = [CommonMethods getFormattedDate:[data objectForKey:@"created_at"]];
    
    BOOL isSelected = [[data objectForKey:@"selected"] boolValue];
    self.switchBtn.on = isSelected;
    
    if (isSelected) [self setBackgroundColor:[UIColor grayColor]];
    else [self setBackgroundColor:[UIColor clearColor]];
}

-(IBAction)switchSelected:(id)sender
{
    if (self.switchBtn.isOn) [self setBackgroundColor:[UIColor grayColor]];
    else [self setBackgroundColor:[UIColor clearColor]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSelection" object:self];
}

-(void)selectCell:(NSDictionary *)data
{
    BOOL isSelected = [[data objectForKey:@"selected"] boolValue];
    self.switchBtn.on = isSelected;
    
    if (isSelected) [self setBackgroundColor:[UIColor grayColor]];
    else [self setBackgroundColor:[UIColor clearColor]];
}

@end
