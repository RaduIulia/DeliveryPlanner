set serveroutput on;

select * from streets;

select * from items;

select * from warehouses;

select * from warehouseItems;

select * from unavailableItems;


create or replace function findItems(x in number)
return array is 
v_array array := array(500);
v_ok int;
v_cursor_id INTEGER;
v_item_id INTEGER;
v_warehouse_id INTEGER;
v_i INTEGER;
mesaj VARCHAR2(32767);
counter INTEGER;
begin
    v_i := 1;
    v_cursor_id := DBMS_SQL.OPEN_CURSOR;
    DBMS_OUTPUT.PUT_LINE('functie findItems');
    DBMS_SQL.PARSE(v_cursor_id, 'SELECT itemId, warehouseId FROM warehouseItems where itemId = ' || x, DBMS_SQL.NATIVE);
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 1, v_item_id);
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 2, v_warehouse_id);
    DBMS_OUTPUT.PUT_LINE(v_item_id || ' ' || v_warehouse_id);
    v_ok := DBMS_SQL.EXECUTE(v_cursor_id);
    LOOP 
         IF DBMS_SQL.FETCH_ROWS(v_cursor_id)>0 THEN 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 1, v_item_id); 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 2, v_warehouse_id); 
            v_i := v_i + 1;
            DBMS_OUTPUT.PUT_LINE(v_item_id || ' ' || v_warehouse_id || ' v_i = ' || v_i);
            v_array.extend;
--            v_array(v_array.count) := v_warehouse_id;
            v_array(v_i) := v_warehouse_id;
            DBMS_OUTPUT.PUT_LINE(v_array(1) || ' ' || v_i);
            
        ELSE 
            EXIT; 
        END IF; 
    END LOOP;   
    DBMS_OUTPUT.PUT_LINE('outside ' || v_array(v_i));
    DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
    return v_array;
    
    EXCEPTION
        WHEN no_data_found THEN
            SELECT COUNT(*) INTO counter FROM warehouseItems WHERE itemId = 999;
            IF counter = 0 THEN
                mesaj := 'nu exista';
            END IF;
            raise_application_error(-20002, 'nu exista');
--            DBMS_OUTPUT.PUT_LINE('nu exista');
end;
/

select * from warehouseItems where itemId = 3;
/
CREATE OR REPLACE TYPE array AS varray(1000) of number;
/

declare 
x array;
begin
x := findItems(12);
DBMS_OUTPUT.PUT_LINE(x);
end;
/
-- --------------------------------------------------------------------------

create or replace type nume_array as varray(5000) of varchar2(500);
/

