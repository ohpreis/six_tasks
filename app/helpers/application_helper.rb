module ApplicationHelper
  require "nokogiri"
  # Include it in the helpers (e.g. application_helper.rb)
  include Pagy::Frontend

  def first_line_of_trix_content(content, length = 30)
    # Convert ActionText::RichText to plain text if necessary
    plain_text = content.respond_to?(:to_plain_text) ? content.to_plain_text : content
    # Use Nokogiri to strip HTML tags
    stripped_content = Nokogiri::HTML(plain_text).text
    # Split the stripped content by newline characters and take the first element
    first_line = stripped_content.split("\n").first
    # Truncate the first line to the specified length
    truncate(first_line, length: length)
  end
end
