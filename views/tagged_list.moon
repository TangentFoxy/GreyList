import Widget from require "lapis.html"

class tagged_list extends Widget
  content: =>
    element "table", class: "table-striped", ->
      tbody ->
        for item in *@list
          tr id: "id#{item.id}", class: "#{item.done and "strike"}", ->
            td item.score
            if item.done
              td s item.content
              td a href: "javascript:check(#{item.id})", "✓"
            else
              td item.content
              td a href: "javascript:uncheck(#{item.id})", "✗"
      tfoot ->
        tr ->
          form {
            id: "new_item"
            action: "javascript:new_item()"
          }, ->
            td!
            td -> input type: "text", id: "new_content", placeholder: "new item"
            td -> input type: "submit", "✓"

    script src: "static/js/util.js"
