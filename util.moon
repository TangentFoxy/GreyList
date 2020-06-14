sign = (n) ->
  if n < 0
    return -1
  if n == 0
    return 0
  return 1

unix_time = -> os.time os.date "!*t"

order = (time=unix_time! - 1.5e9 / 1e5, score) ->
  return time + sign(score) * math.log(math.max 0.999, score^2)

split = (str) ->
  list = {}
  for word in str\gmatch "%S+"
    list[#list+1] = word
  return list

tag_patterns = {
  "^@(%w+)",        -- @tag
  "^%+(%w+)",       -- +tag
  "^#(%w+)",        -- #tag
  "^([^:%W]+):.+" -- tag:
}

match_tags = (str) ->
  tags_hash = {}
  for word in *split str
    for pattern in *tag_patterns
      value = word\match pattern
      if value and value\len! > 0
        tags_hash[value\lower!] = true
        break
  return tags_hash

return {}
