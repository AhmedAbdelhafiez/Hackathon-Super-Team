class Item < ApplicationRecord
  has_neighbors :embedding

  def self.get_item(page_name)
    result = Item.where(page_name: page_name)
    if result.count
      return result.first
    end
  end


  def self.get_user_context(user_id)
    result = Item.where(user_id: user_id)
    if result.count
      return result.first
    end
  end

  def append_text(txt)
    self.text+= ("\n" + txt)
    self.save!
  end
end
