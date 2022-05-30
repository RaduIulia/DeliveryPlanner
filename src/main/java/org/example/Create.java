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
import java.sql.*;
import java.util.*;

public class Create {
    private final DBConnect conn;
    ConfigPanel configPanel;
    int streets;
    int items = 100;
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

        createTables();

//        for(int i = 0; i < streets; i++){
//            Street street = new Street(i, faker.address().streetName(), random.nextInt(10), distances[i]);
//            streetList.add(street);
//        }

        for(Street i : streetList){
            System.out.println(i.getName() + " " + i.getCost() + " | " + i.neighborhood(streetList));
            Add.createStreet(conn.connection, i, streetList);
        }
        //for(int i = 0; i < 100; i++){
        //    Item item = new Item(i, faker.beer().name(), random.nextInt(5));
        //   itemList.add(item);
        //   Add.createItem(conn.connection, item);
       // }

//        for(int i = 0; i < 3; i++){
//            Warehouses warehouses = new Warehouses(i, faker.name().lastName());
//            warehousesList.add(warehouses);
//            Add.createWarehouse(conn.connection, warehouses);
//        }

//        for(Warehouses w : warehousesList)
//            for(Items i : itemsList)
//                if(random.nextInt(10) < 7)
//                    Add.createInventory(conn.connection, w.getId(), i.getId());

        // generam produsele
        CallableStatement callableStatement = conn.connection.prepareCall("begin ? := generate_items(?); end;");
        callableStatement.registerOutParameter(1, OracleTypes.ARRAY, "NUME_ARRAY");
        callableStatement.setInt(2, items);
        callableStatement.execute();
        Array result = callableStatement.getArray(1);

        Object obj = result.getArray();

        Object [] objectArray = (Object []) obj;   // cast it to an array of objects

        StringBuffer buffer = new StringBuffer("");
        result = callableStatement.getArray(1);

        obj = result.getArray();

        objectArray = (Object []) obj;   // cast it to an array of objects

        buffer = new StringBuffer("");
        buffer.append(String.valueOf(objectArray[0]));

        for (int j=1; j < objectArray.length; j++)
        {
            buffer.append(", ").append(String.valueOf(objectArray[j]));
        }

        for(int i = 1; i <= items; i++){
            Items items = new Items(i,Find.findNameById2(conn.connection, i), Find.findCostById2(conn.connection,i));
            itemsList.add(items);
        }

        for(Items i : itemsList){
            System.out.println(i.getId() + " " + i.getName() + " | " + i.getPret());
        }
        callableStatement.close();
        

        // generam strazile
        callableStatement = conn.connection.prepareCall("begin ? := generate(?); end;");
        callableStatement.registerOutParameter(1, OracleTypes.ARRAY, "NUME_ARRAY");
        callableStatement.setInt(2, streets);
        callableStatement.execute();

        result = callableStatement.getArray(1);

        obj = result.getArray();

        objectArray = (Object []) obj;   // cast it to an array of objects

        buffer = new StringBuffer("");
        buffer.append(String.valueOf(objectArray[0]));

        for (int j=1; j < objectArray.length; j++)
        {
            buffer.append(", ").append(String.valueOf(objectArray[j]));
        }

        for(int i = 1; i <= streets; i++){
            Street street = new Street(i, Find.findNameById(conn.connection, i), Find.findCostById(conn.connection, i), distances[i-1]);
            streetList.add(street);
        }


        callableStatement.close();

        buildMatrix();
        writeFile();

        for(Street s : streetList){
            callableStatement = conn.connection.prepareCall("UPDATE streets SET intersectare = ? WHERE id = ?");
            System.out.println("s.getName() = " + s.getName());
            String neighborhood = String.valueOf(s.neighborhood(streetList));
            System.out.println("vecini: " + neighborhood);
            callableStatement.setString(1, neighborhood);
            callableStatement.setInt(2, s.getId());
            callableStatement.execute();
        }
        callableStatement.close();

        for(Street i : streetList){
            System.out.println(i.getName() + " " + i.getCost() + " | " + i.neighborhood(streetList));

        }

        //mini statistica strazi

        callableStatement = conn.connection.prepareCall("begin ? := ministatistica_strazi(); end;");
        callableStatement.registerOutParameter(1, OracleTypes.VARCHAR);
        callableStatement.execute();
        String result_string = callableStatement.getString(1);
        System.out.print(result_string);

        callableStatement.close();

        //generam depozitele
        int min = 1;
        int wh = (int)Math.floor(Math.random()*(streets/2-min+1)+min);
        callableStatement = conn.connection.prepareCall("begin ? := generate_warehouse(?); end;");
        callableStatement.registerOutParameter(1, OracleTypes.ARRAY, "NUME_ARRAY");
        callableStatement.setInt(2, wh);
        callableStatement.execute();

        result = callableStatement.getArray(1);

        obj = result.getArray();

        objectArray = (Object []) obj;   // cast it to an array of objects

        buffer = new StringBuffer("");
        buffer.append(String.valueOf(objectArray[0]));

        for (int j=1; j < objectArray.length; j++)
        {
            buffer.append(", ").append(String.valueOf(objectArray[j]));
        }


        for(int i = 1; i <= wh; i++){
            Warehouses warehouses = new Warehouses(i, Find.findWarehouseNameById(conn.connection, i));
            warehousesList.add(warehouses);
        }

        System.out.println("warehouses: ");
        for(Warehouses i : warehousesList){
            System.out.println(i.getId() + " " + i.getName());
        }
        callableStatement.close();

        // cream inventarul
        callableStatement = conn.connection.prepareCall("{call createInventory(?, ?)}");
        System.out.println(itemsList.size() + " " + warehousesList.size());
        callableStatement.setInt(1, itemsList.size());
        callableStatement.setInt(2, warehousesList.size());
        callableStatement.execute();
        callableStatement.close();

        // cautam un produs sa vedem daca il avem pe stoc
        callableStatement = conn.connection.prepareCall("begin ? := findItems(?); end;");
        callableStatement.registerOutParameter(1, OracleTypes.ARRAY, "ARRAY");
        callableStatement.setInt(2, 1);
        callableStatement.execute();
        result = callableStatement.getArray(1);

        obj = result.getArray();

        objectArray = (Object []) obj;   // cast it to an array of objects

        buffer = new StringBuffer("");
        buffer.append(String.valueOf(objectArray[0]));
        for (int j=1; j < objectArray.length; j++)
        {
            buffer.append(", ").append(String.valueOf(objectArray[j]));
        }
        System.out.println(buffer);

    }

    private void buildMatrix() {
        int i, j;
        int count;
        int max=10;
        int min=1;
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
                    distances[i][j] = streetList.get(i).getCost();
                    distances[j][i] =streetList.get(j).getCost();
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
