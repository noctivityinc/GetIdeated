module IdeasHelper
  def get_progress(idea)
    sections_with_content = idea.sections.select {|x| !x.content.blank?}.count
    sections_locked = idea.sections.select {|x| !x.locked}.count
    return (sections_with_content + sections_locked).to_f / (idea.sections.count * 2).to_f * 100
  end
end
