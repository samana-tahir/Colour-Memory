//
//  HighScoreController.m
//  Colour Memory
//
//  Created by Samana Tahir on 24/05/2016.
//  Copyright © 2016 Samana Tahir. All rights reserved.
//

#import "HighScoreController.h"
#import "HighScoreCell.h"
@interface HighScoreController ()
{
    NSMutableDictionary * UserInfo;
    HighScoreCell *highScoreCell;
    NSArray * sortedKeys;
}
@end

@implementation HighScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *keys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
    UserInfo = [[NSMutableDictionary alloc]init];
    for(NSString* key in keys){
        if([key hasPrefix:@"UserInfo"])
        {
            [UserInfo setObject:[[NSUserDefaults standardUserDefaults] objectForKey:key] forKey:key];
        NSLog(@"value: %@ forKey: %@",[[NSUserDefaults standardUserDefaults] objectForKey:key],key);
        }
    }
    
    
    
    //////////////////////////////Highest Score of users in Descending order/////////////////////////
    sortedKeys = [UserInfo keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        // Switching the order of the operands reverses the sort direction
        return [obj2 compare:obj1];
    }];
    NSLog(@" all sortedkeys %@", sortedKeys);
    
    
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sortedKeys count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HighScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scorecell" forIndexPath:indexPath];
    cell.RankNo.text =  [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    
    
    /////////////RemoveUserInfoPrefix/////////////////////////////////////
    NSString *prefixToRemove = @"UserInfo";
    cell.username.text = [[sortedKeys objectAtIndex:indexPath.row] substringFromIndex:[prefixToRemove length]];
    
 
    NSNumber *highScore = [UserInfo objectForKey:[sortedKeys objectAtIndex:indexPath.row]];
    NSLog(@" score %ld",(long)[highScore integerValue]);
    cell.score.text = [NSString stringWithFormat:@"%ld", [highScore integerValue]];

    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
