//
//  Defesa.m
//  Defenda-se
//
//  Created by Argemiro Neto on 16/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DefesaTableViewController.h"
#import "PerguntasTableViewController.h"
#import "NSDictionary+NSDictionary_MutableDeepCopy.h"
#import "SobreViewController.h"
#import "CustomBadge.h"

#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@implementation DefesaTableViewController

@synthesize table, search;

#pragma mark Métodos customizados para a busca
- (void)resetSearch
{    
    for (NSString *cat in [allDefesas allKeys]) {
        
        NSArray *perguntas = [allDefesas objectForKey:cat];
        
        NSMutableArray *tempPerguntas = [[NSMutableArray alloc] initWithArray:perguntas copyItems:YES];
        
        [defesas setValue:tempPerguntas forKey:cat];
    }
    
    [categorias removeAllObjects];
    [categorias addObjectsFromArray:[[defesas allKeys] sortedArrayUsingSelector:@selector(compare:)]];
}

- (void)handleSearchForTerm:(NSString *)searchTerm
{
    NSMutableArray *sectionsToRemove = [[NSMutableArray alloc] init];
    [self resetSearch];
    
    for (NSString *categoria in categorias) {
        
        NSArray *perguntas = [[NSArray alloc] initWithArray:[defesas valueForKey:categoria]];
        
        NSMutableArray *toRemove = [[NSMutableArray alloc] init]; 
        
        for (NSArray *pergunta in perguntas) {
            
            NSString *nameDef = [pergunta objectAtIndex:0];
            
            if ([nameDef rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location == NSNotFound)
                [toRemove addObject:pergunta];
        }
        
        if ([perguntas count] == [toRemove count] && [categoria rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location == NSNotFound)
            [sectionsToRemove addObject:categoria];
        
        [[defesas objectForKey:categoria] removeObjectsInArray:toRemove];
    }
    
    [categorias removeObjectsInArray:sectionsToRemove]; 
    [table reloadData];
}

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

    
    allDefesas = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Defesas" ofType:@"plist"]];
    
    defesas = [[NSMutableDictionary alloc] init];
    categorias = [[NSMutableArray alloc] init];
    
    isSearching = NO;
    [self resetSearch];
    [table reloadData];
    [table setContentOffset:CGPointMake(0.0, 44.0) animated:NO];
    
    fontSize = 20.0f;
} 

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    return [categorias count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellDefesasIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...    
    NSString *text = [categorias objectAtIndex:indexPath.row];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    [cell.textLabel setText:text];
    [cell.textLabel setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
    
    
    //Inserção do badge na célula
    CustomBadge *badge = (CustomBadge *)[cell viewWithTag:10];
    
    if (badge == nil)
    {
        badge = [CustomBadge customBadgeWithString:@""];
        [badge setTag:10];
        [badge setUserInteractionEnabled:NO];
        [badge setHidden:YES];
        
        [badge setCenter:CGPointMake(self.view.frame.size.width - badge.frame.size.width/2 - 6, badge.frame.size.height/2 + 6)];
        
        [cell addSubview:badge];
    }
    
    if (isSearching)
    {
        NSInteger qtdePerguntas = [[defesas objectForKey:text] count];
        NSString *badgeValue = [NSString stringWithFormat:@"%d",qtdePerguntas];
        [badge autoBadgeSizeWithString:badgeValue];
        
        [badge setCenter:CGPointMake(self.view.frame.size.width - badge.frame.size.width/2 - 6, badge.frame.size.height/2 + 6)];

        //Faz o teste para verificar se a busca é por categoria
        BOOL isCat = NO;
        
        if ([text caseInsensitiveCompare:[search text]] == NSOrderedSame)
            isCat = YES;
        
        //Se não tem texto na barra de busca, então o badges não serão mostrados
        BOOL nullSearch = NO;
        
        if ([[search text] isEqualToString:@""])
            nullSearch = YES;
            
        
        if (qtdePerguntas != 0 && !isCat && !nullSearch)
            [badge setHidden:NO];
        else
            [badge setHidden:YES];
    }
    else
        [badge setHidden:YES];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    NSString *texto = [categorias objectAtIndex:indexPath.row];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize size = [texto sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}

- (NSIndexPath *)tableView:(UITableView *)tableViewwillSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    isSearching = NO;
    search.showsCancelButton = NO;
    [search resignFirstResponder];
    return indexPath;
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
        isSearching = NO;
        search.showsCancelButton = NO;
        return;
    }
    
    isSearching = YES;
    [self handleSearchForTerm:searchText];
}

//O botão de cancelar da busca foi pressionado
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    
    //Remove os resultados da busca
    isSearching = NO;
    searchBar.showsCancelButton = NO;
    [self resetSearch];
    [table reloadData];
	[self.search resignFirstResponder];
    [table setContentOffset:CGPointMake(0.0, 44.0) animated:YES];
}

//O campo de texto da busca foi selecionado
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
    searchBar.showsCancelButton = YES;
}

#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Prepara o controlador da resposta enviando o nome do arquivo a ser lido
    if ([[segue identifier] isEqualToString:@"seguePerguntaCategoria"])
    {
        PerguntasTableViewController *controller = [segue destinationViewController];
        
        [controller.navigationItem setTitle:[categorias objectAtIndex:table.indexPathForSelectedRow.row]];
        
        CustomBadge *badge = (CustomBadge *)[[table cellForRowAtIndexPath:table.indexPathForSelectedRow] viewWithTag:10];
        
        BOOL buscaCat = NO;
        BOOL noQuestion = NO;
        
        if ([badge.badgeText isEqualToString:@"0"])
            noQuestion = YES;
        
        if ([[categorias objectAtIndex:table.indexPathForSelectedRow.row] caseInsensitiveCompare:search.text] == NSOrderedSame)
            buscaCat = YES;
            
        if (isSearching && !buscaCat && ![[search text] isEqualToString:@""] && !noQuestion)
            controller.termoFiltro = self.search.text;

        controller.categoria = [categorias objectAtIndex: table.indexPathForSelectedRow.row];
        controller.allPerguntas = [[NSArray alloc] initWithArray:[allDefesas objectForKey:controller.categoria] copyItems:YES];
    }
}

@end
