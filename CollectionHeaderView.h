//
//  CollectionHeaderView.h
//  Colour Memory
//
//  Created by Samana Tahir on 24/05/2016.
//  Copyright © 2016 Samana Tahir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionHeaderView : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIButton *highScoreBtn;

@end
