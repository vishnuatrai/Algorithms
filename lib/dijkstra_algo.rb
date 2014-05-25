# Dijkstra Algorithem how to?
#     * Construct your network (or graph). If this is homework you will already have your network but 
#     if you are using this for practical purposes you will need to construct your network to show all 
#     possible routes and route crossovers. Try to include as many options as you can.
#
#     * Label the starting node with a 0 and put a box/circle around it.
#
#     * Look at each of the arcs connecting to the starting node and choose the one of least value. 
#     Write the value next to the node it is connecting to and draw a box around it.
#
#     * Temporarily label (numbers without boxes) all nodes connecting to the permanent labelled (boxed) 
#     nodes with their distance from the starting point.
#
#     * Chose the temporary label of least value and box it.
#
#     * Repeat steps 4 & 5 until the node you are trying to reach (the destination node) has a permanent label.
#
#     * Retrace the shortest route backwards through the network back to your start node. 
#     You've found the path of least weight!
#
#     Before I start into how Dijkstra's Algorithm does what it does, here is a short description of what 
#     Dijkstra's Algorithm does:
#
#     In a given graph, and starting node, Dijkstra's Algorithm discovers the shortest path from the starting 
#     node to all other nodes.
#
#     Assumptions: The cost/length of travelling between nodes is known.
#
#     Figure 1 displays the graph: nodes are black circles labelled a-f, a path is a black line connecting 
#     two nodes, each path has an associated length beside it (the numbers). The lengths are not to scale.
#
#     Node 'a' is our starting node, we want to find the shortest path to all other nodes in the graph. 
#     To do this, we generate a table. This table has the distance to all the nodes in the graph, from the 
#     perspective of the starting node 'a'.
#
#                 Table 1: Initial Entries for distances to nodes from Node 'a'
#     Node                            Distance to Node from Node 'a'
#     b                               INFINTE
#     c                               INFINTE
#     d                               INFINTE
#     e                               INFINTE
#     f                               INFINTE
#     g                               INFINTE
#     h                               INFINTE
#     i                               INFINTE
#
#     As can be seen from Table 1, the initial entries for the distances are all set to infinity 
#     (or some notional maximum value). This ensures that any path found will be shorter than the 
#     initial value stored in the table.
#
#     The node 'a' is the starting node, as such we examine all the possible paths away from this node first. 
#     The options are as follows:
#
#                 Table 2: Distance to nodes (from 'a') accesible from node 'a'
#     Node                            Distance to Node from Node 'a'
#     b                               7
#     c                               4
#     d                               5
#
#     These values are used to update the graph table, Table 1, which becomes:
#
#                 Table 3: Entries for distances to nodes from Node 'a'
#     Node                            Distance to Node from Node 'a'
#     b                               7
#     c                               4
#     d                               5
#     e                               INFINTE
#     f                               INFINTE
#     g                               INFINTE
#     h                               INFINTE
#     i                               INFINTE
#
#     Figure 2 shows the routes marked in red. We know have three paths from node 'a'. However, 
#     these paths are not yet guaranteed to be the shortest path. To be sure we have the shortest path, 
#     we have to keep going.
#
#     The next move in the algorithm is to move to the nearest node from node 'a'. In this case that is node 'c'.
#
#     At node 'c' we have paths available to nodes 'b' and 'h'. When calculating the distances we have to 
#     calculate the distances from node 'a'. In this case that means the following:
#
#                 Table 4: Distance to nodes (from 'a') accesible from node 'a'
#     Node                            Distance to Node from Node 'a'
#     b                               6
#     h                               13
#
#     These values are then compared to the values stored in the Table 3. It can be seen that both of 
#     these values are less than the current values stored in the table, as such table 3 becomes:
#
#                 Table 5: Entries for distances to nodes from Node 'a'
#     Node                            Distance to Node from Node 'a'
#     b                               6
#     c                               4
#     d                               5
#     e                               INFINTE
#     f                               INFINTE
#     g                               INFINTE
#     h                               13
#     i                               INFINTE
#
#     This step has illustrated one of the advantages of dijkstra's algorithm: the route to node 'b' is not 
#     the most direct route, but it is the shortest route; Dijkstra's Algorithm can find the shortest route, 
#     even when that route is not the most direct route.
#
#     Again, all paths accesible from node 'c' have been checked, and the table of paths has been updated. 
#     Node 'c' is marked as visited.
#
#     IMPORTANT:
#
#     A Visited node is never re-visited.
#     Once a node has been marked visited, the path to that node is known to be the shortest route from the 
#     initial node.
#     In that case, we should add another column to our table:
#
#                 Table 6: Entries for distances to nodes from Node 'a'
#     Node                            Distance to Node from Node 'a'                      Visited
#     b                               6                                                   NO
#     c                               4                                                   YES
#     d                               5                                                   NO
#     e                               INFINTE                                             NO
#     f                               INFINTE                                             NO
#     g                               INFINTE                                             NO
#     h                               13                                                  NO
#     i                               INFINTE                                             NO
#
#     As these value are being updated, the route that accompanies these distances also needs to be stored.
#
#     Once again, the table of paths is consulted, and the shortest path to a node that has not been 
#     visited is found. This node becomes the next current node. In this case, that is node 'd'.
#
#     From node 'd', the following paths are available:
#
#                 Table 7: Distance to nodes (from 'a') accesible from node 'a'
#     Node                            Distance to Node from Node 'a'
#     f                               14
#
#     The table of all paths is updated to reflect that, and the node 'd' is marked as visited, 
#     this locks in the shortest path to node 'd' also:
#
#                 Table 8: Entries for distances to nodes from Node 'a'
#     Node                            Distance to Node from Node 'a'                      Visited
#     b                               6                                                   NO
#     c                               4                                                   YES
#     d                               5                                                   YES
#     e                               INFINTE                                             NO
#     f                               14                                                  NO
#     g                               INFINTE                                             NO
#     h                               13                                                  NO
#     i                               INFINTE                                             NO
#
#     It can be seen from table 8 above, that the next nearest node to node 'a' is node 'b'. 
#     All paths from node 'b' are examined next. In this instance, we have a path to a node that is 
#     marked as visited: node 'c', we already know that the path to node 'c' is as short as it can get 
#     (the node being marked as visited is the marker for this).
#
#     As figure 6 shows, we check the path the only other node accesible from node 'b': node 'e'. 
#     This updates our paht table as follows:
#
#                 Table 9: Entries for distances to nodes from Node 'a'
#     Node                            Distance to Node from Node 'a'                      Visited
#     b                               6                                                   YES
#     c                               4                                                   YES
#     d                               5                                                   YES
#     e                               31                                                  NO
#     f                               14                                                  NO
#     g                               INFINTE                                             NO
#     h                               13                                                  NO
#     i                               INFINTE                                             NO
#
#     Table 9 again tells us that the next node for us to visit is node 'h'.
#
#     We add up the paths, and mark the nodes as visited...
#
#     We keep on doing this....
#
#     Until all the nodes have been visited!
#
class Edge
  attr_accessor :src, :dst, :length
      
  def initialize(src, dst, length = 1)
    @src = src
    @dst = dst
    @length = length
  end
