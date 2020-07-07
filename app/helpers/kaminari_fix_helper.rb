module KaminariFixHelper
  # use an older version of page_entries_info
  # because newer version also loads the items from database
  # also the multiple count statements are run for older version
  def page_entries_info(collection, options = {})
    entry_name = options[:entry_name] || collection.entry_name.singularize.downcase
    entry_name = entry_name.pluralize unless collection.total_count == 1

      if collection.total_pages < 2
        t('helpers.page_entries_info.one_page.display_entries', :entry_name => entry_name, :count => collection.total_count)
      else
        first = collection.offset_value + 1
        last = collection.last_page? ? collection.total_count : collection.offset_value + collection.limit_value
        t('helpers.page_entries_info.more_pages.display_entries', :entry_name => entry_name, :first => first, :last => last, :total => collection.total_count)
      end.html_safe
  end

  def arrow_span(html_code)
    content_tag :span, html_code.html_safe, 'aria-hidden': true
  end
end
