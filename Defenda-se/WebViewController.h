//
//  WebViewController.h
//  Defenda-se
//
//  Created by Argemiro Neto on 24/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController {
    UIWebView *webView;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;


- (IBAction)voltarTela;

@end
