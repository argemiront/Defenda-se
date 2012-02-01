//
//  CDC.h
//  Defenda-se
//
//  Created by Argemiro Neto on 16/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCTableViewController : UITableViewController
{
    NSDictionary *artigos;
    
    UISearchBar *search;
    UISearchDisplayController *searchDisplay;
    UITableView *table;
    
    NSMutableArray *baseBusca;
    NSMutableArray *resultadoBusca;
    BOOL buscaArtigo;
}

@property (nonatomic, retain) IBOutlet UISearchBar *search;
@property (nonatomic, retain) IBOutlet UITableView *table;

-(void)carregaDadosBusca;
- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;

@end
