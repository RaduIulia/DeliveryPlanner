package org.example;

import com.github.javafaker.Faker;

import oracle.jdbc.OracleTypes;
import org.example.DAO.Add;
import org.example.DAO.Find;
import org.example.Entity.Items;
import org.example.Entity.Intersection;
import org.example.Entity.Street;
import org.example.Entity.Warehouses;
import org.example.panel.ConfigPanel;
import org.example.Algorithm.*;

import java.io.*;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

public class Create {
    private final DBConnect conn;
    ConfigPanel configPanel;
    int streets;
    private final int[][] distances = new int[10000][10000];
    List<Street> streetList = new LinkedList<>();
    List<Intersection> intersections = new LinkedList<>();
    List<Warehouses> warehousesList = new ArrayList<>();
    List<Items> itemsList = new ArrayList<>();

    public Create(int streets) throws SQLException, IOException {
        this.streets = streets;
        conn = DBConnect.createConnection();

        Faker faker = new Faker();
        Random random = new Random();

//        readFile();
        buildMatrix();
        createTables();
        writeFile();

//        for(int i = 0; i < streets; i++){
//            Street street = new Street(i, faker.address().streetName(), random.nextInt(10), distances[i]);
//            streetList.add(street);
//        }

        File fileName = new File("generate.txt");

        BufferedWriter writer = new BufferedWriter(new FileWriter(fileName));

        for(Street i : streetList){
            System.out.println(i.getName() + " " + i.getCost() + " | " + i.neighborhood(streetList));
            Add.createStreet(conn.connection, i, streetList);
            writer.write("'" + i.getName() + "', ");
        }
        writer.close();
        for(int i = 0; i < 100; i++){
            Items items = new Items(i, faker.beer().name(), random.nextInt(5));
            itemsList.add(items);
            Add.createItem(conn.connection, items);
        }

        for(int i = 0; i < 3; i++){
            Warehouses warehouses = new Warehouses(i, faker.name().lastName());
            warehousesList.add(warehouses);
            Add.createWarehouse(conn.connection, warehouses);
        }

        for(Warehouses w : warehousesList)
            for(Items i : itemsList)
                if(random.nextInt(10) < 7)
                    Add.createInventory(conn.connection, w.getId(), i.getId());


        CallableStatement callableStatement = conn.connection.prepareCall("begin ? := findItems(?); end;");
        callableStatement.registerOutParameter(1, OracleTypes.ARRAY, "ARRAY");
        callableStatement.setInt(2, 3);
        callableStatement.execute();
        Array result2 = callableStatement.getArray(1);

        Object obj = result2.getArray();

        Object [] objectArray = (Object []) obj;   // cast it to an array of objects

        StringBuffer buffer = new StringBuffer("");
        buffer.append(String.valueOf(objectArray[0]));
        for (int j=1; j < objectArray.length; j++)
        {
            buffer.append(", ").append(String.valueOf(objectArray[j]));
        }

        callableStatement = conn.connection.prepareCall("begin ? := generate(?); end;");
        callableStatement.registerOutParameter(1, OracleTypes.ARRAY, "NUME_ARRAY");
        callableStatement.setInt(2, streets);
        callableStatement.execute();
        System.out.println("abc");
        result2 = callableStatement.getArray(1);

        obj = result2.getArray();

        objectArray = (Object []) obj;   // cast it to an array of objects

        buffer = new StringBuffer("");
        buffer.append(String.valueOf(objectArray[0]));

        for (int j=1; j < objectArray.length; j++)
        {
            buffer.append(", ").append(String.valueOf(objectArray[j]));
        }
        String str[] = buffer.toString().split(",");
        List<String> al = new ArrayList<String>();
        al = Arrays.asList(str);
        for(String s: al){
            System.out.println(s);
        }

        for(int i = 1; i <= streets; i++){
            Street street = new Street(i, Find.findNameById(conn.connection, i), Find.findCostById(conn.connection, i), distances[i-1]);
            streetList.add(street);
        }

        System.out.println("START BUFFER\n" + buffer + "\nEND BUFFER\n");
        for(Street i : streetList){
            System.out.println(i.getName() + " " + i.getCost() + " | " + i.neighborhood(streetList));

        }
        callableStatement.close();

        for(Street s : streetList){
            callableStatement = conn.connection.prepareCall("UPDATE streets SET intersectare = ? WHERE id = ?");
            String neighborhood = String.valueOf(s.neighborhood(streetList));
            callableStatement.setString(1, neighborhood);
            callableStatement.setInt(2, s.getId());
            callableStatement.execute();
        }
        callableStatement.close();

//        Find.findStreetById(conn.connection);
//        Find.findStreetByCost(conn.connection);
        Find.findStreetByName(conn.connection);

//        for(Street s: streetList) {
//            intersections.add(new Intersection(faker.address().streetName(), s.transform(streetList)));
//            intersections.add(new Intersection(faker.address().streetName(), s.transform(streetList)));
//        }

//        System.out.println("\n");
//        for(Intersection intersection : intersections)
//            System.out.println(intersection.getName() + " " + intersection.getStreets());
//        Street.calculate(distances);

//        Find.findStreetById(conn.connection);
//        Find.findStreetByName(conn.connection);
//        Find.findStreetByIntersections(conn.connection);
    }

