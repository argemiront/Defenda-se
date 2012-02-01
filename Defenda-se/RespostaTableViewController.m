//
//  RespostaTableViewController.m
//  Defenda-se
//
//  Created by Argemiro Neto on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RespostaTableViewController.h"
#import "ArtigosTableViewController.h"

#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@implementation RespostaTableViewController

@synthesize questao;


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
    
    //Separamos os artigos relacionados
    artigos = [[questao objectAtIndex:3] componentsSeparatedByString:@","];
    
    if ([[artigos objectAtIndex:0] isEqualToString:@""])
        artsOK = NO;
    else
        artsOK = YES;
    
    
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
    questao = nil;
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
    NSInteger retNum = 2;
    
    if (![[questao objectAtIndex:2] isEqualToString:@""])
        retNum++;

    return retNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    UITableViewCell *cell;
    NSString *texto;
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize size;
    
    switch (indexPath.row) {
        case 0:
            CellIdentifier = @"CellPerguntaIdentifier";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            texto = [questao objectAtIndex:0];
            
            size = [texto sizeWithFont:[UIFont boldSystemFontOfSize:19.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:19.0f]];
            
            break;
            
        case 1:
            CellIdentifier = @"CellRespostaIdentifier";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            texto = [questao objectAtIndex: 1];
            
            size = [texto sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            
            [cell.textLabel setFont:[UIFont systemFontOfSize:17.0f]];
            
            break;

        case 2:
            CellIdentifier = @"CellComentarioIdentifier";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            texto = [questao objectAtIndex: 2];
            
            size = [texto sizeWithFont:[UIFont italicSystemFontOfSize:17.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            
            [cell.textLabel setFont:[UIFont italicSystemFontOfSize:17.0f]];
            
            break;
            
        default:
            CellIdentifier= @"Cell";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            break;
    }
    
    // Configure the cell...
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setText:texto];
    [cell.textLabel setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *texto;
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize size;
    CGFloat height;
    
    switch (indexPath.row) {
        case 0:
            texto = [questao objectAtIndex: 0];
            
            size = [texto sizeWithFont:[UIFont boldSystemFontOfSize:18.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            
            break;
            
        case 1:
            texto = [questao objectAtIndex: 1];
            
            size = [texto sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            
            break;
            
        case 2:
            texto = [questao objectAtIndex: 2];
            
            size = [texto sizeWithFont:[UIFont italicSystemFontOfSize:17.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            
            break;
            
        default:
            break;
    }
    
    height = MAX(size.height, 44.0f);
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ArtigosTableViewController *controller = [segue destinationViewController];
    
    controller.filesNames = [NSArray arrayWithArray: artigos];
    
    controller.navigationItem.title = @"Artigos";
}

#pragma mark Implementação UIAlertView Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
   
    [active setHidden:NO];
    
    switch (buttonIndex) {
        case 0:
            [active performSelectorInBackground:@selector(startAnimating) withObject:nil];
            [self showSMSPicker];
            break;
            
        case 1:
            [active performSelectorInBackground:@selector(startAnimating) withObject:nil];
            [self showMailPicker];
            break;
            
        case 2:
            [active stopAnimating];
            if (artsOK) {
                [self performSegueWithIdentifier:@"segueRespToArt" sender:self];
            }
            else {
                
                UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Artigos Relacionados" message:@"Não há artigos relacionados para esta defesa." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                
                [alerta show];
            }
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
                                  cancelButtonTitle:@"Cancelar" destructiveButtonTitle: nil otherButtonTitles:@"Enviar texto por SMS", @"Enviar texto por e-mail", @"Visualizar Artigos", nil];
    
    [actionSheet showInView:self.view];
    
//    [active startAnimating];
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
	
	[picker setSubject: [NSString stringWithFormat:@"%@ %@", @"Defenda-se:", [questao objectAtIndex:0]]];
	
	// Fill out the email body text
	NSString *emailBody = [NSString stringWithFormat:@"%@\n%@\n(Via: Defensa-se para iOS)", [questao objectAtIndex:0], [questao objectAtIndex:1]];
    
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
}


// Displays an SMS composition interface inside the application. 
-(void)displaySMSComposerSheet 
{    
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;
    
    [picker setBody:[NSString stringWithFormat:@"%@\r%@\r%@\n(Via: Defensa-se para iOS)", [questao objectAtIndex:0], [questao objectAtIndex:1], [questao objectAtIndex:2]]];
	
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
