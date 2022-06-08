package org.example.Algorithm;

public class Graph {
    private int nodes;
    private boolean directed;
    private boolean weighted;
    private double[][] matrix;

    private double[] edges;
    private double[] parents;
    private boolean[] inMST;

    private boolean[][] isSetMatrix;

    public Graph(int nodes, boolean directed, boolean weighted) {
        this.directed = directed;
        this.weighted = weighted;
        this.nodes = nodes;

        // Simply initializes our adjacency matrix to the appropriate size
        matrix = new double[nodes][nodes];
        isSetMatrix = new boolean[nodes][nodes];

        edges = new double[nodes];
        parents = new double[nodes];
        inMST = new boolean[nodes];

        for(int i = 0; i < nodes; i++){
            edges[i] = Double.POSITIVE_INFINITY;
            parents[i] = -1;
            inMST[i] = false;
        }
    }
    public void addEdge(int source, int destination, float weight) {

        float valueToAdd = weight;

        if (!weighted) {
            valueToAdd = 1;
        }

        matrix[source][destination] = valueToAdd;
        isSetMatrix[source][destination] = true;

        if (!directed) {
            matrix[destination][source] = valueToAdd;
            isSetMatrix[destination][source] = true;
        }
    }

    public void deleteNode(int Node)
    {
      for(int i=0;i<nodes;i++)
          matrix[Node][i]=0;
      for(int i=0;i<nodes;i++)
          matrix[i][Node]=0;
      nodes--;
    }

    public void deleteEdge(int source, int destination)
    {
        matrix[source][destination] = 0;
        isSetMatrix[source][destination] = false;

        if (!directed) {
            matrix[destination][source] = 0;
            isSetMatrix[destination][source] = false;
        }
    }
    public int getNodes() {
        return nodes;
    }

    public double getEdges(int i) {
        return edges[i];
    }

    public void setEdges(double edge, int node) {
        this.edges[node] = edge;
    }

    public boolean getInMST(int i) {
        return inMST[i];
    }

    public void setInMST(int node) {
        this.inMST[node] = true;
    }

    public double[][] getMatrix() {
        return matrix;
    }

    public void setParents(double parent, int node) {
        this.parents[node] = parent;
    }

    public double getParents(int i) {
        return parents[i];
    }
}
