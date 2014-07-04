module ApplicationHelper
  
  def auth_token
    <<-HTML
      <input type="hidden" 
      name="authenticity_token" 
      value='<%= form_authenticity_token %>'>
    HTML
    .html_safe
  end
end
