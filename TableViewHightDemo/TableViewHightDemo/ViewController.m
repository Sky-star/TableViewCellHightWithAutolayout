//
//  ViewController.m
//  TableViewHightDemo
//
//  Created by Sky on 15/1/29.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "ViewController.h"

#import "TestTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* testTableView;


@property(nonatomic,strong)UITableViewCell* prototypeCell;

@property(nonatomic,strong)NSArray*  tableData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.tableData = @[@"1\n2\n3\n4\n5\n6", @"123456789012345678901234567890SDL;fkjdsafl;ksdfj阿道夫；拉斯科打飞机阿萨德了；fas;dlfkajsdfl;askdjfals;dkfjasdfl;ksajdfadls;kfajsdfakl;sdfjsadl;kfjasdfkl;asdjfadls;kfjasdfl;kasjdfl;k", @"1\n2", @"1\n2\n3", @"1"];
    
    [self.view addSubview:self.testTableView];

    UINib *cellNib = [UINib nibWithNibName:@"TestTableViewCell" bundle:nil];
    [self.testTableView registerNib:cellNib forCellReuseIdentifier:@"clientCell"];
    self.prototypeCell  = [self.testTableView dequeueReusableCellWithIdentifier:@"clientCell"];
    
   // TestTableViewCell * cell= [[[NSBundle mainBundle] loadNibNamed:@"TestTableViewCell" owner:self options:nil] objectAtIndex:0];
    
   // CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
   // NSLog(@"haaa=%f", size.height);
    
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
    TestTableViewCell *cell = [self.testTableView dequeueReusableCellWithIdentifier:@"clientCell"];
    cell.bodyLabel.text = [self.tableData objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = (TestTableViewCell *)self.prototypeCell;
    cell.translatesAutoresizingMaskIntoConstraints = NO;
    cell.bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    cell.headImageView.translatesAutoresizingMaskIntoConstraints = NO;
    cell.bodyLabel.text = [self.tableData objectAtIndex:indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"h=%f", size.height + 1);
    return 1  + size.height;
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

@end
