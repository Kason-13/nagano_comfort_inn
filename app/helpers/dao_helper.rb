module DaoHelper

  # method to create a list of it's ids
  def extract_ids(items)
    items_ids = [0] # if empty array if returned, it will appear as null in sql query
                    # added 0 to initial array so it will never be null in query
                    # ids are never 0, I believe it's okay to do so
    items.each do |item|
      items_ids.push(item.id)
    end
    items_ids
  end

end
