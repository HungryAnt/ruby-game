module GameConfig
  DEBUG = true
  USER_DEBUG = true
  TEST_MONSTER = false

  MAP_WIDTH = 800
  MAP_HEIGHT = 600

  BOTTOM_HEIGHT = 37

  STATUS_BAR_Y = 600 - 21
  STATUS_BAR_WIDTH = 800
  STATUS_BAR_HEIGHT = 58

  WHOLE_WIDTH = MAP_WIDTH
  WHOLE_HEIGHT = STATUS_BAR_Y + STATUS_BAR_HEIGHT

  ACTIONS_BAR_WIDTH = 379
  ACTIONS_BAR_HEIGHT = 42
  ACTIONS_BAR_LEFT = 60
  ACTIONS_BAR_TOP = MAP_HEIGHT - ACTIONS_BAR_HEIGHT

  CHAT_BOARD_WIDTH = 436 - 60
  CHAT_BOARD_HEIGHT = 120
  CHAT_BOARD_LEFT = 60
  CHAT_BOARD_TOP = MAP_HEIGHT - ACTIONS_BAR_HEIGHT - CHAT_BOARD_HEIGHT

  # 每秒产生食物个数
  FOOD_GEN_PER_SECOND = 0.15

  RUNNING_HP_DEC = 0.2
  REST_HP_INC = 0.05
  REST_MANA_INC = 0.5

  CAST_MANA_DEC = 20

  ROLE_INTAKE = 0.2

  # 每秒帧数
  FPS = 40
end