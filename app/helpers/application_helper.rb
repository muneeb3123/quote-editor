module ApplicationHelper
    def render_turbo_stream_flash_messages
        turbo_stream.prepend "flash", partial: "layouts/flash"
    end

    def form_error_notification(object)
        if object.errors.any?
            tag.div class: "error-message" do
                object.errors.full_messages.to_sentence.capitalize
            end
    end
end

def nested_dom_id(*args)
    args.map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join("_")
  end
end


# This method generates a nested DOM ID by combining multiple arguments.
# It checks each argument to see if it responds to the `to_key` method (means check if this object represent table in database or not)
# - If an argument responds to `to_key`, it is assumed to be an Active Record object. (Objects (modals) Representing Tables in the Database are called (ActiveRecord Objects):)
#   The `dom_id` helper method is used to generate a unique DOM ID for this object.
# - If an argument does not respond to `to_key`, it is used as is.
# The resulting parts are joined together with underscores (_) to form a single string.

# Example:
# Given:
#   line_item_date = LineItemDate.find_by(id: 1)  # Simulating an object that responds to to_key (means present in database)
#   new_line_item = LineItem.new  # New Active Record object without an ID (menas did not yet store in database)
# Calling:
#   nested_dom_id(line_item_date, new_line_item)
# Would produce:
#   "line_item_date_1_new_line_item"

# line_item = LineItem.find(1)
# line_item.to_key  # => [1]
# line_item.respond_to?(:to_key)  # => true

# new_line_item = LineItem.new
# new_line_item.to_key  # => nil (not persisted, no ID yet)
# new_line_item.respond_to?(:to_key)  # => true


# Objects That Do Not Represent Tables in the Database:

# Non-ActiveRecord Objects:

# Typically do not represent tables in the database.
# May or may not respond true to respond_to?(:to_key).
# If they do, it's because they have a method defined (to_key) that provides some sort of key or identifier, but not necessarily a database primary key.
