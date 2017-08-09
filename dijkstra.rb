class Node
  attr_accessor :edges_to, :edges_cost, :confirmed, :cost, :previous_node
  attr_reader :id
  def initialize id
    @id = id
  end

  def edges_to
    @edges_to || = []
  end

  def confirmed
    @confirmed ||= false
  end

  def cost
    @cost ||= -1
  end

  def previous_node
    @previous_node ||= nil
  end

  def add_node node, cost
    edges_to.push node
    edges_cost.push cost
  end
end

def create_nodes
  # creating node
  node1 = Node.new 1
  node2 = Node.new 2
  node3 = Node.new 3
  # repaet..

  # define nodes relation and cost
  node1.add_node node2, 4
  node1.add_node node3, 5
  node1.add_node node4, 1

  node2.add_node node1, 4
  node2.add_node node4, 4
  node2.add_node node5, 2
  # repaet..

  [
    node1,
    node2,
    node3,
    # repaet..
  ]
end

# 1. initialization
nodes = create_nodes
nodes.each do |node|
  node.confirmed = false
  node.cost = -1
end

# cost for goal node is 0
nodes[goal].cost = 0 

while true do
  # 2. look for node with status confirmed
  confirmed_node = nil
  nodes.each do |node|
    next if node.confirmed || node.cost < 0
    confirmed_node = node if confirmed_node.nil? || node.cost < confirmed_node.cost
  end
  # End when all nodes get confirmed
  break if confirmed_node.nil?

  # confirm node
  confirmed_node.confirmed = true
  # 3. update information for each nodes
  for i in 0...(confirmed_node.edges_to.length)
    node = confirmed_node.edges_to[i]
    cost = confirmed_node.cost + confirmed_node.edges_cost[i]
    if node.cost < 0 || cost < node.cost
      node.cost = cost 
      node.previous_node = confirmed_node
    end
  end
end
