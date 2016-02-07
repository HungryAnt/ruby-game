# coding: UTF-8

class MessageBox
  module BoxType
    BOX_YES_NO = :yes_no
    BOX_OK_CANCEL = :ok_cancel
    BOX_OK = :ok
  end

  @@box_dialog = nil

  def self.register(window)
    @@window = window
  end

  def self.update
    return if @@box_dialog.nil?
    @@box_dialog.mouse_move(@@window.mouse_x, @@window.mouse_y)
  end

  def self.show
    @@box_dialog.draw unless @@box_dialog.nil?
  end

  def self.button_down(id)
    return false if @@box_dialog.nil?
    if id == Gosu::MsLeft
      @@box_dialog.mouse_left_button_down(@@window.mouse_x, @@window.mouse_y)
    end
    true
  end

  def self.info(text, box_type, options={})
    box_width = 300
    box_height = 180
    left = (GameConfig::WHOLE_WIDTH - box_width) / 2
    top = (GameConfig::WHOLE_HEIGHT - box_height) / 2
    dialog = AntGui::Dialog.new(left, top, box_width, box_height)
    canvas = AntGui::Canvas.new
    dialog.content = canvas
    dialog.background_color = 0xBB_000000

    font = get_font
    text_block = AntGui::TextBlock.new font, text, :center, :center
    text_block.foreground_color = 0xFF_FFFFFF
    text_left = 0
    text_top = 0
    text_width = box_width
    text_height = 120
    AntGui::Canvas::set_canvas_props text_block, text_left, text_top, text_width, text_height
    canvas.add text_block

    button_width = 75
    button_height = 23
    button_margin = 20
    button_top = 120
    case box_type
      when BoxType::BOX_OK
        button_ok = create_button '确定'
        button_left = (box_width - button_width) / 2
        AntGui::Canvas::set_canvas_props button_ok, button_left, button_top, button_width, button_height
        canvas.add button_ok

        button_ok.on_mouse_left_button_down { close_and_call_proc options[:ok] }
      when BoxType::BOX_OK_CANCEL
        buttons_width = button_width * 2 + button_margin
        button_left = (box_width - buttons_width) / 2
        button_ok = create_button '确定'
        button_cancel = create_button '取消'
        AntGui::Canvas::set_canvas_props button_ok, button_left, button_top, button_width, button_height
        AntGui::Canvas::set_canvas_props button_cancel, button_left + button_width + button_margin, button_top,
                                         button_width, button_height
        canvas.add button_ok
        canvas.add button_cancel
        button_ok.on_mouse_left_button_down { close_and_call_proc options[:ok] }
        button_cancel.on_mouse_left_button_down { close_and_call_proc options[:cancel] }
    end

    dialog.update_arrange
    @@box_dialog = dialog
  end

  private

  def self.close_and_call_proc(action)
    @@box_dialog = nil
    action.call unless action.nil?
  end

  def self.create_button(text)
    button = AntGui::TextBlock.new get_font, text, :center, :center
    button.background_color = 0xAA_FFFFFF
    button
  end

  def self.get_font
    window_resource_service = get_instance WindowResourceService
    window_resource_service.get_font 16
  end
end