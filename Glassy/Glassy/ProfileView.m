//
//  ProfileView.m
//  Glassy
//
//  Created by Niek Willems on 12/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "ProfileView.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>


@implementation ProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawView];
    }
    return self;
}

- (void)drawView
{
    CGFloat margin = 15;
    CGFloat currentHeight = margin;
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(105, currentHeight, 100, 100)];
    self.profileImageView.layer.cornerRadius = 5.0;
    
    currentHeight = currentHeight + self.profileImageView.frame.size.height + margin;
    
    self.firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.firstNameTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.firstNameTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.firstNameTextField.layer.borderWidth = 0.5;
    self.firstNameTextField.layer.cornerRadius = 5.0;
    self.firstNameTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.firstNameTextField.placeholder = @"Voornaam";
 
    currentHeight = currentHeight + self.firstNameTextField.frame.size.height + margin;
    
    self.lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.lastNameTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.lastNameTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.lastNameTextField.layer.borderWidth = 0.5;
    self.lastNameTextField.layer.cornerRadius = 5.0;
    self.lastNameTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.lastNameTextField.placeholder = @"Achternaam";
    
    currentHeight = currentHeight + self.lastNameTextField.frame.size.height + margin;
    
    self.postcodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 130, 40)];
    self.postcodeTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.postcodeTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.postcodeTextField.layer.borderWidth = 0.5;
    self.postcodeTextField.layer.cornerRadius = 5.0;
    self.postcodeTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.postcodeTextField.placeholder = @"Postcode";
    
    self.houseNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(55 + self.postcodeTextField.frame.size.width + 10, currentHeight, 70, 40)];
    self.houseNumberTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.houseNumberTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.houseNumberTextField.layer.borderWidth = 0.5;
    self.houseNumberTextField.layer.cornerRadius = 5.0;
    self.houseNumberTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.houseNumberTextField.placeholder = @"Huisnr.";

    currentHeight = currentHeight + self.postcodeTextField.frame.size.height + margin;
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.emailTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.emailTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.emailTextField.layer.borderWidth = 0.5;
    self.emailTextField.layer.cornerRadius = 5.0;
    self.emailTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.emailTextField.placeholder = @"E-mail";

    self.emailTextField.secureTextEntry = YES;
    
    currentHeight = currentHeight + self.emailTextField.frame.size.height + margin;
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.passwordTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.passwordTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.passwordTextField.layer.borderWidth = 0.5;
    self.passwordTextField.layer.cornerRadius = 5.0;
    self.passwordTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.passwordTextField.placeholder = @"Wachtwoord";
    self.passwordTextField.secureTextEntry = YES;
    
    currentHeight = currentHeight + self.passwordTextField.frame.size.height + margin;
    
    self.buddySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(50, currentHeight - 5, 15, 10)];
    self.buddySwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    self.buddySwitch.on = YES;
    [self.buddySwitch addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
    
    
    self.buddyLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, currentHeight, 150, 20)];
    self.buddyLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.buddyLabel.font = [UIFont boldSystemFontOfSize:13];
    self.buddyLabel.text = @"Ik ben een buddy";
    self.buddyLabel.textColor = [UIColor darkGrayColor];
    
    currentHeight = currentHeight + self.buddyLabel.frame.size.height + margin;

    currentHeight = [self drawBuddyView:currentHeight withMargin:margin];
    
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(55, currentHeight, 210, 40)];
    self.saveButton.backgroundColor = [UIColor lightGrayColor];
    self.saveButton.layer.cornerRadius = 5.0;
    self.saveButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    [self.saveButton setTitle:@"Opslaan" forState:UIControlStateNormal];
    
    currentHeight = currentHeight + self.saveButton.frame.size.height + margin;
    
    // Set frame size
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 85);
    // Create scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    // Add all views to scrollview
    [self.scrollView addSubview:self.profileImageView];
    [self.scrollView addSubview:self.firstNameTextField];
    [self.scrollView addSubview:self.lastNameTextField];
    [self.scrollView addSubview:self.postcodeTextField];
    [self.scrollView addSubview:self.houseNumberTextField];
    [self.scrollView addSubview:self.emailTextField];
    [self.scrollView addSubview:self.passwordTextField];
    [self.scrollView addSubview:self.saveButton];
    
    [self.scrollView addSubview:self.buddySwitch];
    [self.scrollView addSubview:self.buddyLabel];
    [self.scrollView addSubview:self.buddyDetailsView];
    // Set content size
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 880);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    // Add scrollview to view
    [self addSubview:self.scrollView];
}

