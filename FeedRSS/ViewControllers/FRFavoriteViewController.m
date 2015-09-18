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




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"ViewFavoriteAction"]) {
        
        NSIndexPath *indexPath = [self.tblFavorite indexPathForSelectedRow];
        
        FRDetailViewController *destViewController = segue.destinationViewController;
        
        destViewController.Url = @"http://www.dantri.com.vn";
        
    }

}

@end
