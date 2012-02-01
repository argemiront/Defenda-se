//
//  ArtigosTableViewController.m
//  Defenda-se
//
//  Created by Argemiro Neto on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtigosTableViewController.h"

#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@implementation ArtigosTableViewController

@synthesize filesNames;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    textos = [[NSMutableArray alloc] init];
    
    for (NSString *artigo in filesNames) {
        NSString *file = [NSString stringWithFormat:@"%@", artigo, nil];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:file ofType:nil];
        [textos addObject:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil]];
    }
    
    active = [[UIActivityIndicatorView alloc] init];
    CGAffineTransform transform = CGAffineTransformMakeScale(2, 2);
    active.transform = transform;
    [active setCenter:CGPointMake(self.view.center.x, self.view.center.y - 95)];
    [active setHidden:YES];
    [active setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:active];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    filesNames = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [textos count];
//    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellArtigosIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *texto = [textos objectAtIndex:indexPath.row];
    UITextView *textView = (UITextView *)[cell viewWithTag:1];
    
    CGSize constraint = CGSizeMake(290, 20000.0f);
    CGSize size = [texto sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    [textView setText:texto];
    [textView setFrame:CGRectMake(10, 0, 310, MAX(size.height, 44.0f) + 5)];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSString *texto = [textos objectAtIndex:indexPath.row];
    
    CGSize constraint = CGSizeMake(290, 20000.0f);
    CGSize size = [texto sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f) + 5;
    
    return height + (CELL_CONTENT_MARGIN * 2);
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark Implementação UIAlertView Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [active performSelectorInBackground:@selector(startAnimating) withObject:nil];
            [self showSMSPicker];
            break;
            
        case 1:
            [active performSelectorInBackground:@selector(startAnimating) withObject:nil];
            [self showMailPicker];
            break;
            
        default:
            [active stopAnimating];
            break;
    }
}

#pragma mark Métodos customizados

-(IBAction)trataAcao
{ 
    UIActionSheet *actionSheet;
    
    actionSheet = [[UIActionSheet alloc]
                   initWithTitle:@"Você gostaria de:" delegate:self
                   cancelButtonTitle:@"Cancelar" destructiveButtonTitle: nil otherButtonTitles:@"Enviar texto por SMS", @"Enviar texto por e-mail", nil];
    
//    [active startAnimating];
    [actionSheet showInView:self.view];
}


#pragma mark Show Mail/SMS Composer

-(void)showMailPicker {
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later. 
	// So, we must verify the existence of the above class and provide a workaround for devices running 
	// earlier versions of the iPhone OS. 
	// We display an email composition interface if MFMailComposeViewController exists and the device 
	// can send emails.	Display feedback message, otherwise.
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
	if (mailClass != nil) {
        //[self displayMailComposerSheet];
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]) {
			[self displayMailComposerSheet];
		}
		else {
            
            [active stopAnimating];
            
			UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro no envio de e-mail" message:@"Seu aparelho não está configurado para envio de e-mails" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
		}
	}
	else	{
        
        [active stopAnimating];
        
		UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro no envio de e-mail" message:@"Seu aparelho não está configurado para envio de e-mails" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alerta show];
	}
}


-(void)showSMSPicker{
    //	The MFMessageComposeViewController class is only available in iPhone OS 4.0 or later. 
    //	So, we must verify the existence of the above class and log an error message for devices
    //		running earlier versions of the iPhone OS. Set feedbackMsg if device doesn't support 
    //		MFMessageComposeViewController API.
	Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
	
	if (messageClass != nil) { 			
		// Check whether the current device is configured for sending SMS messages
		if ([messageClass canSendText]) {
			[self displaySMSComposerSheet];
		}
		else {	
            
            [active stopAnimating];
            
			UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro no envio de SMS" message:@"Seu aparelho não está configurado para envio de SMS's" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
            
		}
	}
	else {
        
        [active stopAnimating];
        
		UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Erro no envio de SMS" message:@"Seu aparelho não está configurado para envio de SMS's" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alerta show];
	}
}

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayMailComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:  @"Defenda-se: Código de Defesa do Consumidor"];
	
    //Levantamento do texto dos artigos abertos
    NSMutableString *corpo = [[NSMutableString alloc] init];
    
    for (NSString *artigo in textos) {
        [corpo appendString:artigo];
        [corpo appendString:@"\n"];
    }
    
	// Fill out the email body text
	NSString *emailBody = [corpo stringByAppendingString:@"\n\n(Via: Defenda-se para iOS)"];
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
}


// Displays an SMS composition interface inside the application. 
-(void)displaySMSComposerSheet 
{
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;
    
    //Levantamento do texto dos artigos abertos
    NSMutableString *corpo = [[NSMutableString alloc] init];
    
    for (NSString *artigo in textos) {
        [corpo appendString:artigo];
        [corpo appendString:@"\n"];
    }
    
    [picker setBody:[corpo stringByAppendingString:@"\n(Via: Defenda-se para iOS)"]];
	
	[self presentModalViewController:picker animated:YES];
}


#pragma mark -
#pragma mark Dismiss Mail/SMS view controller

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the 
// message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
    [active stopAnimating];
    
    UIAlertView *alerta;
    
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
            alerta = [[UIAlertView alloc] initWithTitle:@"Resultado" message:@"E-mail cancelado" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
			break;
		case MFMailComposeResultSaved:
            alerta = [[UIAlertView alloc] initWithTitle:@"Resultado" message:@"E-mail salvo" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
			break;
		case MFMailComposeResultSent:
            alerta = [[UIAlertView alloc] initWithTitle:@"Resultado" message:@"E-mail enviado" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
			break;
		case MFMailComposeResultFailed:
            alerta = [[UIAlertView alloc] initWithTitle:@"Resultado" message:@"Falha no envio do e-mail" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
			break;
		default:
            alerta = [[UIAlertView alloc] initWithTitle:@"Resultado" message:@"E-mail não enviado" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


// Dismisses the message composition interface when users tap Cancel or Send. Proceeds to update the 
// feedback message field with the result of the operation.
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller 
                 didFinishWithResult:(MessageComposeResult)result {
	[active stopAnimating];
    UIAlertView *alerta;
    
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MessageComposeResultCancelled:
            alerta = [[UIAlertView alloc] initWithTitle:@"Resultado" message:@"SMS cancelado" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
			break;
		case MessageComposeResultSent:
            alerta = [[UIAlertView alloc] initWithTitle:@"Resultado" message:@"SMS Enviado" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
			break;
		case MessageComposeResultFailed:
            alerta = [[UIAlertView alloc] initWithTitle:@"Resultado" message:@"Falha no envio do SMS" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
			break;
		default:
            alerta = [[UIAlertView alloc] initWithTitle:@"Resultado" message:@"SMS não enviado" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alerta show];
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

@end
