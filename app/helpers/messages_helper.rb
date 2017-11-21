module MessagesHelper

  def markdown_to_html(text)
    Kramdown::Document.new(text, input: 'GFM').to_html
  end

  def pretty_date(datetime)
    datetime.strftime('%d/%m/%y %H:%M')
  end
end
