//
//  Test2ViewController.m
//  TableViewHightDemo
//
//  Created by Sky on 15/2/2.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "Test2ViewController.h"
#import "Test2TableViewCell.h"


static NSString *CellIdentifier = @"CellIdentifier";

@interface Test2ViewController ()<UITableViewDelegate,UITableViewDataSource>


// A dictionary of offscreen cells that are used within the tableView:heightForRowAtIndexPath: method to
// handle the height calculations. These are never drawn onscreen. The dictionary is in the format:
//      { NSString *reuseIdentifier : UITableViewCell *offscreenCell, ... }
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;


@property(nonatomic,strong)UITableView* testTableView;


@property(nonatomic,strong)NSArray*  tableData;


@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.testTableView];
    
    self.offscreenCells = [NSMutableDictionary dictionary];

    [self.testTableView registerClass:[Test2TableViewCell class] forCellReuseIdentifier:CellIdentifier];

    
   // self.testTableView.estimatedRowHeight = UITableViewAutomaticDimension;

    self.testTableView.allowsSelection = NO;
    
    self.tableData = @[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890SDL;fkjdsafl;ksdfj阿道夫；拉斯科打飞机阿萨德了；fas;dlfkajsdfl;askdjfals;dkfjasdfl;ksajdfadls;kfajsdfakl;sdfjsadl;kfjasdfkl;asdjfadls;kfjasdfl;kasjdfl;k", @"1\n2", @"1\n2\n3", @"1"];

    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Test2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.bodyLabel.text = [self.tableData objectAtIndex:indexPath.row];
    cell.headImageView.image=[UIImage imageNamed:@"10_5"];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    Test2TableViewCell *cell = [self.testTableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell)
//    {
//        cell=[[Test2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    cell.translatesAutoresizingMaskIntoConstraints = NO;
//    cell.bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    cell.headImageView.translatesAutoresizingMaskIntoConstraints = NO;
//    cell.bodyLabel.text = [self.tableData objectAtIndex:indexPath.row];
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog(@"h=%f", size.height + 1);
//    return 1  + size.height;
    // This project has only one cell identifier, but if you are have more than one, this is the time
    // to figure out which reuse identifier should be used for the cell at this index path.
    NSString *reuseIdentifier = CellIdentifier;
    
    // Use the dictionary of offscreen cells to get a cell for the reuse identifier, creating a cell and storing
    // it in the dictionary if one hasn't already been added for the reuse identifier.
    // WARNING: Don't call the table view's dequeueReusableCellWithIdentifier: method here because this will result
    // in a memory leak as the cell is created but never returned from the tableView:cellForRowAtIndexPath: method!
    Test2TableViewCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell = [[Test2TableViewCell alloc] init];
        [self.offscreenCells setObject:cell forKey:reuseIdentifier];
    }
    
    // Configure the cell for this indexPath
    //[cell updateFonts];
    //NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    //cell.titleLabel.text =  [dataSourceItem valueForKey:@"title"];
    cell.bodyLabel.text = [self.tableData objectAtIndex:indexPath.row];
    cell.headImageView.image=[UIImage imageNamed:@"10_5"];
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // The cell's width must be set to the same size it will end up at once it is in the table view.
    // This is important so that we'll get the correct height for different table view widths, since our cell's
    // height depends on its width due to the multi-line UILabel word wrapping. Don't need to do this above in
    // -[tableView:cellForRowAtIndexPath:] because it happens automatically when the cell is used in the table view.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    // NOTE: if you are displaying a section index (e.g. alphabet along the right side of the table view), or
    // if you are using a grouped table view style where cells have insets to the edges of the table view,
    // you'll need to adjust the cell.bounds.size.width to be smaller than the full width of the table view we just
    // set it to above. See http://stackoverflow.com/questions/3647242 for discussion on the section index width.
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}




-(UITableView *)testTableView
{
    if (!_testTableView)
    {
        _testTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _testTableView.delegate=self;
        _testTableView.dataSource=self;
    }
    return _testTableView;
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

@end
