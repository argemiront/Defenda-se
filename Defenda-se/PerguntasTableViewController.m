//
//  PerguntasTableViewController.m
//  Defenda-se
//
//  Created by Argemiro Neto on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PerguntasTableViewController.h"
#import "RespostaTableViewController.h"

#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@implementation PerguntasTableViewController

@synthesize search, table, categoria, termoFiltro, allPerguntas;


#pragma mark - Métodos da busca

- (void)resetSearch
{    
    NSMutableArray *perguntasTemp = [[NSMutableArray alloc] init];
    [perguntasTemp addObjectsFromArray:allPerguntas];    
    perguntas = perguntasTemp;
}

- (void)handleSearchForTerm:(NSString *)searchTerm
{
    NSMutableArray *PerguntasRemover = [[NSMutableArray alloc] init];
    [self resetSearch];
    
    for (NSArray *questao in perguntas) {
        
        NSString *pergunta = [questao objectAtIndex:0];
            
            if ([pergunta rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location == NSNotFound)
                    [PerguntasRemover addObject:questao];
    }
    
    [perguntas removeObjectsInArray:PerguntasRemover]; 
    [table reloadData];
}


#pragma mark Inicialização

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
    
    [self resetSearch];
    [table reloadData];
    
    if (termoFiltro != nil && termoFiltro != @"")
    {
        [self.search setText:termoFiltro];
        search.showsCancelButton = YES;
        [self handleSearchForTerm:termoFiltro];
    }
    else
        [table setContentOffset:CGPointMake(0.0, 44.0) animated:NO];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    search = nil;
    table = nil;
    categoria = nil;
    termoFiltro = nil;
    allPerguntas = nil;
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
    return [perguntas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellPerguntasIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *text = [[perguntas objectAtIndex:indexPath.row] objectAtIndex:0];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:18.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setText:text];
    [cell.textLabel setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSString *text = [[perguntas objectAtIndex:indexPath.row] objectAtIndex:0];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:18.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}

#pragma Métodos Delegados da Busca
//Botão de busca ou enter foi pressionado
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    //Remove os resultados da busca    
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    [self handleSearchForTerm:searchBar.text];
}

//O texto da barra de busca foi alterado
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText length] == 0) { 
        [self resetSearch];
        [table reloadData];
        return;
    }
    
    [self handleSearchForTerm:searchText];
}

//O botão de cancelar da busca foi pressionado
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    
    //Remove os resultados da busca
    searchBar.showsCancelButton = NO;
    [self resetSearch];
    [table reloadData];
    [table setContentOffset:CGPointMake(0.0, 44.0) animated:YES];
	[self.search resignFirstResponder];
}

//O campo de texto da busca foi selecionado
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}


#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableViewwillSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    [search resignFirstResponder];
    return indexPath;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RespostaTableViewController *controller = [segue destinationViewController];
    
    controller.title = self.title;
    
    [controller.navigationItem setTitle:self.navigationItem.title];
    
    controller.questao = [[NSArray alloc] initWithArray:[perguntas objectAtIndex:self.table.indexPathForSelectedRow.row] copyItems:YES];
}

@end
