import Model from require "lapis.db.model"

class Tags extends Model
  @constraints: {
    value: (value) =>
      if value != value\lower!
        return "Tags must be lowercase."
  }
