set serveroutput on;

select * from streets;

select * from items;

select * from warehouses;

select * from warehouseItems;

create or replace procedure test(x in number, y out number) as
begin
y := x * x;
end;
/

create or replace function testtt(x in number)
return number is y number;
begin
y := x * x;
return y;
end;
/

create or replace function findItems(x in number)
return array is 
v_array array := array(1000);
v_ok int;
v_cursor_id INTEGER;
v_item_id INTEGER;
v_warehouse_id INTEGER;
v_i INTEGER;
mesaj VARCHAR2(32767);
counter INTEGER;
begin
    v_i := 0;
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
for i in 1 .. 3
loop
    DBMS_OUTPUT.PUT_LINE(x(i));
end loop;

end;
/
-- --------------------------------------------------------------------------

create or replace type nume_array as varray(5000) of varchar2(255);
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
        insert into streets values (v_i, v_nume, TRUNC(DBMS_RANDOM.VALUE(0,10)), v_nume);
        commit;
        
    end loop;
    
    return generate_array;
end;
/
CREATE OR REPLACE DIRECTORY MYDIR as 'C:\Users\Vals_\OneDrive\Desktop\Proiecte\plsql\V2';
/

CREATE OR REPLACE DIRECTORY MYDIR as 'C:\Users\iulia\IdeaProjects\V2';
CREATE Or REPLACE TYPE vector_linie AS  VARRAY(1000) OF INTEGER; 

DECLARE v_fisier UTL_FILE.FILE_TYPE;
v_sir VARCHAR2(250);
v_maxim number(10);
v_index_maxim number(10);
v_per_linie number(10);
v_total number(10);
type vector_linie IS VARRAY(5) OF INTEGER; 
v_per_numar vector_linie;
BEGIN v_fisier:=UTL_FILE.FOPEN('MYDIR','file.txt','R');
v_per_numar := vector_linie(0,0,0,0,0);
v_total := 0;
loop
BEGIN UTL_FILE.GET_LINE(v_fisier,v_sir);
v_total := v_total+1;
--DBMS_OUTPUT.PUT_LINE(v_sir);
v_per_linie := citire_si_prelucrare_linie(v_sir);
--DBMS_OUTPUT.PUT_LINE(v_per_linie);
v_per_numar(v_per_linie) := v_per_numar(v_per_linie)+1;
EXCEPTION 
WHEN NO_DATA_FOUND 
THEN EXIT ;
END; 
end loop;
 if( v_per_numar(1) > 0 )
    then
dbms_output.put_line(' Procentul de strazi care se intersecteaza cu o singura strada este: ' ||  100 / (v_total / v_per_numar(1))||'%.'); 
      else
      
dbms_output.put_line(' Procentul de strazi care se intersecteaza cu o singura strada este: ' || 0 ||'%.'); 
END IF;
      
FOR i in 2 .. 5 LOOP 
    if( v_per_numar(i) > 0 )
    then
      dbms_output.put_line(' Procentul de strazi care se intersecteaza cu alte '|| i || ' strazi este: ' ||  100 / (v_total / v_per_numar(i))||'%.'); 
      else      
      dbms_output.put_line(' Procentul de strazi care se intersecteaza cu alte '|| i || ' strazi este: ' ||  0 ||'%.'); 
 END IF;
   END LOOP; 
UTL_FILE.FCLOSE(v_fisier); 
END; 
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

declare
x nume_array;
begin
x := generate(10);
end;


-- -----------------------------------------------------------