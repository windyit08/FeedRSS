//
//  FRFavoriteViewController.m
//  FeedRSS
//
//  Created by KinhNM1 on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRFavoriteViewController.h"
#import "FRArticleTableViewCell.h"
#import "FRDetailViewController.h"
#import "FRFavoriteBusinessController.h"

@interface FRFavoriteViewController ()
{
    FRFavoriteBusinessController *favBusinessController;
}

@property (weak, nonatomic) IBOutlet UITableView *tblFavorite;

@end

@implementation FRFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Favorites";
    
    favBusinessController = [[FRFavoriteBusinessController alloc] init];
    self.tblFavorite.dataSource = favBusinessController.dataSource;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak __typeof(self)weakSelf = self;
    [favBusinessController loadAllFavorites:^{
        [weakSelf.tblFavorite reloadData];
    } failure:^(NSString *errorMessage) {
        //Alert
    }];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
       [self performSegueWithIdentifier:@"ViewFavoriteAction" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"ViewFavoriteAction"]) {
        
        NSIndexPath *indexPath = [self.tblFavorite indexPathForSelectedRow];
        
        FRDetailViewController *destViewController = segue.destinationViewController;
        
        destViewController.Url = [favBusinessController getSelectedUrl:indexPath.row];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = [favBusinessController tableView:tableView heightForCellAtIndexPath:indexPath];
    NSLog(@"height = %f", h);
    //return h;
    return 78;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([self isLandscapeOrientation]) {
//        return 100.0f;
//    } else {
//        return 78.0f;
//    }
//}

- (BOOL)isLandscapeOrientation {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
}

@end
