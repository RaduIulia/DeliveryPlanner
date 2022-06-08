package org.example.Algorithm;

    public class Prim {
        public static void start(Graph graph) {

            int start = 0;
            // Distance from the start node to itself is 0
            graph.setEdges(0, start);

            for (int i = 0; i < graph.getNodes() - 1; i++) {
                int node = minEdgeNotIncluded(graph);

                graph.setInMST(node);

                double[][] matrix = graph.getMatrix();
                for (int v = 0; v < graph.getNodes(); v++) {
                    if (matrix[node][v] != 0 &&
                            !graph.getInMST(v) &&
                            matrix[node][v] < graph.getEdges(v)) {
                        graph.setEdges(matrix[node][v], v);
                        graph.setParents(node, v);
                    }
                }
            }

            double cost = 0;
            for (int i = 0; i < graph.getNodes(); i++) {
                if (i != start) {
                    cost += graph.getEdges(i);
                }
            }
            System.out.println(cost);
        System.out.println("MST consists of the following edges:");
    for(int i = 1; i<graph.getNodes();i++)

        {
            System.out.println("edge: (" + (int) graph.getParents(i) + ", " + i + "), weight: " + graph.getEdges(i));
        }

        }


    public static int minEdgeNotIncluded(Graph graph){
        double min = Double.POSITIVE_INFINITY;
        int minIndex = -1;
        int numOfNodes = graph.getNodes();

        for(int i = 0; i < numOfNodes; i++){
            if(!graph.getInMST(i) && graph.getEdges(i) < min){
                minIndex = i;
                min = graph.getEdges(i);
            }
        }
        return minIndex;
    }
}
