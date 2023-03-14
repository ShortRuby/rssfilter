module CreateItem
  module_function

  def new_item(title:, link:, description: "Optional")
    FakeItem.new(title:, link:, description:)
  end
end
