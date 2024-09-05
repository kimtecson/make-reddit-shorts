# app/helpers/devise_helper.rb
module DeviseHelper
    def devise_error_messages!
      return "" if resource.errors.empty?
  
      # Collect unique error messages
      unique_messages = resource.errors.full_messages.uniq
  
      # Build HTML for the errors, excluding the default "Please review the problems below" text
      html = <<-HTML
      <div class="alert alert-danger">
        <ul>
          #{unique_messages.map { |msg| "<li>#{msg}</li>" }.join}
        </ul>
      </div>
      HTML
  
      html.html_safe
    end
  end