create or replace function generate_items(x in number)
return nume_array is
generare_array nume_array := nume_array(5000);
lista_iteme nume_array := nume_array('Apple Juice', 'Grapes', 'Jicama', 'Amberjack', 'Ginger Root', 'Agar', 'Tangelo', 'Pumpkin', 'Abalone', 'Poppy Seed', 'Pears', 'Mango', 'Rhubarb', 'Mirugai clam', 'Garlic Chips', 'Sugar', 'Kiwiberries', 'Okra', 'Whitespotted conger', 'Cinnamon Ground', 'Monkfish', 'Papaya', 'Lemon Pepper', 'Swordfish', 'Papaw', 'Fresh Chillies', 'Salmon', 'Pepper Black Coarse', 'Pineapple', 'Grapefruit', 'Eggplant', 'Japanese whiting', 'Tikka Masala', 'Blue Eye Trevalla', 'Dragonfruit', 'Jerusalem Artichoke', 'Crab', 'Basil', 'Yeast', 'Apricots', 'Zucchini', 'Dotted gizzard shad', 'Coriander Seed', 'Choy Sum', 'Pomegranate', 'Onion', 'Japanese horse mackerel', 'Coriander Leaf', 'Blueberries', 'Prunes', 'Carob Carrot', 'Skipjack tuna', 'Chamomile', 'Dandelion', 'Mandarins', 'Capers', 'Orient clam', 'Fines Herbes', 'Green Beans', 'Feijoa', 'Thai Creen Curry Mix', 'Mackerel', 'Butternut pumpkin', 'Carrot', 'Botan shrimp', 'Mace Ground', 'Soba', 'Kiwi Fruit', 'Asparagus', 'White trevally', 'Tandoori Masala', 'Butternut Lettuce', 'Kohlrabi', 'Octopus', 'Balti Masala', 'Macadamia Nut', 'Guava', 'Asian Greens', 'Salmon roe', 'Nutmeg Ground', 'Eggs', 'Endive', 'Trout', 'Dill Leaf', 'Lamb', 'Cumquat', 'Iceberg lettuce', 'Rose Baie', 'Squash', 'Dates', 'Bastard halibut', 'Curry Thai Green', 'Tea Oil', 'Banana', 'Small amberjack', 'Mango Powder', 'Smoked Trout', 'Lychees', 'Peppers', 'Milt', 'Peppercorns Pink', 'Honeydew melon', 'Cumin Seed Royal', 'Marigold', 'Currants', 'Swiss Chard', 'Trough shells', 'Peppercorns Szechwan', 'Lettuce', 'Alaskan pink shrimp', 'Aniseed Whole', 'Jasmine Rice', 'Green beans', 'Dill Herb', 'Bush Tomato', 'Figs', 'Japanese style-chunky omelette', 'Bay Leaves Chopped', 'Passionfruit', 'Bok Choy', 'Oyster', 'Korma Curry Powder', 'Cantaloupe', 'Radicchio', 'Sea bream', 'Fenugreek Leaf', 'Radish', 'Sprouts', 'Japanese spanish mackerel', 'Wakame', 'Squid', 'Sumac Ground', 'Sweet Potato', 'Horned turban', 'Self Adhesive Spice Labels', 'Soy Sauce', 'Peaches', 'Beans', 'Firefly squid', 'Asafoetida', 'Chinese Five Spice', 'Sultanas', 'Hijiki', 'Herbes de Provence', 'Kangaroo', 'Longan', 'Fromage Blanc', 'Nectarines', 'Bean Sprouts', 'Pepper White Ground', 'Hot Smoked Salmon', 'Snowpea sprouts', 'Japanese sea bass', 'Spearmint', 'Tomatoes', 'Mustard Seed Brown', 'Cauliflower', 'Avocado', 'Chinese Cabbage', 'Garlic Granules', 'Starfruit', 'Nutmeg Whole', 'Galangal', 'Cavalo', 'Eel', 'Pot Marjoram', 'Nori', 'Lemon', 'Bean Shoots', 'Bloody clam', 'BBQ Seasoning', 'Szechuan Pepperberry', 'Paprika Smoked', 'English Spinach', 'Honey', 'Anise Star', 'Brie', 'Red cabbage', 'Sake', 'Rockmelon', 'Cos lettuce', 'Halfbeak', 'Peppercorns Cracked Black', 'Crabs', 'Greater amberjack', 'Thyme', 'Stevia', 'Melon', 'Mixed Herbs', 'Raisin', 'Anise', 'Vegetable Oil', 'Custard Apples Daikon', 'Peppercorns Mixed', 'Brown Flour', 'Coriander Ground', 'Cornmeal', 'Loquats', 'Tuna', 'Parsley', 'Mustard', 'Sweet Laurel', 'Yellow Papaw', 'Curry Leaves', 'Pine Nut', 'Broccoli', 'Sweet Basil', 'Honeydew Melon', 'Garlic Powder', 'Spinach', 'Scallop', 'Curry Thai Red', 'Quinoa', 'Cucumber', 'Amchoor', 'Basil Basmati Rice', 'Chives', 'Fruit', 'Annatto Seed', 'Soymilk', 'Pickling Spice', 'Ras-el-Hanout', 'Fennel', 'Poudre de Colombo', 'Rice Noodles', 'Cornichons', 'Pandanus Leaves', 'Snowpeas', 'Vegetable Seasoning', 'Cacao', 'Cabbage', 'Dark Chocolate', 'Arugula', 'Rogan Josh Mix', 'Sardines', 'Creole Seasoning', 'Margarine', 'Fingerlime', 'Gruyere', 'Oranges', 'Butternut lettuce', 'Tahini', 'Purple carrot', 'Turmeric', 'Blood Oranges', 'Cassia', 'Custard Apples', 'Raspberry', 'Saffron', 'Red Lentils', 'Thai Stir Fry', 'Limes', 'Curry Madras Medium', 'Spelt', 'Tagine Seasoning', 'Cloves', 'Berries', 'Pepper Black Ground', 'Buckwheat Flour', 'Lime Leaves Ground', 'Macadamia Oil', 'Apples', 'Paprika', 'Bonza', 'Celery', 'Tandoori Mix', 'Gula Melaka', 'Tikka Masala Curry Powder', 'Garlic Salt', 'Mulberries', 'Molasses', 'Marjoram', 'Cake', 'Peppercorns Black', 'Common Cultivated Mushrooms', 'Aubergine', 'Turmeric Powder', 'Sesame Seed', 'Barley', 'Cloves Ground', 'Cranberry', 'Corella Pear', 'Dhansak Spice Mix', 'Pasta', 'Star Fruit', 'Brussels Sprouts', 'Rosy seabass', 'Sour Dough Bread', 'Nashi Pear', 'Fennel Seeds', 'Potatoes', 'Piri Piri Seasoning', 'Cottage Cheese', 'Bay Leaves', 'Corn Tortilla', 'Curry Mild', 'Bocconcini', 'Beetroot', 'Pimento Ground', 'Ham', 'Garlic', 'Curry Chinese', 'Peas', 'Spice Charts', 'Purple Rice', 'Wattleseed', 'Sage', 'Corn Oil', 'Blood oranges', 'Leeks', 'German Chamomile', 'Chicken Stock', 'Red Pepper', 'Lime Leaves', 'Flaxseed Oil', 'Cloves Whole', 'Avocado Oil', 'Strawberries', 'Nigella', 'White Flour', 'Parsnip', 'Harissa', 'Allspice Whole', 'Tamari', 'Paprika Hungarian', 'Cous Cous', 'Broccolini', 'Brown Rice', 'Cayenne Pepper', 'Kokam', 'Galangal Ground', 'Haloumi', 'Vegetable Stock', 'Goji Berry', 'Green Pepper', 'Artichoke', 'Sunflower Seeds', 'Rice Flour', 'Seasoning Salt', 'Turnips', 'Nasturtium', 'Peppercorns White', 'French eschallots', 'Pepitas', 'Incaberries', 'Kale', 'Wholewheat Flour', 'Five Spice Mix', 'Brown Rice Vinegar', 'Hummus', 'Balti Stir Fry Mix', 'Blue Cheese', 'Celery Leaf', 'Vermicelli Noodles', 'Sun dried tomatoes', 'Methi Leaves', 'Olives', 'Vanilla Pods', 'Caraway Seed', 'Koshihikari Rice', 'Mangosteens', 'Cumin Seed Black', 'Jarrahdale pumpkin', 'Chicken', 'Rice Syrup', 'Yogurt', 'Curry Hot', 'Liver', 'Mustard Powder', 'Curry Powder', 'Chickory', 'Chickpea', 'Lavender', 'Lemongrass', 'Asian Noodles', 'Fennel Seed', 'Butter', 'Fenugreek Seed', 'Shark', 'Soy Flour', 'Plums', 'Cinnamon Sticks', 'Beef Stock', 'Dried Apricots', 'Cardamom Whole', 'Zahtar Spice Mix', 'Korma Mix', 'Lemon Grass Chopped', 'Yellowtail Kingfish', 'Cumin Ground', 'Chinese 5 Spice', 'Mullet', 'Allspice Ground', 'Blackberries', 'Oysters', 'Dried Chinese Broccoli', 'Paella Seasoning', 'Avocado Spread', 'Butter Beans', 'Kudzu', 'Freekeh', 'Ajwain Seed', 'Red Wine Vinegar', 'Elderberry', 'Dill Seed', 'Chillies Whole', 'White rice', 'Chilli Pepper', 'Oregano', 'Bran', 'Amchur', 'Anchovies', 'Chervil', 'Lobster', 'Cumin Seed', 'Hiramasa Kingfish', 'Coconut Oil', 'Omega Spread', 'Pimento Berries', 'Quark Quinc', 'Albacore Tuna', 'Lemon Grass', 'Watercress', 'Mustard Seed Black', 'Soy Milk', 'Garam Masala', 'Rosemary', 'Rice Paper', 'Red Wine', 'Cinnamon Powder', 'Clams', 'Ajwan Seed', 'Coconut Water', 'Dashi', 'Cherries', 'Juniper Berries', 'Apple Juice Concentrate', 'Cream', 'Hazelnut', 'Apple Cider Vinegar', 'Oyster Sauce', 'Cheddar', 'China Star', 'Coffee', 'Buttermilk', 'Kidneys', 'Haricot Beans', 'French Lavender', 'Mint', 'Chilli Ground', 'Watermelon', 'Orange Zest', 'Horseradish', 'Baking Soda', 'Colombo Powder', 'Water', 'Liquorice Root', 'Tapioca', 'Tofu', 'Walnut', 'Curly Leaf Parsley', 'Rye Bread', 'Methi', 'Yoghurt', 'Pizza Topping Mix', 'Chestnut', 'Malt Vinegar', 'Snapper', 'Iceberg Lettuce', 'Mustard Seed Yellow', 'Extra Virgin Olive Oil', 'Parmesan Cheese', 'Whiting Wild Rice', 'Onion Seed', 'Porcini Mushrooms', 'Semolina', 'Tapioca Flour', 'Borlotti Beans', 'Ricotta', 'Cajun Seasoning', 'Mountain Bread', 'Chia Seeds', 'Polenta', 'Achacha', 'White Wine', 'Mulled Cider Spices', 'Chicken Seasoning', 'Mahlab', 'Mulled Wine Spices', 'Barberry', 'Mahi Mahi', 'Oatmeal', 'Celery Salt', 'Calamari', 'Canola Oil', 'Allspice', 'Rye', 'French Eschallots', 'Biryani Spice Mix', 'Kenchur');
v_item varchar2(255);
type NumberVarray is varray(200) of NUMERIC(10);
myArray NumberVarray := NumberVarray();
v_random numeric(10);
v_ok boolean;
v_gasit numeric(5);
v_at numeric(5);
begin
    delete from warehouseitems;
    delete from warehouses;
    delete from items;
    for i in 1..100
      loop
      myArray.extend();
        myArray(i):= 0;
      end loop;
      v_at := 1;
    for v_i in 1..x loop
        generare_array.extend;
        v_ok := false;
        WHILE v_ok != true
LOOP
     v_random := DBMS_RANDOM.VALUE(1,lista_iteme.count);
     --DBMS_OUTPUT.PUT_LINE(v_random );
     v_gasit := 0;
     for i in 1..100
      loop
      if myArray(i) = v_random
    then 
   v_gasit := v_gasit+1;
    end if;
      end loop; 
      if(v_gasit = 0) then 
      v_ok := true;
      myArray(v_at) :=v_random ;
      v_at := v_at +1;
      end if;
END LOOP;
        v_item := lista_iteme(v_random);
        generare_array(v_i) := v_item;
         --DBMS_OUTPUT.PUT_LINE(v_i || ' ' || v_item || ' ' || TRUNC(DBMS_RANDOM.VALUE(0,100)) );
        insert into items values (v_i, TRIM(v_item),TRUNC(DBMS_RANDOM.VALUE(0,100)));
        commit;
        end loop;
    for i in 1..100
      loop
      DBMS_OUTPUT.PUT_LINE(myArray(i) );
      end loop;  
    return generare_array;
end;
/

declare
x nume_array;
begin
x := generate_items(100);
end;
/

