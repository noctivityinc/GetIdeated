module IdeasHelper
	def first_idea?
		return current_user.ideas.empty?
	end

  def get_progress(idea)
    # give them 1 point just for starting the idea
    sections_with_content = idea.sections.select {|x| !x.content.blank?}.count
    sections_locked = idea.sections.select {|x| x.locked == true}.count
    return (1 + sections_with_content + sections_locked).to_f / (idea.sections.count * 2).to_f * 100
  end
end
