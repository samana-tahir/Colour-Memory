//
//  CollectionViewController.h
//  Colour Memory
//
//  Created by Samana Tahir on 22/05/2016.
//  Copyright © 2016 Samana Tahir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
@interface CollectionViewController : UICollectionViewController
-(void)LoadData;
- (void)shuffle;
-(void)cardFacedownAnimation:(CollectionViewCell*) cell;
-(void) updateScore;
-(void)EnterUserInfo;
@end
