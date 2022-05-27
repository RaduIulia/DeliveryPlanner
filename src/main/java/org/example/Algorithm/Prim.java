package org.example.Algorithm;

    public class Prim {
        public static void main(String[] args) {
            Graph graph = new Graph(5, false, true);

            graph.addEdge(0, 1, 1);
            graph.addEdge(0, 2, 5);
            graph.addEdge(0, 3, 10);
            graph.addEdge(0, 4, 4);
            graph.addEdge(1, 2, 2);
            graph.addEdge(1, 4, 1);
            graph.addEdge(2, 3, 4);

            int startNode = 0;
            // Distance from the start node to itself is 0
            graph.setEdges(0, startNode);

            for (int i = 0; i < graph.getNumOfNodes() - 1; i++) {
                int node = minEdgeNotIncluded(graph);

                graph.setIncludedInMST(node);

                double[][] matrix = graph.getMatrix();
                for (int v = 0; v < graph.getNumOfNodes(); v++) {
                    if (matrix[node][v] != 0 &&
                            !graph.getIncludedInMST(v) &&
                            matrix[node][v] < graph.getEdges(v)) {
                        graph.setEdges(matrix[node][v], v);
                        graph.setParents(node, v);
                    }
                }
            }

            double cost = 0;
            for (int i = 0; i < graph.getNumOfNodes(); i++) {
                if (i != startNode) {
                    cost += graph.getEdges(i);
                }
            }
            System.out.println(cost);
        System.out.println("MST consists of the following edges:");
    for(int i = 1; i<graph.getNumOfNodes();i++)

        {
            System.out.println("edge: (" + (int) graph.getParents(i) + ", " + i + "), weight: " + graph.getEdges(i));
        }

        }


    public static int minEdgeNotIncluded(Graph graph){
        double min = Double.POSITIVE_INFINITY;
        int minIndex = -1;
        int numOfNodes = graph.getNumOfNodes();

        for(int i = 0; i < numOfNodes; i++){
            if(!graph.getIncludedInMST(i) && graph.getEdges(i) < min){
                minIndex = i;
                min = graph.getEdges(i);
            }
        }
        return minIndex;
    }
}
