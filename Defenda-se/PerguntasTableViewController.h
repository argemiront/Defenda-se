//
//  PerguntasTableViewController.h
//  Defenda-se
//
//  Created by Argemiro Neto on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerguntasTableViewController : UITableViewController
{
    UISearchBar *search;
    UITableView *table;
    NSString *categoria;
    NSString *termoFiltro;
    
    NSMutableArray *perguntas;
    NSArray *allPerguntas;
}

@property (nonatomic, retain) IBOutlet UISearchBar *search;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSString *categoria;
@property (nonatomic, retain) NSString *termoFiltro;

@property (nonatomic, retain) NSArray *allPerguntas;

- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;

@end
