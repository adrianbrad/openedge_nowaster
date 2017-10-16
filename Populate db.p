def var be as BE.BELocations.
def var be2 as BE.BEBeverages.
def var be3 as BE.BEMenu.

be2 = new BE.BEBeverages().
be = new BE.BELocations().
be3 = new BE.BEMenu().
/*                              */
be2:fetchData().
be2:storeData().

for each beverage:           
   disp beverage.Name.
   end.                 