- (int)drawBuddyView:(int)currentHeight withMargin:(int)margin
{
    int buddyHeight = 0;
    int buttonHeight = 40;
    
    self.buddyDetailsView = [[UIView alloc] initWithFrame:CGRectMake(0, currentHeight, self.frame.size.width, buttonHeight * 3 + margin * 2)];
    
    self.buddyPhone = [[UITextField alloc] initWithFrame:CGRectMake(55, 0, 210, 40)];
    self.buddyPhone.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.buddyPhone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.buddyPhone.layer.borderWidth = 0.5;
    self.buddyPhone.layer.cornerRadius = 5.0;
    self.buddyPhone.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.buddyPhone.placeholder = @"Alternatief telefoonnummer";
    
    buddyHeight += self.buddyPhone.frame.size.height + margin;
    
    self.buddyEmail = [[UITextField alloc] initWithFrame:CGRectMake(55, self.buddyPhone.frame.size.height + margin, 210, 40)];
    self.buddyEmail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-auth-background.png"]];
    self.buddyEmail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.buddyEmail.layer.borderWidth = 0.5;
    self.buddyEmail.layer.cornerRadius = 5.0;
    self.buddyEmail.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.buddyEmail.placeholder = @"Alternatief e-mailadres";
    
    buddyHeight += self.buddyEmail.frame.size.height + margin;
    
    self.buddyVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(55, buddyHeight, 210, 40)];
    self.buddyVideoButton.backgroundColor = [UIColor lightGrayColor];
    self.buddyVideoButton.layer.cornerRadius = 5.0;
    self.buddyVideoButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
    self.buddyVideoButton.enabled = YES;
    [self.buddyVideoButton setTitle:@"Maak video" forState:UIControlStateNormal];
    [self.buddyVideoButton addTarget:self action:@selector(buddyVideoButtonClick:) forControlEvents:UIControlEventAllEvents];

    //[self.buddyVideoButton addTarget:self action:@selector(buddyVideoButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    
    buddyHeight += self.buddyVideoButton.frame.size.height + margin;
    
    [self.buddyDetailsView addSubview:self.buddyPhone];
    [self.buddyDetailsView addSubview:self.buddyEmail];
    [self.buddyDetailsView addSubview:self.buddyVideoButton];
    
    currentHeight = currentHeight + self.buddyDetailsView.frame.size.height + margin;
    return currentHeight;
}

- (void)setState:(id)sender
{
    BOOL state = [sender isOn];
    if(state == YES) {
        [self.buddyPhone setHidden:NO];
        [self.buddyEmail setHidden:NO];
        [self.buddyVideoButton setHidden:NO];
    }else{
        [self.buddyPhone setHidden:YES];
        [self.buddyEmail setHidden:YES];
        [self.buddyVideoButton setHidden:YES];
    }
}

- (void)buddyVideoButtonClick:(id)sender
{
    NSLog(@"CLICKED");
}

- (void)enableCamera
{
    // Couldn't test it. This feature requires an Iphone.
    // Implementation based on http://stackoverflow.com/questions/20590346/using-cameraoverlayview-with-uiimagepickercontroller
    self.toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height-54, self.scrollView.frame.size.width, 55)];
    
    self.toolBar.barStyle =  UIBarStyleBlackOpaque;
    NSArray *items=[NSArray arrayWithObjects:
                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel  target:self action:@selector(cancelPicture)],
                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace  target:nil action:nil],
                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera  target:self action:@selector(shootPicture)],
                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace  target:nil action:nil],
                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace  target:nil action:nil],
                    nil];
    [self.toolBar setItems:items];
    
    // create the overlay view
    //self.overlayView = [[OverlayView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
    
    // important - it needs to be transparent so the camera preview shows through!
    //overlayView.opaque=NO;
    //overlayView.backgroundColor=[UIColor clearColor];
    
    // parent view for our overlay
    UIView *cameraView=[[UIView alloc] initWithFrame:self.scrollView.bounds];
    //[cameraView addSubview:overlayView];
    [cameraView addSubview:self.toolBar];
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO){
        UIAlertView *noCameraAlert = [[UIAlertView alloc] initWithTitle:@"Incompatible Device" message:@"Sorry, This feature requires a camera" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [noCameraAlert show];

        return;
    }
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.delegate = self;
    
    // hide the camera controls
    self.imagePickerController.showsCameraControls=NO;
    self.imagePickerController.wantsFullScreenLayout = YES;
    [self.imagePickerController setCameraOverlayView:cameraView];
    
    //[self presentViewController:self.imagePickerController animated:YES completion:nil];
    
   }
@end
