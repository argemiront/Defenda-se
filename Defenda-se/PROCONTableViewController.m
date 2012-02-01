//
//  BuscaTableViewController.m
//  Defenda-se
//
//  Created by Argemiro Neto on 26/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PROCONTableViewController.h"
#import "ArtigosTableViewController.h"

#define ROW_HEIGHT 108

@implementation PROCONTableViewController

@synthesize table, search;


- (void)resetSearch {
    
	NSMutableDictionary *allProconsCopy = [allProcons mutableDeepCopy];
	procons = allProconsCopy;
	
	NSMutableArray *estadosSec = [[NSMutableArray alloc] init];
	[estadosSec addObjectsFromArray:[[allProcons allKeys] sortedArrayUsingSelector:@selector(compare:)]];
	estados = estadosSec;
    
    //Montagem dos indíces
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [temp addObject:UITableViewIndexSearch];
    
    for (NSString *nomeEstado in estados) {
        [temp addObject:[nomeEstado substringFromIndex:(nomeEstado.length - 2)]];
    }
    
    indices = temp;
}

- (void)handleSearchForTerm:(NSString *)searchTerm {
	
	NSMutableArray *sectionsToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *indiceToRemove = [[NSMutableArray alloc] init];
    
	[self resetSearch];
	
	for (NSString *estado in estados)
    { 
		NSMutableArray *array = [procons valueForKey:estado]; 
        NSMutableArray *toRemove = [[NSMutableArray alloc] init];
		
		for (NSArray *unidade in array) {
			
            if ([[unidade objectAtIndex:0] rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location == NSNotFound && [[unidade objectAtIndex:2] rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location == NSNotFound)
				[toRemove addObject:unidade];
        }
        
        if ([array count] == [toRemove count]){
            [sectionsToRemove addObject:estado];
            [indiceToRemove addObject:[estado substringFromIndex:(estado.length - 2)]];
        }
		
        [array removeObjectsInArray:toRemove]; 
	} 
    
    [indices removeObjectsInArray:indiceToRemove];
	[estados removeObjectsInArray:sectionsToRemove];
	[table reloadData];
}


#pragma mark - View lifecycle

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    allProcons = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Procons" ofType:@"plist"]];
    
    isSearching = NO;
    [self resetSearch];
    [table reloadData];
    [table setContentOffset:CGPointMake(0.0, 44.0) animated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    search = nil;
    table = nil;
    
    allProcons = nil;
    procons = nil;
    estados = nil;
    indices = nil;
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
    if ([estados count] == 0)
        return nil;
    else
        return [estados count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([[procons objectForKey:[estados objectAtIndex:section]] count] == 0)
        return 0;
    else
        return [[procons objectForKey:[estados objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PROCONCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    UILabel *municipioLabel = (UILabel *)[cell viewWithTag:1];
    [municipioLabel setText:[[[procons objectForKey:[estados objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectAtIndex:0]];
     
    UILabel *nomeLabel = (UILabel *)[cell viewWithTag:2];
    [nomeLabel setText:[[[procons objectForKey:[estados objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectAtIndex:1]];
    
    UITextView *foneText = (UITextView *)[cell viewWithTag:3];
    [foneText setText:[[[procons objectForKey:[estados objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectAtIndex:3]];
    
    UILabel *enderecoLabel = (UILabel *)[cell viewWithTag:4];
    [enderecoLabel setText:[[[procons objectForKey:[estados objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectAtIndex:2]];
    
    CGSize constraint = CGSizeMake(200, 20000.0f);
    CGSize size = [[enderecoLabel text] sizeWithFont:[UIFont boldSystemFontOfSize:15.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    [enderecoLabel setFrame:CGRectMake(85, 95, 200, MAX(size.height, 22.0f))];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    NSString *texto = [[[procons objectForKey:[estados objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]objectAtIndex:2];
    
    CGSize constraint = CGSizeMake(200, 20000.0f);
    CGSize size = [texto sizeWithFont:[UIFont boldSystemFontOfSize:15.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 22.0f);
    
    return height + ROW_HEIGHT;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([estados count] == 0)
        return nil;
    else
        return [estados objectAtIndex:section];
}

#pragma mark - Table view delegate

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
	NSString *key = [indices objectAtIndex:index];
	if (key == UITableViewIndexSearch) {
		[tableView setContentOffset:CGPointZero animated:NO];
		return NSNotFound;
	}
	else 
        return index - 1;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	[search resignFirstResponder];    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
        return;
    }

    [self handleSearchForTerm:searchText];
}

//O botão de cancelar da busca foi pressionado
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    
    //Remove os resultados da busca
    [self resetSearch];
    isSearching = NO;
    searchBar.showsCancelButton = NO;
    [table reloadData];
    [table setContentOffset:CGPointMake(0.0, 44.0) animated:YES];
    [self.search resignFirstResponder];
}

//O campo de texto da busca foi selecionado
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    isSearching = YES;
    searchBar.showsCancelButton = YES;
	[table reloadData];
}

//Retorna as chaves lateriais da TableView para busca
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
	//Se estamos buscando a barra não deve aparecer
	if (isSearching) {
		return nil;
	}
	return indices;
}

@end
