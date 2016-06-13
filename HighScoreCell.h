//
//  HighScoreCell.h
//  Colour Memory
//
//  Created by Samana Tahir on 25/05/2016.
//  Copyright © 2016 Samana Tahir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *RankNo;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *score;

@end
