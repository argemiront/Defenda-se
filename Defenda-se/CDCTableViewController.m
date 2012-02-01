//
//  CDCTableViewController.m
//  Defenda-se
//
//  Created by Argemiro Neto on 16/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CDCTableViewController.h"
#import "ArtigosTableViewController.h"
#import "CapitulosTableViewController.h"
#import <QuartzCore/CAGradientLayer.h>

@implementation CDCTableViewController

@synthesize search, table;


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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    artigos = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Artigos" ofType:@"plist"]];
    
    [table setContentOffset:CGPointMake(0.0, 44.0) animated:NO];
    
    resultadoBusca = [[NSMutableArray alloc] init];
//    searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:search contentsController:self];
//    searchDisplay.delegate = self.searchDisplayController;
//    searchDisplay.searchResultsDataSource = self;
//    searchDisplay.searchResultsDelegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    search = nil;
    searchDisplay = nil;
    table = nil;
    baseBusca = nil;
    resultadoBusca = nil;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == table)
        return 6;
    else
        return [resultadoBusca count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    //Célula estática
    if (tableView == table)
    {
        static NSString *CellIdentifierStatic = @"CellCDCIdTitulo";
        NSInteger indice = indexPath.row;
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierStatic];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierStatic];
        }

        UILabel *texto = (UILabel *)[cell viewWithTag:1];
        UILabel *subtitulo = (UILabel *)[cell viewWithTag:2];
        
        switch (indice) {
            case 0:
                [texto setText:@"Dos Direitos do Consumidor"];
                [subtitulo setText:@"Título I (Art. 1 ao Art. 60)"];
                break;
                
            case 1:
                [texto setText:@"Das Infrações Penais"];
                [subtitulo setText:@"Título II (Art. 61 ao Art. 80)"];
                break;
                
            case 2:
                [texto setText:@"Da Defesa do Consumidor em Juízo"];
                [texto setNumberOfLines:2];
                [subtitulo setText:@"Título III (Art. 81 ao Art. 104)"];
                break;
                
            case 3:
                [texto setText:@"Do Sistem Nacional de Defesa do Consumidor"];
                [texto setNumberOfLines:2];
                [subtitulo setText:@"Título IV (Art. 105 e Art. 106)"];
                break;
                
            case 4:
                [texto setText:@"Da Convenção Coletiva de Consumo"];
                [texto setNumberOfLines:2];
                [subtitulo setText:@"Título V (Art. 107 e Art. 108)"];
                break;
                
            case 5:
                [texto setText:@"Disposições Finais"];
                [subtitulo setText:@"Título VI (Art. 109 ao Art. 119)"];
                break;
                
            default:
                break;
        }
    }
    //Célula dinamica da busca
    else
    {                
        static NSString *CellIdentifier = @"CellBuscaArtigosIdentifier";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            //Retirada do label pradrão e inserção do acessório
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UIView *view = [cell viewWithTag:0];
            [view removeFromSuperview];
            
            //Inserção do textview para os artigos
            UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(10, 7, 280, 98)];
            [text setTag:10];
            [text setFont:[UIFont systemFontOfSize:17]];
            [text setUserInteractionEnabled:NO];
            [cell addSubview:text];
            
            //Inserção do gradiente nas células
            CAGradientLayer *gradiente = [CAGradientLayer layer];
            [gradiente setFrame:CGRectMake(0, 0, 320, 110)];
            gradiente.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:1.0f alpha:1.0f] CGColor], (id)[[UIColor colorWithWhite:1.0f alpha:0.0f] CGColor], (id)[[UIColor colorWithWhite:1.0f alpha:0.0f] CGColor],(id)[[UIColor colorWithWhite:1.0f alpha:0.0f] CGColor],(id)[[UIColor colorWithWhite:1.0f alpha:1.0f] CGColor], nil];
            
            UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 110)];
            [gradientView.layer insertSublayer:gradiente atIndex:0];
            [cell addSubview:gradientView];
        }
        
        UITextView *artigo = (UITextView *)[cell viewWithTag:10];        
        
        [artigo setText:[resultadoBusca objectAtIndex:indexPath.row]];
        
         NSRange range = [[resultadoBusca objectAtIndex:indexPath.row] rangeOfString:search.text options:NSCaseInsensitiveSearch];
        
        [artigo scrollRangeToVisible:range];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    if (tableView == table)
    {
        if (indexPath.row >= 2 && indexPath.row <= 4) {
            return 70;
        }
        else
            return 58;
    }
    else
    {
        return 110.0f;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == table) {
        
        buscaArtigo = NO;
        
        if (indexPath.row == 0 || indexPath.row == 2)
            [self performSegueWithIdentifier:@"SegueSecaoCap" sender:self];
        else
            [self performSegueWithIdentifier:@"SegueTextoCDC" sender:self];
    }
    else
    {
        buscaArtigo = YES;
        [self performSegueWithIdentifier:@"SegueTextoCDC" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    int linha = [[self.tableView indexPathForSelectedRow] row];
    
    
    if ([[segue identifier] isEqualToString:@"SegueSecaoCap"])
    {
        CapitulosTableViewController *controllerCap = [segue destinationViewController];
        
        if (linha == 0) //Título I
        {
            controllerCap.navigationItem.title = @"Título I";
            controllerCap.fileName = @"Caps";
            controllerCap.item = @"0";
        }
        else    //Título III
        {
            controllerCap.navigationItem.title = @"Título III";
            controllerCap.fileName = @"Caps";
            controllerCap.item = @"2";
        }
    }
    else if ([[segue identifier] isEqualToString:@"SegueTextoCDC"])
    {
        ArtigosTableViewController *controller = [segue destinationViewController];
         
    
        if (!buscaArtigo) {
            
            switch (linha) {
                case 1:
                    controller.filesNames = [NSArray arrayWithArray: [artigos valueForKey: @"TII"]];
                    controller.navigationItem.title = @"Título II";
                    break;
                
                case 3:
                    controller.filesNames = [NSArray arrayWithArray: [artigos valueForKey: @"TIV"]];
                    controller.navigationItem.title = @"Título IV";
                    break;
                    
                case 4:
                    controller.filesNames = [NSArray arrayWithArray: [artigos valueForKey: @"TV"]];
                    controller.navigationItem.title = @"Título V";
                    break;
                    
                case 5:
                    controller.filesNames = [NSArray arrayWithArray: [artigos valueForKey: @"TVI"]];
                    controller.navigationItem.title = @"Título VI";
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            //Código para recuperarmos o número do artigo
            
            int indiceArtigo = [[self.searchDisplayController.searchResultsTableView indexPathForSelectedRow] row];
            NSString *numero = [[[resultadoBusca objectAtIndex:indiceArtigo] substringToIndex:10] substringFromIndex:5];
            
            NSRange range = [numero rangeOfString:@"."];
            NSString *nomeArtigo = [numero substringToIndex:range.location];
            controller.filesNames = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@.txt",  nomeArtigo]];
            controller.navigationItem.title = [NSString stringWithFormat:@"%@ %@", @"Artigo", nomeArtigo];
        }
    }
}


#pragma mark Implementação da busca
//Botão de busca ou enter foi pressionado
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self handleSearchForTerm:[searchBar text]];
    [searchBar resignFirstResponder];
}

