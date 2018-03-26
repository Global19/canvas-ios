//
//  CKMDomainSearchViewController.m
//  CanvasKeymaster
//
//  Created by Layne Moseley on 2/13/18.
//  Copyright © 2018 Instructure. All rights reserved.
//

#import "CKMDomainSearchViewController.h"
#import "CKMDomainSuggestionTableViewController.h"
#import "CKMLocationSchoolSuggester.h"
#import "CanvasKeymaster.h"

@import ReactiveObjC;
@import CanvasKit;

@interface CKMDomainSearchViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UITextField *searchTextField;
@property (nonatomic, weak) IBOutlet UIView *suggestionContainer;
@property (nonatomic, weak) IBOutlet UIButton *closeButton;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, weak) CKMDomainSuggestionTableViewController *suggestionTableViewController;
@property (nonatomic) BOOL poppedKeyboardOnFirstAppear;

@end

@implementation CKMDomainSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logoImageView.image = TheKeymaster.delegate.logoForDomainPicker;
    [self.closeButton setImage:[[UIImage imageNamed:@"x-icon" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    @weakify(self);
    [self.suggestionTableViewController.selectedSchoolSignal subscribeNext:^(CKIAccountDomain *school) {
        @strongify(self);
        [self.delegate sendDomain:school];
    }];
    
    [self.suggestionTableViewController.selectedHelpSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.delegate showHelpPopover];
    }];
    
    [self.searchTextField addTarget:self action:@selector(textFieldWasEdited:) forControlEvents:UIControlEventAllEditingEvents];
    
    CKMLocationSchoolSuggester *suggestor = [CKMLocationSchoolSuggester shared];
    RACSignal *fetching = RACObserve(suggestor, fetching);
    RACSignal *text = self.searchTextField.rac_textSignal;
    RAC(self.spinner, animating) = [[[fetching combineLatestWith:text] map:^id (RACTuple* value) {
        NSNumber *fetching = value.first;
        NSString *text = value.second;
        return @([fetching boolValue] && text.length > 0);
    }] deliverOnMainThread];
    
    self.poppedKeyboardOnFirstAppear = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.poppedKeyboardOnFirstAppear) {
        self.poppedKeyboardOnFirstAppear = YES;
        [self.searchTextField becomeFirstResponder];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EmbedSuggestions"]) {
        self.suggestionTableViewController = segue.destinationViewController;
    }
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldWasEdited:(id)sender {
    self.suggestionTableViewController.query = self.searchTextField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    CKIAccountDomain *domain = [[CKIAccountDomain alloc] initWithDomain:self.searchTextField.text];
    [self.delegate sendDomain:domain];
    return YES;
}

- (BOOL)shouldAutorotate {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return NO;
    }
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
    }
    
    return UIInterfaceOrientationMaskAll;
}

@end