create or replace function generate_warehouse(x in number)
return nume_array is
type NumberVarray is varray(500) of NUMERIC(10);
myArray NumberVarray := NumberVarray();
generare_array nume_array := nume_array(5000);
lista_nume nume_array := nume_array('Maggio-Conn', 'Gerhold, Schmidt and Dickinson', 'Dibbert-Jaskolski', 'Boyle, Rice and Dare', 'Witting LLC', 'Von, Schowalter and Cummerata', 'Hand-Wilderman', 'Wunsch-Predovic', 'Conn, Volkman and Stanton', 'Conroy, Lehner and Gorczany', 'Steuber-Walsh', 'Wilkinson and Sons', 'Swaniawski Inc', 'Gleichner and Sons', 'Vandervort, Hickle and Kautzer', 'Hagenes LLC', 'Cronin, West and Rice', 'OKon and Sons', 'Dietrich, Towne and Torphy', 'Stark Group', 'Swift and Sons', 'Bayer Group', 'Moore, Gerlach and Zboncak', 'Walsh and Sons', 'Leuschke Group', 'Crona-Trantow', 'OConnell LLC', 'Blanda Inc', 'Casper, Ebert and Lockman', 'Lesch, Wyman and Bernier', 'Pfannerstill Group', 'Collins, Lebsack and Hilpert', 'Friesen, Stark and Doyle', 'Bogan and Sons', 'Lang and Sons', 'Hahn, Ratke and Donnelly', 'Collier Inc', 'Brakus-Maggio', 'Satterfield, Schneider and Carroll', 'Hessel and Sons', 'Flatley-Hills', 'Sanford-Quitzon', 'Lebsack-Simonis', 'Ruecker Inc', 'Yundt Group', 'Jakubowski, Cummings and Hauck', 'Wiza Group', 'Bartell, Lindgren and Lueilwitz', 'Stracke-Stamm', 'Dietrich and Sons');
v_num varchar2(255);
v_total number(5);
v_random number(5);
v_ok boolean;
begin
--    delete from warehouseitems;
--    delete from warehouses;
--    delete from items;
for i in 1..500
      loop
      myArray.extend();
        myArray(i):= 0;
      end loop;  
SELECT COUNT(id) INTO v_total FROM streets;
DBMS_OUTPUT.PUT_LINE(v_total );
    for v_i in 1..x loop
        generare_array.extend;
        v_num := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
        generare_array(v_i) := v_num;
        v_ok := false;
        WHILE v_ok != true
LOOP
    v_random := DBMS_RANDOM.VALUE(1,v_total);
    if myArray(v_random) = 0
    then 
    myArray(v_random) :=1;
    v_ok := true;
    end if;
END LOOP;
         DBMS_OUTPUT.PUT_LINE(v_i || ' ' || v_num );
        insert into warehouses values (v_i, TRIM(v_num),v_random);
        commit;
        end loop;
    
    return generare_array;
end;
/

declare
x nume_array;
begin
x := generate_warehouse(5);
end;
/

