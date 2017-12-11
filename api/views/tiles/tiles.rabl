collection @tiles, root: :tiles, object_root: false

attributes :x,
  :y,
  :is_dug,
  :game_id

attributes :is_mine,
  :nearby_mine_count, if: :is_dug?