end

class Graph < Array
  attr_reader :edges

  def initialize
    @edges = []
  end

  def connect(src, dst, length = 1)
    unless self.include?(src)
      raise ArgumentException, "No such vertex: #{src}"
    end
    unless self.include?(dst)
      raise ArgumentException, "No such vertex: #{dst}"
    end
    @edges.push Edge.new(src, dst, length)
  end

  def connect_mutually(vertex1, vertex2, length = 1)
    self.connect vertex1, vertex2, length
    self.connect vertex2, vertex1, length
  end

  def neighbors(vertex)
    neighbors = []
    @edges.each do |edge|
      neighbors.push edge.dst if edge.src == vertex
    end
    return neighbors.uniq
  end

  def length_between(src, dst)
    @edges.each do |edge|
      return edge.length if edge.src == src and edge.dst == dst
    end
    nil
  end

  def dijkstra(src, dst = nil)
    distances = {}
    previouses = {}
    self.each do |vertex|
      distances[vertex] = nil # Infinity
      previouses[vertex] = nil
    end
    distances[src] = 0
    vertices = self.clone
    until vertices.empty?
      nearest_vertex = vertices.inject do |a, b|
        next b unless distances[a]
        next a unless distances[b]
        next a if distances[a] < distances[b]
        b
      end
      break unless distances[nearest_vertex] # Infinity
      if dst and nearest_vertex == dst
        path = get_path(previouses, src, dst)
        return { path: path, distance: distances[dst] }
      end
      neighbors = vertices.neighbors(nearest_vertex)
      neighbors.each do |vertex|
        alt = distances[nearest_vertex] + vertices.length_between(nearest_vertex, vertex)
        if distances[vertex].nil? or alt < distances[vertex]
          distances[vertex] = alt
          previouses[vertex] = nearest_vertex
          # decrease-key v in Q # ???
        end
      end
    end
    if dst
      return nil
    else
      paths = {}
      distances.each { |k, v| paths[k] = get_path(previouses, src, k) }
      return { paths: paths, distances: distances }
    end
  end
private
  def get_path(previouses, src, dest)
    path = get_path_recursively(previouses, src, dest)
    path.is_a?(Array) ? path.reverse : path
  end

  # Unroll through previouses array until we get to source
  def get_path_recursively(previouses, src, dest)
    return src if src == dest
    raise ArgumentException, "No path from #{src} to #{dest}" if previouses[dest].nil?
    [dest, get_path_recursively(previouses, src, previouses[dest])].flatten
  end
end


graph = Graph.new
(1..6).each {|node| graph.push node }
graph.connect_mutually 1, 2, 7
graph.connect_mutually 1, 3, 9
graph.connect_mutually 1, 6, 14
graph.connect_mutually 2, 3, 10
graph.connect_mutually 2, 4, 15
graph.connect_mutually 3, 4, 11
graph.connect_mutually 3, 6, 2
graph.connect_mutually 4, 5, 6
graph.connect_mutually 5, 6, 9
 
p graph
p graph.length_between(2, 1)
p graph.neighbors(1)
p graph.dijkstra(1) # => { paths: { node1: [src, node2, dest] }, distances: { node1: 2 } }
p graph.dijkstra(1, 5) # => { path: [src, node2, dest], distance: 2 }


