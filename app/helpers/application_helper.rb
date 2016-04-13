module ApplicationHelper

  def shares_for_staffs_of(owner)
    ShareAdapter.share_collection_of owner
  end
end
