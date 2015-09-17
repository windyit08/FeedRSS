//
//  FRFavoriteViewController.m
//  FeedRSS
//
//  Created by KinhNM1 on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRFavoriteViewController.h"
#import "SimpleTableCell.h"
#import "FRDetailViewController.h"
#import "FRPost.h"

@interface FRFavoriteViewController ()

@end

@implementation FRFavoriteViewController
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
@synthesize posts;
@synthesize table;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"FRPost" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.posts = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.title = @"Posts";
       [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([SimpleTableCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SimpleTableCell class])];
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


/**LIST VIEW*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.posts.count;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"cellForRowAtIndexPath(index): %ld",indexPath.row);
    
    
   {
        SimpleTableCell * cell = nil;
        
        static NSString *simpleTableIndentifier = @"SimpleTableCell";
        NSLog(@"cellForRowAtIndexPath(index): %ld 1",indexPath.row);
        cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIndentifier];
        NSLog(@"cellForRowAtIndexPath(index): %ld 2",indexPath.row);
        if(cell == nil){
            NSLog(@"cellForRowAtIndexPath(index): %ld 3",indexPath.row);
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
            NSLog(@"cellForRowAtIndexPath(index): %ld 4",indexPath.row);
            cell = [nib objectAtIndex:0];
            NSLog(@"cellForRowAtIndexPath(index): %ld 5",indexPath.row);
        }
       FRPost *post = [posts objectAtIndex:indexPath.row];
       cell.nameLabel.text = post.title;
        //cell.nameLabel.text = @" Favorite";
        //cell.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
        //cell.thumbnailImageView.image = [UIImage imageNamed:@"husky.jpg"];
        
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
       [self performSegueWithIdentifier:@"ViewFavoriteAction" sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 78;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepareForSegue");
    
    if ([segue.identifier isEqualToString:@"ViewFavoriteAction"]) {
        
        NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
        
        FRDetailViewController *destViewController = segue.destinationViewController;
        
        destViewController.Url = @"http://www.dantri.com.vn";
        
    }
    
    
    
}

@end
