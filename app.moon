lapis = require "lapis"
config = require("lapis.config").get!

import Users, Items, Tags from require "models"
import respond_to, json_params from require "lapis.application"

class app extends lapis.Application
  @before_filter =>
    if @session.id
      @user = Users\find id: @session.id

  layout: "layout"

  [console: "/console"]: =>
    if @user and @user.admin
      if config and config.console and config.console\lower! == "true"
        require("lapis.console").make(env: "all")(@)
    return status: 401, "401 - Unauthorized"

  [index: "/"]: =>
    if @user
      @list = Items\find user_id: @user.id
      return render: "tagged_list"
    else
      return "Login / account creation to be implemented."

  [command: "/command"]: respond_to {
    POST: json_params =>
      unless @user
        return status: 401, "401 - Unauthorized"

      if @params.check
        if item = Items\find user_id: @user.id, id: @params.check
          _, error_message = item\update done: true
          if error_message
            return status: 500, error_message
      if @params.uncheck
        if item = Items\find user_id: @user.id, id: @params.uncheck
          _, error_message = item\update done: false
          if error_message
            return status: 500, error_message
  }

  [tagged_list: "/t/:tag"]: =>
    unless @user
      return redirect: @url_for "index"

    tag = @params.tag\lower!
    if tag != @params.tag
      return redirect: @url_for "tagged_list", :tag

    @title = "##{tag}"
    if tag = Tags\find user_id: @user.id, value: tag
      @list = Items\select "WHERE id IN (SELECT item_id FROM item_tags WHERE tag_id = ?) ORDER BY sort ASC", tag.id

    return render: true