create or replace function generate(x in number)
return nume_array is
generate_array nume_array := nume_array(5000);
lista_nume nume_array := nume_array('Goldner Garden', 'Houston Harbors', 'Desmond Isle', 'Conner Crest', 'Santos Tunnel', 'Harber Meadow', 'Nu Green', 'Ankunding Mountains', 'Tu Roads', 'Hegmann Crossing', 'Franklyn Glens', 'Rohan Plaza', 'Grace Garden', 'Rutherford Courts', 'Shelby Rue', 'Dicki Track', 'Kertzmann Dale', 'Bergstrom Drive', 'Balistreri Wells', 'Stacy Stream', 'Lehner Plains', 'Rolfson Crossing', 'Casper Ramp', 'Strosin Plain', 'Luci Forest', 'Grant Field', 'Hye Park', 'Israel Lake', 'Schaden Forks', 'Luke Haven', 'Turner Camp', 'Lynch Lodge', 'Callie Port', 'McGlynn Prairie', 'Theresa Mission', 'Farrell Oval', 'Wisoky Extension', 'Greenfelder Mills', 'Wolff Port', 'Amanda Village', 'Marvin Track', 'Bernhard Harbor', 'Kelle Crossroad', 'Conchita Loaf', 'Morissette Estates', 'Gerry Fords', 'Rosamaria Crescent', 'Quigley Manors', 'Wolff Street', 'Merissa Center', 'Bogan Neck', 'Ritchie Streets', 'Lionel Highway', 'Halvorson Knolls', 'Reilly Trail', 'Winfred Square', 'Swaniawski Stravenue', 'Lucila Extension', 'Leslee Village', 'Veum Fields', 'Berge Summit', 'Lynne Village', 'Jovita Dam', 'Abshire Field', 'Albina Lakes', 'Golden Route', 'Sidney Turnpike', 'Jacobson Divide', 'Maryann Views', 'Upton River', 'Schmidt Pines', 'Meg Parks', 'Roberts Rapid', 'Cassin Flat', 'Hayes Trace', 'Song Estate', 'Bergnaum Fords', 'Ryan Shoals', 'Alonso Mountain', 'Price Cape', 'Ronnie Neck', 'Dominique Way', 'Turcotte Mission', 'Dong Grove', 'Gaylord Station', 'Ula Tunnel', 'Cherelle Center', 'Conroy Mountains', 'Volkman Islands', 'Letha Rest', 'Agripina Burgs', 'Dare Haven', 'Emory Fields', 'Richie Squares', 'Gavin Trail', 'Clement Cliff', 'Dirk Ports', 'Walter Pike', 'Lashay Prairie', 'Zulauf Hollow', 'Matilda River', 'Smitham Divide', 'Pagac Valley', 'Oberbrunner View', 'Edward Vista', 'Darwin Light', 'Hudson Cliff', 'Lang Ridge', 'Yer Spring', 'Emmerich Flats', 'Huels Ville', 'Rath Landing', 'Hilton Ridges', 'Gus Club', 'Trudie Islands', 'Hana Island', 'Tommie Island', 'Ike Mall', 'Ed Greens', 'Blanda Plaza', 'Lien Unions', 'Tamatha Terrace', 'Marvin Plains', 'David Isle', 'Angele Mission', 'Julianne Dam', 'Kurt Pine', 'McClure Island', 'Cortney Springs', 'Greenfelder Ville', 'Stanton Estates', 'Sean Drives', 'MacGyver Port', 'Roob Causeway', 'Rutherford Island', 'Tad Roads', 'Howe Pine', 'Heidi Way', 'Conroy Forges', 'Shayla Club', 'Welch Lodge', 'Schiller Parkways', 'Shila Pine', 'Stuart Corners', 'Teofila Route', 'Graig Islands', 'Gerlach Island', 'Murazik Ridges', 'Sherrill Isle', 'Teresita Station', 'Janean Greens', 'Fisher Ville', 'Wolff Burgs', 'Nitzsche Squares', 'Schneider Ways', 'Bobbie Crest', 'Hayes Corner', 'Emmerich Keys', 'Carole Ferry', 'Micah Union', 'Rodney Springs', 'Weissnat Ports', 'Galina Hills', 'Terese Parkways', 'Connell Drives', 'Dee Inlet', 'Dominique Burg', 'Streich Mountain', 'Georgeanna Valleys', 'Boyce Circle', 'Virginia Shores', 'Royce Ferry', 'Corwin Port', 'Rowe Roads', 'Miss Islands', 'Harris Ridge', 'Deidre Street', 'Graham Squares', 'Heidenreich Knoll', 'Homenick Trace', 'Hermiston Street', 'Jayme Courts', 'Stacey Key', 'Ronna Heights', 'Marion Islands', 'Mirella Springs', 'Koepp Spurs', 'Jon Fort', 'Jay Shoal', 'Rico Islands', 'Schmeler Port', 'Kirlin Rest', 'Nader Road', 'Lowe Isle', 'Andre Center', 'Ping Mount', 'Kozey Avenue', 'Huey Isle', 'Boehm Forest', 'Alfonzo Ridges', 'Jarrod Stravenue', 'Littel Trace', 'Lakeisha Lakes', 'Harvey Causeway', 'Fritsch Mission', 'Hartmann Walk', 'Hand Square', 'Hodkiewicz Islands', 'Chet Terrace', 'Bailey Stravenue', 'Paucek Summit', 'MacGyver Ramp', 'Simon Circle', 'Yessenia Place', 'Berge Corners', 'Wuckert Track', 'Lavelle Summit', 'Natalie Landing', 'Idella Brook', 'Ernser Centers', 'Koepp River', 'Lan Fields', 'Volkman Keys', 'Heathcote Islands', 'Earnestine Mews', 'Cassaundra Plains', 'Powlowski Drive', 'Luther Keys', 'Eleonore Club', 'Keebler Turnpike', 'Crona Terrace', 'Huel View', 'Tremblay Path', 'Connelly Camp', 'Garrett Passage', 'Anh Meadow', 'Mitchell Estates', 'Stokes Pine', 'Bryce Square', 'Mamie Pine', 'Dicki Mall', 'Aufderhar Spur', 'Schumm Knolls', 'Rickie Forges', 'Barbera Brook', 'Garret Road', 'Sherrell Walks', 'Shannon Squares', 'Kena Islands', 'Mel Glen', 'Jerde Summit', 'Laurel Ville', 'Lamar Terrace', 'Danica Lake', 'Hilpert Wall', 'Latesha Squares', 'Cameron Wall', 'Runolfsdottir Brooks', 'Lashon Freeway', 'Eloisa Corners', 'Eula Expressway', 'Darcie Forges', 'Rasheeda Shoals', 'Marie Brooks', 'Darryl Mission', 'Gorczany Burg', 'Turner Points', 'Mann Squares', 'Jackeline Forest', 'Daisy Harbor', 'Isiah Ports', 'Colin River', 'Hector Point', 'Connelly Isle', 'Haag Key', 'Schmeler Highway', 'Simonis Tunnel', 'Lockman Summit', 'Dean Estates', 'Ryann Fords', 'Gale Pines', 'Denesik Shores', 'Raynor Island', 'Wilderman Fork', 'Eddy Falls', 'Andy Mountains', 'Kristofer Valley', 'Schulist Lights', 'Israel Creek', 'Welch Gateway', 'Karol Street', 'Hagenes Trail', 'Ima Mountains', 'Cronin Square', 'Douglas Common', 'Florentino Plaza', 'Sonny Passage', 'Manuel Bridge', 'Rath Rue', 'Stehr Ridge', 'Reinger Fields', 'West Causeway', 'Rolfson Inlet', 'Quitzon Mission', 'Barton Drive', 'Crona Branch', 'Reinaldo Spring', 'Doyle Green', 'Waelchi Estate', 'Marlon Lakes', 'Henry Squares', 'Quintin Mews', 'Walker Course', 'Corwin Summit', 'Winston Road', 'Stacy Crescent', 'Terrance Spur', 'Moises Ports', 'Kandra Walks', 'Abshire Gateway', 'Smitham Lakes', 'Hammes Mews', 'Jose Grove', 'Jeremy Groves', 'Val Brooks', 'Juliane Cliff', 'Runolfsdottir Mill', 'Konopelski Extensions', 'Ward Shore', 'Morar Via', 'Sauer Lane', 'Grimes Crescent', 'Terrell Ways', 'Lisbeth Plaza', 'Durgan Isle', 'Ellis Stream', 'Walter Corner', 'Bashirian Highway', 'Bednar Branch', 'Jasper Village', 'Schiller Trail', 'Ron Fort', 'Abbott Views', 'Botsford Vista', 'Glover Course', 'Bosco Loaf', 'Strosin Village', 'Breitenberg Springs', 'Winston Lights', 'Peter Wall', 'Anna Extensions', 'Farrell Islands', 'Jacobs Common', 'Tama Fields', 'Roger View', 'Lewis Throughway', 'Micah Orchard', 'Turcotte Spring', 'Harris Locks', 'McKenzie Row', 'Cortez Fords', 'Courtney Track', 'Renda Light', 'Melisa Views', 'Senger Bypass', 'Schaefer Valleys', 'VonRueden Prairie', 'Lubowitz Isle', 'Johnathan Oval', 'Concetta Parks', 'Lavada Mountain', 'Shara Lake', 'Satterfield Meadow', 'Leonie Drives', 'Carter Curve', 'Wuckert Turnpike', 'Cole Mount', 'Douglas Stravenue', 'Streich Walk', 'Haag Route', 'Dawne Prairie', 'Betty Square', 'Ellan Bypass', 'Upton River', 'Kelvin Falls', 'Shanahan Run', 'Hackett Common', 'Lyle Keys', 'Jacki Fort', 'Purdy Mission', 'Ester Village', 'Kristie Mountain', 'Sebastian Orchard', 'Cecille Keys', 'Grant Burg', 'Johnathon Heights', 'Streich Plains', 'Gaylord Groves', 'Betsey Vista', 'Rosenbaum Green', 'Wiley Shoals', 'Deeanna Garden', 'Vandervort Trafficway', 'Wehner Lock', 'Julene Viaduct', 'Schiller Drive', 'Wiegand Mountains', 'Angle Views', 'Mertz Plaza', 'Ledner Estates', 'Dirk Roads', 'Prince Fall', 'Fabian Landing', 'Barton Rapid', 'Maryetta Manors', 'Sanford Passage', 'Turcotte Tunnel', 'Yundt Gardens', 'Kirlin Manor', 'Ziemann Plains', 'Bogisich Turnpike', 'Zboncak Plaza', 'Josef Mount', 'Corkery Turnpike', 'Melissia Trail', 'Stroman Village', 'Janyce Fords', 'Mckinley Meadow', 'Nigel Rue', 'Ozie Row', 'Christopher Stream', 'Clelia Track', 'Kerluke Springs', 'Dare Valley', 'Williamson Ranch', 'Mante Mission', 'Tromp Expressway', 'Reinger Points', 'Waelchi Ranch', 'Glen Heights', 'Muller Shore', 'Myriam Parkways', 'Carolin Extensions', 'Gerlach Flat', 'Hettinger Bridge', 'Tora Spring', 'Carey Street', 'Larson Shores', 'Romaguera Knoll', 'Kasha Vista', 'Schuppe Creek', 'Williamson Drive', 'Hettinger Stream', 'Weissnat Center', 'Pouros Rest', 'Leandro Ville', 'Theresa Unions', 'Littel Summit', 'Jaskolski Highway', 'Bogisich Vista', 'Vinita Grove', 'Christiane Curve', 'Sipes Plains', 'Schmeler Court', 'Robbie Isle', 'Kerluke Pine', 'Raven Spurs', 'Sanford Spurs', 'Towanda Square', 'Sipes Falls', 'Wendolyn Freeway', 'Denna Underpass', 'Claude Pass', 'Morton Prairie', 'Enda Common', 'Dooley Curve', 'Osvaldo Club', 'Paucek Forks', 'Bednar Creek', 'Frami Wells', 'Freida Squares', 'Nestor Islands', 'Magan Lodge', 'Bechtelar Curve', 'Feil Crest', 'Charles Skyway', 'Tai Fork', 'Jakubowski Hollow', 'Gutkowski Court', 'Paucek Overpass', 'Hermann Manor', 'Schoen Glens', 'Littel Station', 'Kling Parks', 'Reichel Island', 'Beier Fort', 'Reilly Lodge', 'Bradtke Field', 'Wehner Forges', 'Michael Ranch', 'Deckow Divide', 'Barrows Avenue', 'Emmett Port', 'France Station', 'Erasmo Rapids', 'Mina Spurs', 'Rubye Village', 'Marin Extensions', 'Parker Street', 'Stacey Crossroad', 'Wilderman Shoal', 'Sierra Pines', 'Ricardo Field', 'Berge Plains', 'Barabara Curve', 'Delia Glen', 'Tanya Tunnel', 'Hane Mission', 'Aurelio Glen', 'Marcelino Ford', 'Gislason Fields', 'Harvey Tunnel', 'Crysta Throughway', 'Edgardo Center', 'Van Path', 'Carla Route', 'Denita Oval', 'Champlin Common', 'Brakus Vista', 'Johnson Mission', 'Jenae Wall', 'Macejkovic Forest', 'Raynor Loaf', 'Turner Rest', 'Merna Spur', 'Hoyt Rapids', 'Stehr Path', 'Scottie Wells', 'Krystle Inlet', 'Murray Cliff', 'Louann Pass', 'Jude Points', 'Maxwell Estate', 'Mohr Gateway', 'Elijah Lane', 'Krissy Path', 'Pfannerstill Lane', 'Parker Drives', 'Frami Knoll', 'Milan Shoals', 'Runolfsson Parkways', 'Harvey Overpass', 'Fahey Road', 'Nienow Falls', 'Walsh Cove', 'Smitham Fork', 'Leland Plain', 'Deckow Divide', 'Bechtelar Lodge', 'Champlin Passage', 'Feeney Isle', 'John Extensions', 'Quigley Cove', 'Shanahan Corner', 'Frederick Motorway', 'Grimes Grove', 'Legros Villages', 'Lina Isle', 'Pura Meadows', 'Ollie Green', 'Beier Mountains', 'Emard Springs', 'Bayer Island', 'Arnoldo Burg', 'Garfield Point', 'Mohr Valley', 'Cheri Crescent', 'Jeanett Junction', 'Jamison Plaza', 'Bernardo Spurs', 'Torp Coves', 'Oscar Terrace', 'Patsy Spurs', 'Domenica Landing', 'Boyer Flat', 'Fausto Shore', 'Borer Motorway', 'Stiedemann Islands', 'Dara Spurs', 'Langworth Brooks', 'Melany Corner', 'Rodolfo Rapid', 'Erin Drive', 'Gutmann Freeway', 'Ardelle Plains', 'Deckow Creek', 'Howe Fort', 'Bogisich Fields', 'Stacy Plain', 'Mills Fork', 'Strosin Fall', 'Kunze Dale', 'Torri Rue', 'Madelene Alley', 'Flatley Park', 'Kelley Burgs', 'Clemente Causeway', 'Royal Green', 'Valentine Circles', 'Trey Inlet', 'Elroy Lodge', 'Nicolas Ramp', 'Clarinda Plaza', 'Klein Station', 'Gutkowski Station', 'Thanh Flats', 'Kulas Underpass', 'Gislason Walk', 'David Walks', 'Grazyna Plains', 'Talisha Club', 'Rickey Lights', 'Marcella Tunnel', 'Hermiston Pine', 'Keila Point', 'Nienow Plains', 'Seth Prairie', 'Sharie Track', 'Quentin Branch', 'Schimmel Summit', 'Odis Burgs', 'Steuber Village', 'Loyd Corners', 'Leannon Course', 'Shields Corners', 'Marvin Rest', 'Ilda Throughway', 'Carlo Mountains', 'Jacobs Crossroad', 'Leffler Club', 'Joane Lights', 'Stroman Mills', 'Abbott Light', 'Carmon Villages', 'Paola Parks', 'Casey Squares', 'Alesha Track', 'Turner Path', 'Dave Rest', 'Strosin Ville', 'Konopelski Mount', 'Ai Place', 'Bode Throughway', 'Murphy River', 'Haywood Pass', 'Rosetta Glen', 'Durgan Lakes', 'Bogan Rapids', 'Sporer Cliff', 'Bashirian Plaza', 'Laurice Stream', 'Stacy Path', 'Okuneva Turnpike', 'Williams Spurs', 'Graham Oval', 'Mills Motorway', 'Hickle Crossing', 'Eusebio Green', 'Cummings Gateway', 'Emely Village', 'Keith Fort', 'Reichel Ports', 'Kiehn Tunnel', 'Buckridge Keys', 'Roscoe Cliff', 'Ezekiel Pike', 'Fadel Extension', 'Kozey Bridge', 'Tyler Inlet', 'Pearlie Spur', 'Bergnaum Circle', 'Sammie Light', 'Manuel Forks', 'Mindi Track', 'Sherman Cliff', 'Weimann Vista', 'Hahn Well', 'Lynch Viaduct', 'Bechtelar Well', 'Hermila Locks', 'Schroeder Junction', 'Romaguera Park', 'Pfeffer Trace', 'Lowe Grove', 'Tasia Valleys', 'Hirthe Park', 'McClure Coves', 'Frami Key', 'Eugene Bridge', 'Christy Glen', 'Kutch Glen', 'Walsh Court', 'Robt Burgs', 'Ezekiel Way', 'McKenzie Stravenue', 'Myles Trail', 'Johnsie Crest', 'Leatrice Garden', 'Hoppe Corners', 'Feest Circle', 'Hilll Ramp', 'Mayert Field', 'Torphy Island', 'Considine Rapid', 'Bednar Mount', 'Harris Meadows', 'Len Prairie', 'Hilpert Point', 'Rath Hills', 'Boyle Overpass', 'Gutkowski Skyway', 'Royce Ports', 'Adolfo Trail', 'Toy Estates', 'Danette Lodge', 'Dibbert Springs', 'Pollich Row', 'Cristopher Corners', 'Wintheiser Cliffs', 'Kulas Isle', 'Paris Point', 'Walter Fork', 'Krajcik Burg', 'Torphy Mountains', 'Huels Spur', 'Jakubowski Circles', 'Kirlin Center', 'Dennis Isle', 'Kent Forks', 'Walsh Fields', 'Hahn Branch', 'Regine Parkway', 'Dare Points', 'Peggie Radial', 'Smith Squares', 'Gerry Brook', 'Dicki Divide', 'Pagac Station', 'Waelchi Prairie', 'Lorrine Forge', 'Hiram Course', 'Lavera Creek', 'Sun Park', 'Boyd Mountain', 'Glen Knolls', 'Connelly Lake', 'Warren Mountains', 'Micah Creek', 'Tabatha Ferry', 'Evonne Heights', 'Olson Coves', 'Bryce Mountain', 'Janice Wells', 'Marquis Place', 'Delois Parkways', 'Orn Spring', 'Sauer Rapid', 'Lewis Skyway', 'Alisha Creek', 'Kemmer Plains', 'Candelaria Terrace', 'Blair Knolls', 'McDermott Locks', 'Kiana Pass', 'Spinka Mountains', 'Haley Inlet', 'Rueben Inlet', 'Hyatt Port', 'Thanh Track', 'Schaden Park', 'Stark Forks', 'Wuckert Alley', 'Azalee Brooks', 'Jayne Mall', 'Davis Key', 'Jacobson Forks', 'Katelynn Track', 'Karmen Mills', 'Quigley Hill', 'Brakus Heights', 'Winnie Summit', 'Lind Lights', 'Suzanne Way', 'Champlin Via', 'Williamson Grove', 'Maryellen Stravenue', 'Danita Curve', 'Darron Ways', 'Rowe Ranch', 'Bernhard Flat', 'Rory View', 'Ritchie Neck', 'Mohr Plaza', 'Hermiston Valley', 'Ayanna Grove', 'Quentin Circle', 'Daugherty Shores', 'Williamson View', 'Yuri Groves', 'Klein Unions', 'Gorczany Courts', 'Xiomara Ridge', 'Connie Lock', 'Alden Corner', 'Deckow Stream', 'Streich Trafficway', 'Era Turnpike', 'Prohaska Parkways', 'Treutel Brooks', 'Oberbrunner Club', 'Toy Meadows', 'Lueilwitz Terrace', 'Jamey Roads', 'Dare Mission', 'Vandervort Trail', 'Tanja Lakes', 'Marion Vista', 'Gema Harbors', 'Olevia Prairie', 'Feeney Route', 'Carroll Cove', 'Corkery Circle', 'Colin Trail', 'Hector Highway', 'Kunde Ramp', 'Jesse Via', 'Dietrich Camp', 'John Gardens', 'Tammi Islands', 'Kuhn Cove', 'Malinda Spring', 'Pfeffer Mount', 'Corrina Lake', 'Seymour Ferry', 'Kertzmann Village', 'Allena Isle', 'Tanja Springs', 'Legros Pass', 'Stoltenberg Junction', 'Luther Greens', 'Frami Haven', 'Fahey Harbor', 'Glinda Crest', 'Ressie Isle', 'Upton Points', 'Ewa Circles', 'Kunde Corners', 'Andres Meadow', 'Wiley Fort', 'Schiller Village', 'Schaden Ports', 'Angelika Dam', 'Sharyl Spur', 'Monahan Glens', 'Toy Tunnel', 'Clint Crescent', 'Beahan Hollow', 'Funk Mission', 'Yost Flat', 'Koepp Burgs', 'Bahringer Lane', 'Fadel Stream', 'Block Stream', 'Carolee Burg', 'Gulgowski Shoal', 'Predovic Mall', 'Jayne Burgs', 'Holly Pines', 'Alejandrina Fork', 'Mann Street', 'Conroy Mountain', 'Antone Stream', 'Debby Roads', 'Klein Lane', 'Bednar Way', 'Ping Mission', 'Keefe Mountains', 'Johnston Ramp', 'Kent Green', 'Raynor Way', 'Jeremy Courts', 'Kenneth Mews', 'Walsh Manor', 'Reynolds Shoal', 'Marylin Bridge', 'Alfred Squares', 'Layla Gateway', 'Okuneva Center', 'Will Forges', 'Wolf Station', 'Ernie Ville', 'Domenic Circle', 'Kutch Summit', 'Barbie Estates', 'Kulas Rue', 'Carlene Via', 'Jettie Grove', 'Howell Springs', 'Waelchi Mills', 'Travis Glen', 'Collin Mall', 'Haywood Mountains', 'Bogisich Neck', 'Sporer Fort', 'Lind Haven', 'Dach Springs', 'Lynch Track', 'Crist Green', 'Lakendra Green', 'Steuber Trafficway', 'Nolan Summit', 'Hubert Parkway', 'Ned Trail', 'Bechtelar Light', 'Kemmer Canyon', 'Tequila Village', 'Cyndy Radial', 'Kim Cliffs', 'Stanford Valleys', 'Wayne Falls', 'Malik Vista', 'Runolfsson Hills', 'Nicky Mountains', 'Spencer Shore', 'Koepp Mall', 'Viola Mountains', 'Donny Park', 'Haag Coves', 'Reichert Bypass', 'Daryl Parkways', 'Nolan Forge', 'Franchesca Court', 'Yuk Crossroad', 'Zulema Track', 'Herman Mission', 'Renner Burgs', 'Sidney Place', 'Marquardt Bridge', 'Devon Mill', 'Nichelle Land', 'Runolfsdottir Stravenue', 'Ryan Stravenue', 'Len Turnpike', 'Gottlieb Turnpike', 'Leffler Harbors', 'Chrystal Springs', 'Tammie Freeway', 'Francine Unions', 'Turcotte Fords', 'Thompson Fields', 'Johnathan Row', 'Bella Prairie', 'Kohler Knoll', 'Konopelski Summit', 'Russel Circles', 'Shannan Key', 'Denesik Wells', 'Mueller Fords', 'Maurice Mills', 'Jacobi Greens', 'Hartmann Freeway', 'Alexandra Curve', 'Lasonya Ports', 'Dewey Springs', 'Dominga Freeway', 'Botsford Causeway', 'White Lock', 'Cassin Way', 'Elijah Keys', 'Marquardt Fort', 'Steuber Villages', 'Lebsack Expressway', 'Bruen Manor', 'Darrin Mount', 'Hyman Mountains', 'Eugenie Green', 'Carroll Forest', 'Fae Orchard', 'Haley Brooks', 'Wintheiser Loop', 'VonRueden Radial', 'Nereida Plain', 'Ella Port', 'Herman Shoal', 'Glover Prairie', 'Merle Knolls', 'Ettie Unions', 'Lula Springs', 'Stiedemann Mews', 'Echo Spurs');
v_nume varchar2(255);
begin
    delete from streets;
    for v_i in 1..x loop
        generate_array.extend;
        v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
        generate_array(v_i) := v_nume;
        DBMS_OUTPUT.PUT_LINE(v_i || ' ' || v_nume || ' ' || TRUNC(DBMS_RANDOM.VALUE(0,10)) || ' ' || '');
        insert into streets values (v_i, TRIM(v_nume), TRUNC(DBMS_RANDOM.VALUE(0,10)+1), v_nume);
        commit;
        
    end loop;
    
    return generate_array;
