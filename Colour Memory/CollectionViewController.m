//
//  CollectionViewController.m
//  Colour Memory
//
//  Created by Samana Tahir on 22/05/2016.
//  Copyright © 2016 Samana Tahir. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "CollectionHeaderView.h"
#import "HighScoreController.h"
@interface CollectionViewController ()
{
    NSMutableArray *cardImages;
    CollectionViewCell *previousSelectedCard;
    int noOfselectedCard;
    BOOL isGameFinsh;
    int score;
    NSInteger highScore;
    CollectionHeaderView *headerView;
}
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadData];
   
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
  // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}
//- (IBAction)highScorebtnPressed:(id)sender {
//    
//    HighScoreController *highScoreController = [[HighScoreController alloc] initWithNibName:@"HighScoreController" bundle:nil];
//    
//    [[self navigationController] pushViewController:highScoreController animated:YES];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)LoadData
{
    cardImages = [[NSMutableArray alloc]initWithObjects:@"colour1.png", @"colour2.png", @"colour3.png", @"colour4.png", @"colour5.png", @"colour6.png", @"colour7.png", @"colour8.png", @"colour1.png", @"colour2.png", @"colour3.png", @"colour4.png", @"colour5.png", @"colour6.png", @"colour7.png", @"colour8.png", nil];
    
    [self shuffle];
    score=0;
    headerView.scoreLabel.text = [NSString stringWithFormat:@"Score :%d", score];
    
}

- (void)shuffle
{
    //shuffle the cards randomly
    NSInteger count = cardImages.count;
    for (int i = 0; i < count; i++) {
        [cardImages exchangeObjectAtIndex:i withObjectAtIndex:arc4random() % count];
    }
    
}

-(void)cardFacedownAnimation:(CollectionViewCell*) cell
{
    [UIView transitionWithView:cell duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                           [self.collectionView setUserInteractionEnabled:NO];
                           cell.imageView.image = [UIImage imageNamed:@"card_bg.png"];
                           
                       } completion:^(BOOL finished) {
                           [self.collectionView setUserInteractionEnabled:YES];
                               [cell setUserInteractionEnabled:YES];
                           
                       }];
    
}

- (void)alertTextFieldDidChange:(UITextField *)sender
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController)
    {
        UITextField *username = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = username.text.length > 0;
    }
}

-(void)EnterUserInfo
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:[NSString stringWithFormat:@"Game Over Your Score is %d",score]
                                          message:@"Enter UserName"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"name", @"UserName");
         [textField addTarget:self
                       action:@selector(alertTextFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
     }];
    
    
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   
                                   UITextField *username = alertController.textFields.firstObject;
                                   
                                   NSString *key = [NSString stringWithFormat:@"UserInfo%@",username.text];
                                   
                                   ///////////////////////CheckCurrentHighScore///////////////////////////////////////
                                   highScore  = [[[NSUserDefaults standardUserDefaults] objectForKey:key] integerValue];
                                   if(score > highScore)
                                   {
                                       highScore = score;
                                   }
                                   else if(score<0)
                                   {
                                       highScore = score;   ///// for negative values
                                       
                                   }
                                   
                                   
                                   //////////////////////SaveUserInfo///////////////////////////////////
                                   
                                   NSLog(@"userinfotoStorekey   %@",key);
                                   NSUserDefaults *defaultsUserName = [NSUserDefaults standardUserDefaults];
                                   [defaultsUserName setObject:[NSNumber numberWithInteger:highScore] forKey:key];
                                   [defaultsUserName synchronize];
                                  //////////////////////////////////////////////////////////////////
                                   
                                   /////////////////////restartGame/////////////////////////////
                                   [self LoadData];
                                   [self.collectionView reloadData];
                                   
                               }];
    
    
    
    [alertController addAction:okAction];
    
    
    
    okAction.enabled = NO;
    
    [alertController.view setNeedsLayout];
    [self presentViewController:alertController animated:YES completion:nil];
    
}



-(void)cardFaceUpAnimation:(CollectionViewCell*) cell withTheImage:(UIImage*) image
{
    [UIView transitionWithView:cell duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                           [self.collectionView setUserInteractionEnabled:NO];
                          // cell.imageView.image = [UIImage imageNamed:[cardImages objectAtIndex:indexPath.row]];
                           cell.imageView.image = image;
                            } completion:^(BOOL finished) {
                                 [self.collectionView setUserInteractionEnabled:YES];
 //////////////////////////////////////Check if Pair is Selected/////////////////////////////////////////////
                                if(noOfselectedCard == 2)
                                {
                                    noOfselectedCard = 0;
                                    
                                    if([previousSelectedCard.cardName isEqualToString:cell.cardName]) /// compare two cards
                                    {
                                        NSLog(@"MATCH FOUND");  //match found
                                        score = score + 2;
                                        
                                        
                                            
                                            // Delete the items from the data source.

                                        [cardImages removeObject:previousSelectedCard.cardName];
                                         [cardImages removeObject:cell.cardName];
                                        
                                        
                                        [previousSelectedCard removeFromSuperview];
                                        [cell removeFromSuperview];
                                        
                                       /////////////////Check if cardsImages is empty////////////////////////////////
                                        if([cardImages count] == 0 )
                                        {
                                            isGameFinsh = YES;
                                            NSLog(@"score %d",score);
                                            NSLog(@"Game Finish");
                                            
                                            
                                            
                                            
         
                                        }
                                    
                                       [self.collectionView reloadData];
                                        

                                        
                                    }
                                    else{
                                        score = score - 1;
                                        [self cardFacedownAnimation:cell];
                                        [self cardFacedownAnimation:previousSelectedCard];

                                        
                                    }
                                  
                                    [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self
                                                                   selector: @selector(updateScore) userInfo: nil repeats: NO];
                                    
                                }
                                else{
                                    previousSelectedCard = cell;
                                    
                                }
                           
                           
                          
                           
                           
                       }];
    
}
-(void) updateScore
{
    headerView.scoreLabel.text = [NSString stringWithFormat:@"Score :%d", score];
    if(isGameFinsh == YES)
    {
        
        [self EnterUserInfo];

    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [cardImages count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.scoreLabel.text = [NSString stringWithFormat:@"Score :%d", score];
        reusableview = headerView;
    }
    
        
    return reusableview;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"card_bg.png"];
    [cell setUserInteractionEnabled:YES];
  
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // static NSString *identifier = @"Cell";
    CollectionViewCell *cell = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];

    noOfselectedCard++;
    cell.cardName = [cardImages objectAtIndex:indexPath.row];
    [cell setUserInteractionEnabled:NO];

    
  ////////////////////// Flip Card Animation////////////////////////////////////
  [self cardFaceUpAnimation:cell withTheImage:[UIImage imageNamed:[cardImages objectAtIndex:indexPath.row]]];

    
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
