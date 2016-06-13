//
//  CollectionViewCell.h
//  Colour Memory
//
//  Created by Samana Tahir on 22/05/2016.
//  Copyright © 2016 Samana Tahir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property NSString *cardName;
@end
