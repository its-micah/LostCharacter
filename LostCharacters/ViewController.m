//
//  ViewController.m
//  LostCharacters
//
//  Created by Micah Lanier on 3/31/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Character.h"
#import "CharacterTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSManagedObjectContext *moc;
@property NSArray *characterArray;
@property (weak, nonatomic) IBOutlet UITableView *characterTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.characterArray = [NSArray new];
    self.characterTableView.delegate = self;


    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;

    [self load];
    //[self load];
}


- (void)load {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];
    self.characterArray = [self.moc executeFetchRequest:request error:nil];

    if (self.characterArray.count == 0) {
        [self prePopulateTableView];
        [self.characterTableView reloadData];
    }
}



- (void)prePopulateTableView {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"lost" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];

    for (NSDictionary *dict in array) {
        NSManagedObject *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.moc];
        [character setValue:dict[@"actor"] forKey:@"actor"];
        [character setValue:dict[@"passenger"] forKey:@"passenger"];
        [self.moc save:nil];
       // [self.characterArray addObject:character];
        //NSLog(@"%@", [character valueForKey:@"actor"]);
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.characterArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *character = self.characterArray[indexPath.row];

    CharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = [character valueForKey:@"passenger"];
    cell.detailTextLabel.text = [character valueForKey:@"actor"];
    return cell;
}

@end
