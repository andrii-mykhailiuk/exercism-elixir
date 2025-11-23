defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: node_data, right: nil} = node, data) when data > node_data do
    %{node | right: new(data)}
  end

  def insert(%{data: node_data, right: right_node} = node, data) when data > node_data do
    %{node | right: insert(right_node, data)}
  end

  def insert(%{data: node_data, left: nil} = node, data) when data <= node_data do
    %{node | left: new(data)}
  end

  def insert(%{data: node_data, left: left_node} = node, data) when data <= node_data do
    %{node | left: insert(left_node, data)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []

  def in_order(%{data: node_data, left: left_node, right: right_node}) do
    in_order(left_node) ++ [node_data] ++ in_order(right_node)
  end
end
