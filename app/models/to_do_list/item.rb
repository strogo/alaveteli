module ToDoList
  class Item

    include Rails.application.routes.url_helpers
    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def count
      items.count
    end

  end
end