//O texto da barra de busca foi alterado
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText length] == 0) { 
        [self resetSearch];
        [self.searchDisplayController.searchResultsTableView reloadData];
        return;
    }
    
    [self handleSearchForTerm:searchText];
}

//O botão de cancelar da busca foi pressionado
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";

    [table reloadData];
    [self resetSearch];
	[searchBar resignFirstResponder];
    [table setContentOffset:CGPointMake(0.0, 44.0) animated:YES];
}

//O campo de texto da busca foi selecionado
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [self performSelectorInBackground:@selector(carregaDadosBusca) withObject:nil];
}

-(void)carregaDadosBusca
{
    if (baseBusca == nil)
    {
        baseBusca = [[NSMutableArray alloc] init];
        
        //Dividimos o laço para que a inserção do artigo 42-A esteja na ordem correta,
        //deixando a busca com resultados sequenciais
        
        //Artigos 1 ao 42
        for (int i = 1; i <= 42; i++) {
            NSString *artigo = [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", i] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
            
            [baseBusca addObject:artigo];
        }
        
        //adiciona o artigo 42A
        NSString *artigo42A = [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"42-A" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        
        [baseBusca addObject:artigo42A];
        
        //Artigos 43 ao 119
        for (int i = 43; i <= 119; i++) {
            NSString *artigo = [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", i] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
            
            [baseBusca addObject:artigo];
        }
    }
}

- (void)resetSearch
{
    [resultadoBusca removeAllObjects];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (void)handleSearchForTerm:(NSString *)searchTerm
{
    [self resetSearch];
    
    if (baseBusca != nil)
    {        
        for (NSString *artigo in baseBusca) {
            if ([artigo rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location != NSNotFound)
                [resultadoBusca addObject:artigo];
        }
        
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
}

@end
