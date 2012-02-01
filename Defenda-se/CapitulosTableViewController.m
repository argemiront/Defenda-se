//
//  CapitulosCDCTableViewController.m
//  Defenda-se
//
//  Created by Argemiro Neto on 24/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CapitulosTableViewController.h"
#import "ArtigosTableViewController.h"
#import <QuartzCore/CAGradientLayer.h>


@implementation CapitulosTableViewController

@synthesize fileName, item, table, search;


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
    
    NSDictionary *dados = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"]];
    
    titulos = [dados objectForKey:item];
    subtitulos = [dados objectForKey: [item stringByAppendingString:@"_subtitles"]];
    arqs = [dados objectForKey:[item stringByAppendingString:@"_files"]];
    rangeBusca = [dados objectForKey:[item stringByAppendingString:@"_range"]];
    
    artigos = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Artigos" ofType:@"plist"]];
    
    buscaArtigo = NO;
    resultadoBusca = [[NSMutableArray alloc] init];
    [table setContentOffset:CGPointMake(0, 44)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    fileName = nil;
    item = nil;
    table = nil;
    search = nil;
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
    if (tableView == table)
        return [titulos count];
    else
        return [resultadoBusca count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    //Célula estática
    if (tableView == table)
    {    
        static NSString *CellIdentifier = @"CapSecCellIdentifier";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        //Configure the cell...
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [cell.textLabel setNumberOfLines:0];
        cell.textLabel.text = [titulos objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [subtitulos objectAtIndex:indexPath.row];
        

        NSString *text = [titulos objectAtIndex:indexPath.row];
        
        CGSize constraint = CGSizeMake(320 - (10 * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];

        [cell.textLabel setFrame:CGRectMake(10, 10, 320 - (10 * 2), MAX(size.height, 44.0f))];
    }
    //Célula dinamica da busca
    else
    {                
        static NSString *CellIdentifier = @"CellBuscaArtigosIdentifierCap";
        
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
        CGFloat item3 = 0.f;
        
        NSString *text = [titulos objectAtIndex:indexPath.row];
        
        CGSize constraint = CGSizeMake(320 - (10 * 2), 20000.0f);
        
        if (indexPath.row == 2 && [item isEqualToString:@"2"])
            item3 = 45;
            
        CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];

        CGFloat height = MAX(size.height + 10, 44.0f);
        
        return height + (10 * 2) + item3;
    }
    else
        return 110.0f;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (tableView == table)
    {
        buscaArtigo = NO;
        
        //Se não temos arquivo registrado então abrir seção
        if ([[arqs objectAtIndex:indexPath.row] isEqualToString:@""])
            [self performSegueWithIdentifier:@"SegueCapSec" sender:self];
        else
            [self performSegueWithIdentifier:@"SegueCapTexto" sender:self];
    }
    else
    {
        buscaArtigo = YES;
        [self performSegueWithIdentifier:@"SegueCapTexto" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    int linha = [[self.tableView indexPathForSelectedRow] row];
    
    if ([[segue identifier] isEqualToString:@"SegueCapSec"])
    {
        CapitulosTableViewController *secController = [segue destinationViewController];
        
        secController.fileName = @"SecTI";
        secController.item = [NSString stringWithFormat:@"%d", linha];
        secController.navigationItem.title = [subtitulos objectAtIndex:linha];

    }
    else
    {
        ArtigosTableViewController *textController = [segue destinationViewController];
        
        if (!buscaArtigo) {
            
            textController.filesNames = [NSArray arrayWithArray: [artigos valueForKey: [arqs objectAtIndex:linha]]];
            
            textController.navigationItem.title = [subtitulos objectAtIndex:linha];
        }
        else
        {            
            //Código para recuperarmos o número do artigo
            
            int indiceArtigo = [[self.searchDisplayController.searchResultsTableView indexPathForSelectedRow] row];
            NSString *numero = [[[resultadoBusca objectAtIndex:indiceArtigo] substringToIndex:10] substringFromIndex:5];
            
            NSRange range = [numero rangeOfString:@"."];
            NSString *nomeArtigo = [numero substringToIndex:range.location];
            textController.filesNames = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@.txt",  nomeArtigo]];
            textController.navigationItem.title = [NSString stringWithFormat:@"%@ %@", @"Artigo", nomeArtigo];
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
    //    [searchDisplay.searchResultsTableView reloadData];
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
        
        //Artigos
        int inic = [[rangeBusca objectAtIndex:0] intValue];
        int fim = [[rangeBusca objectAtIndex:1] intValue];
        
        for (int i = inic; i <= fim; i++) {
            NSString *artigo = [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", i] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
            
            [baseBusca addObject:artigo];
        }
        
        //Verifica se o artigo 42A é utilizado e adiciona-o
        if ([[rangeBusca objectAtIndex:0] intValue] < 42 && [[rangeBusca objectAtIndex:1] intValue] > 42)
        {
            NSString *artigo42A = [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"42-A" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
            
            [baseBusca addObject:artigo42A];
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
