$:.unshift(File.dirname(__FILE__))

require 'views/main_window'

window = MainWindow.new
window.show