    private void buildMatrix() {
        int i, j;
        int count;
        Random random = new Random();
        int[] folosite = new int[streets];
        for(i = 0; i < streets; i++){
            for(j = 0; j < streets; j++){
                if(distances[i][j] != 1)
                if(i != j)
                    if(folosite[i]<5)
                        if(folosite[j]<5)
                    if(random.nextBoolean())  {
                    folosite[i]++;
                    folosite[j]++;
                    distances[i][j] = 1;
                    distances[j][i] = 1;
                }
            }
        }
        Graph graph = new Graph(streets, false, true);
        for( i=0;i<streets;i++)
            for(j=0;j<streets;j++)
                if(distances[i][j]>0)
                    graph.addEdge(i,j,distances[i][j]);
          Prim.start(graph);

    }

    public void writeFile() throws IOException {
        int i, j;
        File fileName = new File("file.txt");

        BufferedWriter writer = new BufferedWriter(new FileWriter(fileName));
        for(i = 0; i < streets; i++) {
            for (j = 0; j < streets; j++) {
                writer.write(distances[i][j] + " ");
            }
            writer.write("\n");
        }

        writer.close();

    }
    public void readFile(){
        String file = "C:\\Users\\Vals_\\OneDrive\\Desktop\\adiacenta.txt";
        BufferedReader reader;
        String line;

        int i = 0, j;
        try{
            reader = new BufferedReader(new FileReader(file));
            while((line = reader.readLine()) != null){
                String[] row = line.split(" ");
                for(j = 0; j < streets; j++)
                    distances[i][j] = Integer.parseInt(row[j]);
                i++;
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        System.out.println("Matricea de adiacenta: ");
        for(i = 0; i < streets; i++) {
            for (j = 0; j < streets; j++)
                System.out.print(distances[i][j] + " ");
            System.out.println();
        }
    }

    private void createTables() throws SQLException {
        Statement stmt = conn.connection.createStatement();
        String sql;

        stmt.execute("DROP TABLE warehouseItems");
        stmt.execute("DROP TABLE streets");
        stmt.execute("DROP TABLE items");
        stmt.execute("DROP TABLE warehouses");

        sql = "CREATE TABLE streets (id numeric(5) PRIMARY KEY , nume_strada varchar2(4000), cost numeric, intersectare varchar2(4000))";
        stmt.execute(sql);

        sql = "CREATE TABLE items (id numeric(5) PRIMARY KEY , nume varchar2(255), pret numeric)";
        stmt.execute(sql);

        sql = "CREATE TABLE warehouses (id numeric(5) PRIMARY KEY , nume varchar2(255))";
        stmt.execute(sql);

        sql = "CREATE TABLE warehouseItems (itemId numeric(5) NOT NULL , warehouseId numeric(5) NOT NULL, FOREIGN KEY (itemId) references items(id)," +
                "FOREIGN KEY (warehouseId) references warehouses(id)/*, UNIQUE (itemId, warehouseId)*/)";
        stmt.execute(sql);
    }

    public int[][] getDistances() {
        return distances;
    }

    public List<Street> getStreetList() {
        return streetList;
    }
}
