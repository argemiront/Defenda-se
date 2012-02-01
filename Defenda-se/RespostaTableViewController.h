//
//  RespostaTableViewController.h
//  Defenda-se
//
//  Created by Argemiro Neto on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface RespostaTableViewController : UITableViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIAlertViewDelegate>
{
    NSArray *questao;
    NSArray *artigos;
    
    BOOL artsOK;
    UIActivityIndicatorView *active;
}

@property (nonatomic, retain) NSArray *questao;

-(IBAction) trataAcao;
-(void)showMailPicker;
-(void)showSMSPicker;
-(void)displayMailComposerSheet;
-(void)displaySMSComposerSheet;

@end
