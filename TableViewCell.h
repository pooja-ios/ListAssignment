//
//  TableViewCell.h
//  ListAssignment
//
//  Created by pooja on 30/11/2017.
//  Copyright © 2017 pooja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

-(void)setup:(NSDictionary *)data;
-(void)selectCell:(NSDictionary *)data;

@end
