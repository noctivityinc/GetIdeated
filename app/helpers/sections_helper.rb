module SectionsHelper
  def wizard?
    if !params[:wizard].blank? 
      true
    else
      false
    end
  end

  def prev_section
    return @sections.detect {|s| s.position == @section.position - 1}
  end

  def next_section
    return @sections.detect {|s| s.position == @section.position + 1}
  end

  def minutes_till_permanent(comment)
    return (comment.created_at.min+15) - Time.now.min
  end
end
