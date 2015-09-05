module AntGui
  class Facade
    def self.create_image_button(normal_image_path, hover_image_path)
      raise ArgumentError 'all paths nil' if normal_image_path.nil? && hover_image_path.nil?
      button = AntGui::Control.new
      normal_image = normal_image_path.nil? ? nil : AntGui::Image.new(MediaUtil.get_img(normal_image_path))
      hover_image = hover_image_path.nil? ? nil : AntGui::Image.new(MediaUtil.get_img(hover_image_path))

      if hover_image.nil?
        button.on_mouse_enter {button.content = nil}
      else
        button.on_mouse_enter {button.content = hover_image; button.refresh}
      end

      if normal_image.nil?
        button.on_mouse_leave {button.content = nil}
      else
        button.on_mouse_leave {button.content = normal_image; button.refresh}
      end

      button
    end
  end
end