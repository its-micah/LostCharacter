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
#import "NewCharacterViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSManagedObjectContext *moc;
@property NSArray *characterArray;
@property NSManagedObject *character;
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
}


- (void)load {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];
    self.characterArray = [self.moc executeFetchRequest:request error:nil];

    if (self.characterArray.count == 0) {
        [self prePopulateTableView];
        [self.characterTableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.characterTableView reloadData];
}


- (void)prePopulateTableView {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"lost" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];

    for (NSDictionary *dict in array) {
        NSManagedObject *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.moc];
        [character setValue:dict[@"actor"] forKey:@"actor"];
        [character setValue:dict[@"passenger"] forKey:@"passenger"];
        [self.moc save:nil];
    }
}

- (void)setCharacterTableView:(UITableView *)characterTableView {
    _characterTableView = characterTableView;
    [self.characterTableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Smoke Monster";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.characterArray];
        [tempArray removeObjectAtIndex:indexPath.row];
        self.characterArray = tempArray;
        [self.characterTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        NSManagedObject *character = [self.characterArray objectAtIndex:indexPath.row];
        [self.moc deleteObject:character];
        [self.characterTableView reloadData];
        [self.moc save:nil];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showCharacterDetailView"]) {
        NewCharacterViewController *newVC = segue.destinationViewController;
        newVC.moc = self.moc;
    }
}

@end
