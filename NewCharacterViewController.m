//
//  NewCharacterViewController.m
//  LostCharacters
//
//  Created by Micah Lanier on 3/31/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "NewCharacterViewController.h"
#import "Character.h"
#import "AppDelegate.h"

@interface NewCharacterViewController ()

<
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>

@property (weak, nonatomic) IBOutlet UIImageView *characterImageView;
@property (weak, nonatomic) IBOutlet UITextField *passengerNameTextField;
@property Character *character;

@end

@implementation NewCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.characterImageView.layer.masksToBounds = YES;
    self.characterImageView.layer.cornerRadius = 90;

}

- (IBAction)addNewCharacter:(UITextField *)sender {
    NSManagedObject *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.moc];
    [character setValue:sender.text forKey:@"passenger"];
    [self.moc save:nil];
    sender.text = @"";
    [sender resignFirstResponder];

}


- (IBAction)onAddProfilePicTapped:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *profileImage = info[UIImagePickerControllerOriginalImage];
    self.characterImageView.image = profileImage;
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