end;
/

create or replace procedure createInventory(items in number, warehouses in number) IS
v_w int;
v_i int;
begin
    for v_w in 1..warehouses
    loop
        for v_i in 1..items
        loop
            if (DBMS_RANDOM.VALUE(0, 100) < 70) then
                insert into warehouseItems values(v_i, v_w);
            end if;
        end loop;
    end loop;
end;
/
CREATE OR REPLACE DIRECTORY MYDIR as 'C:\Users\Vals_\OneDrive\Desktop\Proiecte\plsql\V2';
/

CREATE Or REPLACE TYPE vector_linie AS  VARRAY(1000) OF INTEGER; 
/

Create or replace FUNCTION citire_si_prelucrare_linie( IN_string IN varchar2 )
RETURN INT AS
v_length number(10);
v_out varchar2(20);
v_int number(10);
v_numar number(10);
Begin
v_numar := 0;
v_length := length(IN_string);
for i in 1..v_length
Loop
v_out  := substr(IN_string,i,1) ;
if(v_out != '0' and v_out != ' ')
then
   --DBMS_OUTPUT.PUT_LINE('True');
   v_numar := v_numar+1;
   --DBMS_OUTPUT.PUT_LINE('False');
end IF;
--DBMS_OUTPUT.PUT_LINE(v_out);
End loop;
--DBMS_OUTPUT.PUT_LINE(v_numar);
return v_numar;
--DBMS_OUTPUT.PUT_LINE('Text printed: ' || IN_string);
End;
/

