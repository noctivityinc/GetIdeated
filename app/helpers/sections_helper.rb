module SectionsHelper

  def minutes_till_permanent(comment)
    return (comment.created_at.min+15) - Time.now.min
  end
end
