//
//  ArtigosTableViewController.h
//  Defenda-se
//
//  Created by Argemiro Neto on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ArtigosTableViewController : UITableViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIAlertViewDelegate>
{
    NSArray *filesNames;
    NSMutableArray *textos;
    
    UIActivityIndicatorView *active;
}

@property (nonatomic, retain) NSArray *filesNames;

-(IBAction) trataAcao;
-(void)showMailPicker;
-(void)showSMSPicker;
-(void)displayMailComposerSheet;
-(void)displaySMSComposerSheet;

@end