Create or replace FUNCTION ministatistica_strazi
RETURN varchar2 AS
v_fisier UTL_FILE.FILE_TYPE;
v_sir VARCHAR2(2500);
v_maxim number(10);
v_index_maxim number(10);
v_per_linie number(10);
v_ramase number(10);
v_strazi number(10);
v_return varchar2(500);
type vector_linie IS VARRAY(5) OF INTEGER; 
v_per_numar vector_linie;
BEGIN v_fisier:=UTL_FILE.FOPEN('MYDIR','file.txt','R');
v_per_numar := vector_linie(0,0,0,0,0);
v_strazi := 1;
loop
BEGIN UTL_FILE.GET_LINE(v_fisier,v_sir);
--DBMS_OUTPUT.PUT_LINE(v_sir);
v_per_linie := citire_si_prelucrare_linie(v_sir);
--DBMS_OUTPUT.PUT_LINE(v_per_linie);
v_per_numar(v_per_linie) := v_per_numar(v_per_linie)+1;
v_strazi := v_strazi +1;
EXCEPTION 
WHEN NO_DATA_FOUND 
THEN EXIT ;
END; 
end loop;
v_strazi:= v_strazi-1;
v_ramase := v_strazi -(v_per_numar(1)+v_per_numar(2)+v_per_numar(3)+v_per_numar(4)+v_per_numar(5));
v_return := 'Procentul de strazi care nu se intersecteaza cu nicio strada este: '||v_ramase||'%.'|| chr(10);
 if( v_per_numar(1) > 0 )
    then
--dbms_output.put_line(' Procentul de strazi care se intersecteaza cu o singura strada este: ' ||  100 / (v_total / v_per_numar(1))||'%.'); 
      v_return := v_return||'Procentul de strazi care se intersecteaza cu o singura strada este: ' ||  trunc(100 / (v_strazi / v_per_numar(1)),2)||'%.'|| chr(10);
      else
     -- dbms_output.put_line(' Procentul de strazi care se intersecteaza cu o singura strada este: ' || 0 ||'%.'); 
       v_return := v_return||'Procentul de strazi care se intersecteaza cu o singura strada este: ' || 0 ||'%.'|| chr(10);
END IF;
      
FOR i in 2 .. 5 LOOP 
    if( v_per_numar(i) > 0 )
    then
    v_return := v_return||'Procentul de strazi care se intersecteaza cu alte '|| i || ' strazi este: ' ||  trunc(100 / (v_strazi / v_per_numar(i)),2)||'%.'|| chr(10);
    --dbms_output.put_line(' Procentul de strazi care se intersecteaza cu alte '|| i || ' strazi este: ' ||  100 / (v_total / v_per_numar(i))||'%.'); 
      else   
      v_return := v_return|| 'Procentul de strazi care se intersecteaza cu alte '|| i || ' strazi este: ' ||  0 ||'%.'|| chr(10);
     -- dbms_output.put_line(' Procentul de strazi care se intersecteaza cu alte '|| i || ' strazi este: ' ||  0 ||'%.'); 
 END IF;
   END LOOP; 
UTL_FILE.FCLOSE(v_fisier);
return v_return;
END; 
/

declare
x varchar2(500);
begin
x := ministatistica_strazi();
DBMS_OUTPUT.PUT_LINE(x);
end;

