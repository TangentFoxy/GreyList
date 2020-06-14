import create_table, types from require "lapis.db.schema"

{
  [1592100459]: =>
    create_table "users", {
      { "id", types.serial primary_key: true }
      { "name", types.varchar unique: true }
      { "email", types.varchar null: true }
      { "digest", types.varchar null: true }
      { "admin", types.boolean default: false }
    }
  [1592105973]: =>
    create_table "items", {
      { "id", types.serial primary_key: true }
      { "user_id", types.foreign_key }
      { "content", types.text }
      { "score", types.integer default: 0 }
      { "time", types.double }
      { "sort", types.double }
      { "done", types.boolean default: false }
    }
    create_table "tags", {
      { "id", types.serial primary_key: true }
      { "user_id", types.foreign_key }
      { "value", types.varchar }
      { "score", types.integer default: 0 }
      { "time", types.double }
      { "sort", types.double }
    }
    create_table "item_tags", {
      { "id", types.serial primary_key: true }
      { "tag_id", types.foreign_key }
      { "item_id", types.foreign_key }
    }
}
