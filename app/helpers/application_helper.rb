module ApplicationHelper
  include LocalTimeHelper
  
  def body_class
    body_class = @body_class || "default"
    body_class += " " + controller.controller_name.dasherize
    body_class += " " + controller.action_name.dasherize
    body_class
  end
end