-- -----------------------------------------------------------
-- -----------------------------------------------------------


/
CREATE OR REPLACE FUNCTION findStreetById(x IN NUMBER) 
RETURN varchar2 AS
    v_return varchar2(4000);
    v_id INTEGER;
    v_nume_strada varchar2(255);
    v_cost INTEGER;
    v_intersectare varchar2(255);
    counter INTEGER;
BEGIN
    SELECT id, nume_strada, cost, intersectare INTO v_id, v_nume_strada, v_cost, v_intersectare FROM streets WHERE id = x;
    v_return := v_id || ' ' || v_nume_strada || ' ' || v_cost || ' ' || v_intersectare;
    RETURN v_return;
    EXCEPTION
        WHEN no_data_found THEN
            SELECT COUNT(*) INTO counter FROM streets WHERE id = x;
            IF COUNTER = 0 THEN
                raise_application_error (-20002, 'Nu exista strada cu id-ul ' || x);
            END IF;
    
END;
/

CREATE OR REPLACE DIRECTORY MYDIR as 'C:\Users\iulia\IdeaProjects\V2';
/

DECLARE
  TYPE rand IS RECORD
  (
    val1   NUMBER,
    val2   NUMBER,
    val3   NUMBER
  );
  TYPE randtabel IS TABLE OF rand;
  TYPE rand_randtabel IS TABLE OF randtabel;
  matrice   rand_randtabel := rand_randtabel();
  v_length number(5);
  v_fisier UTL_FILE.FILE_TYPE;
v_sir VARCHAR2(250);
BEGIN
v_fisier:=UTL_FILE.FOPEN('MYDIR','file.txt','R');
loop
  BEGIN UTL_FILE.GET_LINE(v_fisier,v_sir);
  v_length := length(v_sir)/2;
  EXCEPTION 
WHEN NO_DATA_FOUND 
THEN EXIT ;
END; 
end loop;
 dbms_output.put_line(v_length);   
  matrice.EXTEND(v_length);
  FOR i IN 1 .. matrice.COUNT LOOP
    matrice(i) := randtabel();
    matrice(i).EXTEND(v_length);
    FOR j IN 1 .. matrice(i).COUNT LOOP
      matrice(i)(j).val1 := i;
      matrice(i)(j).val2 := j;
      if(i!=j)
      then
      matrice(i)(j).val3 := DBMS_RANDOM.VALUE(1,10);
      else
       matrice(i)(j).val3 :=0;
       end if;
    END LOOP;
  END LOOP;
   FOR i IN 1 .. matrice.COUNT LOOP
    FOR j IN 1 .. matrice(i).COUNT LOOP
      DBMS_OUTPUT.PUT( ' index i: ' || matrice(i)(j).val1
                    || ' indej j:' || matrice(i)(j).val2
                    || ' valoare matrice[i][j]: ' || matrice(i)(j).val3 ||' ' );
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
  END LOOP;

    DBMS_OUTPUT.NEW_LINE;
     DBMS_OUTPUT.NEW_LINE;
      DBMS_OUTPUT.NEW_LINE;
FOR k IN 1 .. matrice.COUNT LOOP
    FOR i IN 1 .. matrice(k).COUNT LOOP
       FOR j IN 1 .. matrice(k).COUNT LOOP
        if(matrice(i)(j).val3>(matrice(i)(k).val3+matrice(k)(j).val3))
     then 
         matrice(i)(j).val3:=(matrice(i)(k).val3+matrice(k)(j).val3);
         end if;
    END LOOP;
      END LOOP;
      end loop;
  FOR i IN 1 .. matrice.COUNT LOOP
    FOR j IN 1 .. matrice(i).COUNT LOOP
      DBMS_OUTPUT.PUT( ' index i: ' || matrice(i)(j).val1
                    || ' indej j:' || matrice(i)(j).val2
                    || ' valoare matrice[i][j]: ' || matrice(i)(j).val3 ||' ' );
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
  END LOOP;
END;
/

Create or replace FUNCTION calculare_distanta_minima
RETURN varchar2 AS
v_fisier UTL_FILE.FILE_TYPE;
v_sir VARCHAR2(250);
v_maxim number(10);
v_index_maxim number(10);
v_per_linie number(10);
v_ramase number(10);
v_strazi number(10);
v_return varchar2(500);
type vector_linie IS VARRAY(5) OF INTEGER; 
v_per_numar vector_linie;
BEGIN v_fisier:=UTL_FILE.FOPEN('MYDIR','file.txt','R');
loop
BEGIN UTL_FILE.GET_LINE(v_fisier,v_sir);
--DBMS_OUTPUT.PUT_LINE(v_sir);
v_per_linie := citire_si_prelucrare_linie(v_sir);
--DBMS_OUTPUT.PUT_LINE(v_per_linie);
v_per_numar(v_per_linie) := v_per_numar(v_per_linie)+1;
v_strazi := v_strazi +1;
EXCEPTION 
WHEN NO_DATA_FOUND 
THEN EXIT ;
END; 
end loop;
end;
/


Create or replace FUNCTION citire_si_prelucrare_linie( IN_string IN varchar2 )
RETURN INT AS
v_length number(10);
v_out varchar2(20);
v_int number(10);
v_numar number(10);
Begin
v_numar := 0;
v_length := length(IN_string);
for i in 1..v_length
Loop
v_out  := substr(IN_string,i,1) ;
if(v_out != '0' and v_out != ' ')
then
   --DBMS_OUTPUT.PUT_LINE('True');
   v_numar := v_numar+1;
   --DBMS_OUTPUT.PUT_LINE('False');
end IF;
--DBMS_OUTPUT.PUT_LINE(v_out);
End loop;
--DBMS_OUTPUT.PUT_LINE(v_numar);
return v_numar;
--DBMS_OUTPUT.PUT_LINE('Text printed: ' || IN_string);
End;
/



select * from streets where nume_strada like 'Janice Wells';
/
CREATE OR REPLACE FUNCTION findStreetByName(x IN VARCHAR2) 
RETURN string_array AS
    return_array string_array := string_array();
    v_return varchar2(500);
    v_id INTEGER;
    v_nume_strada varchar2(255);
    v_cost INTEGER;
    v_intersectare varchar2(255);
    counter INTEGER;
    v_cursor_id INTEGER;
    v_ok INTEGER;
    v_i INTEGER;
    x_varchar varchar2(255);
    v_idd int;
    vect array := array(100);
    v_count int;
    v_ii int;
BEGIN
    v_i := 1;
    v_ii := 1;

    x_varchar := '%' || x || '%';
    v_cursor_id := DBMS_SQL.OPEN_CURSOR;
    dbms_output.put_line('find street by name');
    
    for c in ( SELECT id INTO v_idd FROM streets WHERE nume_strada like x_varchar )
    loop
        vect.extend;
        vect(v_ii) := c.id;
        v_ii := v_ii + 1;
    end loop;
    for v_count in 1..v_ii-1
    loop
    v_idd := vect(v_count);
    DBMS_SQL.PARSE(v_cursor_id, 'SELECT id, nume_strada, cost, intersectare FROM streets WHERE id = ' || ' ' || v_idd || ' ', DBMS_SQL.NATIVE);

--    DBMS_SQL.BIND_VARIABLE(v_cursor_id, ':x_varchar', v_nume_strada);

    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 1, v_id); 
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 2, v_nume_strada, 255); 
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 3, v_cost);   
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 4, v_intersectare, 255);   
    v_ok := DBMS_SQL.EXECUTE(v_cursor_id);
    
    LOOP 
         IF DBMS_SQL.FETCH_ROWS(v_cursor_id) > 0 THEN 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 1, v_id); 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 2, v_nume_strada); 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 3, v_cost);
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 4, v_intersectare);
            
            v_return := v_id || ' ' || v_nume_strada || ' ' || v_cost || ' ' || v_intersectare;

            return_array.extend;
            return_array(v_i) := v_return;
            v_i := v_i + 1;
        ELSE 
            EXIT; 
        END IF; 
    END LOOP;
    end loop;
    return return_array;
    DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
    EXCEPTION
        WHEN no_data_found THEN
            SELECT COUNT(*) INTO counter FROM streets WHERE nume_strada like x_varchar;
            IF COUNTER = 0 THEN
                raise_application_error (-20005, 'Nu exista strada cu numele ' || x);
                return_array(1) := 'Nu exista';
                return return_array;
            END IF;
    
    
