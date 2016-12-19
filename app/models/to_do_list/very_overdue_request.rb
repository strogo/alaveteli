module ToDoList
  class VeryOverdueRequest < Item

    def description
      n_("{{count}} request is very overdue.",
         "{{count}} requests are very overdue.",
         count,
         :count => count)
    end

    def items
      @items ||= user.info_requests.very_overdue
    end

    def url
      if count > 1
        alaveteli_pro_info_requests_path('request_filter[filter]' => 'very_overdue')
      else
        show_request_path(items.first.url_title)
      end
    end

    def call_to_action
      n_("Send a follow up (or request an internal review).",
         "Send follow ups (or request internal reviews).",
         count)
    end
  end
end
