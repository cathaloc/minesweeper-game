collection @tiles, root: :tiles, object_root: false

attributes :x,
  :y,
  :is_dug

attributes :is_mine,
  :nearby_mine_count, if: :is_dug?