END;
/

CREATE OR REPLACE FUNCTION findStreetByCost(x IN NUMBER) 
RETURN nume_array AS
    return_array nume_array := nume_array(100);
    v_return varchar2(4000);
    v_id INTEGER;
    v_nume_strada varchar2(255);
    v_cost INTEGER;
    v_intersectare varchar2(255);
    counter INTEGER;
    v_cursor_id INTEGER;
    v_ok INTEGER;
    v_i INTEGER;
BEGIN
    v_i := 0;
    v_cursor_id := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(v_cursor_id, 'SELECT id, nume_strada, cost, intersectare FROM streets WHERE cost = ' || x, DBMS_SQL.NATIVE);
    
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 1, v_id); 
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 2, v_nume_strada, 255); 
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 3, v_cost);   
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 4, v_intersectare, 255);   
    
    v_ok := DBMS_SQL.EXECUTE(v_cursor_id);
    
    
    LOOP 
         IF DBMS_SQL.FETCH_ROWS(v_cursor_id)>0 THEN 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 1, v_id); 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 2, v_nume_strada); 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 3, v_cost);
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 4, v_intersectare);
            v_return := v_id || ' ' || v_nume_strada || ' ' || v_cost || ' ' || v_intersectare;
            v_i := v_i + 1;
            return_array.extend;
            return_array(v_i) := v_return;
        ELSE 
            EXIT; 
        END IF; 
    END LOOP;   
    DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
    return return_array;
    EXCEPTION
        WHEN no_data_found THEN
            SELECT COUNT(*) INTO counter FROM streets WHERE cost = x;
            IF COUNTER = 0 THEN
                raise_application_error (-20004, 'Nu exista strada cu costul ' || x);
            END IF;
END;
/

CREATE OR REPLACE FUNCTION findStreetByIntersections(x IN VARCHAR2) 
RETURN string_array AS
    return_array string_array := string_array();
    v_return varchar2(500);
    v_id INTEGER;
    v_nume_strada varchar2(255);
    v_cost INTEGER;
    v_intersectare varchar2(255);
    counter INTEGER;
    v_cursor_id INTEGER;
    v_ok INTEGER;
    v_i INTEGER;
    x_varchar varchar2(255);
    v_idd int;
    vect array := array(100);
    v_count int;
    v_ii int;
BEGIN
    v_i := 1;
    v_ii := 1;

    x_varchar := '%' || x || '%';
    v_cursor_id := DBMS_SQL.OPEN_CURSOR;
    dbms_output.put_line('find street by name');
    
    for c in ( SELECT id INTO v_idd FROM streets WHERE intersectare like x_varchar )
    loop
        vect.extend;
        vect(v_ii) := c.id;
        v_ii := v_ii + 1;
    end loop;
    for v_count in 1..v_ii-1
    loop
    v_idd := vect(v_count);
    DBMS_SQL.PARSE(v_cursor_id, 'SELECT id, nume_strada, cost, intersectare FROM streets WHERE id = ' || ' ' || v_idd || ' ', DBMS_SQL.NATIVE);

--    DBMS_SQL.BIND_VARIABLE(v_cursor_id, ':x_varchar', v_nume_strada);

    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 1, v_id); 
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 2, v_nume_strada, 255); 
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 3, v_cost);   
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 4, v_intersectare, 255);   
    v_ok := DBMS_SQL.EXECUTE(v_cursor_id);
    
    LOOP 
         IF DBMS_SQL.FETCH_ROWS(v_cursor_id) > 0 THEN 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 1, v_id); 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 2, v_nume_strada); 
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 3, v_cost);
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, 4, v_intersectare);
            
            v_return := v_id || ' ' || v_nume_strada || ' ' || v_cost || ' ' || v_intersectare;

            return_array.extend;
            return_array(v_i) := v_return;
            v_i := v_i + 1;
        ELSE 
            EXIT; 
        END IF; 
    END LOOP;
    end loop;
    return return_array;
    DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
    EXCEPTION
        WHEN no_data_found THEN
            SELECT COUNT(*) INTO counter FROM streets WHERE intersectare like x_varchar;
            IF COUNTER = 0 THEN
                raise_application_error (-20005, 'Nu exista nicio strada cu numele ' || x);
                return_array(1) := 'Nu exista';
                return return_array;
            END IF;
    
END;
/

declare
x string_array := string_array(500);
i INTEGER;
begin
x := findStreetByIntersections('Fo');
--x := findStreetByName('Ozi');
--for i in 1..1 loop
--dbms_output.put_line(x(1));
--end loop;
end;
/

CREATE OR REPLACE FUNCTION checkStockItems(x IN VARCHAR2) 
RETURN VARCHAR2 AS
y INTEGER;
v_nume varchar2(255);
BEGIN
    y := 0;
    SELECT COUNT(*) INTO y FROM ITEMS WHERE nume like x || '%' or LOWER(nume) like x || '%';
    IF y = 1 THEN
        SELECT nume into v_nume from items where nume like x || '%' or LOWER(nume) like x || '%';
        RETURN v_nume;
    ELSIF y > 1 THEN
        RETURN '2';
    ELSE 
        RETURN '0';
    END IF;
END;
/

CREATE OR REPLACE FUNCTION clientOrder(nume in VARCHAR2, lista in nume_array)
RETURN VARCHAR2 AS
v_id number(10);
v_nume varchar2(255);
v_lista nume_array := nume_array(500);
v_lista_produse varchar2(4000);
v_i int;
v_j int;
v_warehouses int;
v_items int;
v_ok int;
v_item_name varchar2(255);
v_exists int;
v_depozite varchar2(400);
v_item_id int;
v_ids array := array(500);
v_counter int;
begin
    v_depozite := '';
    v_lista := lista;
    dbms_output.put_line('Client Order');
    SELECT COUNT(*) INTO v_warehouses FROM warehouses;
    
    for v_counter in 1..lista.count loop
        dbms_output.put_line('v_lista(' || v_counter || ') = ' || v_lista(v_counter));
        SELECT id INTO v_item_id FROM items WHERE nume = v_lista(v_counter);
        dbms_output.put_line('v_item_id = ' || v_item_id);
        for v_i in 1..v_warehouses loop
            dbms_output.put_line('v_i = ' || v_i);
            SELECT COUNT(*) INTO v_j FROM warehouseItems WHERE warehouseId = v_i and itemId = v_item_id;
            if (v_j > 0) THEN
                v_depozite := v_depozite || v_i || ' ';
            end if;
        end loop;
        v_depozite := v_depozite || '| ';
    end loop;
    for v_counter in 1..lista.count - 1 loop
    v_lista_produse := v_lista_produse || v_lista(v_counter) || ', ';
    end loop;
    v_lista_produse := v_lista_produse || v_lista(lista.count);
    SELECT COUNT(*) INTO v_id FROM orders;
    insert into orders values(v_id, 'Order ' || v_id, v_lista_produse);
    return v_depozite;
end;
/

--declare
--v_exists int;
--v_item_name varchar2(255);
--v_items nume_array := nume_array(10);
--begin
----v_item_name := 'Cumin';
----SELECT COUNT(*) into v_exists FROM orders WHERE v_item_name like '%' || lista || '%';
----dbms_output.put_line(v_exists);
--v_items.extend;
--v_items(1) := 'Raspberry';
--v_items(2) := 'Figs';
--v_item_name := clientOrder('test', v_items);
--dbms_output.put_line(v_item_name);
--end;
--/
create or replace type nume_array as varray(5000) of varchar2(500);
/


CREATE OR REPLACE procedure adauga_item_negasit(v_nume in VARCHAR2) is
v_i int;
begin
       SELECT COUNT(id) INTO v_i FROM unavailableItems;
        --DBMS_OUTPUT.PUT_LINE(v_i || ' ' || v_nume);
        v_i := v_i +1;
        insert into unavailableItems values (v_i, TRIM(v_nume));
        commit;
end;
/
declare 
begin
adauga_item_negasit('Apa');
--DBMS_OUTPUT.PUT_LINE(x);
end;
/