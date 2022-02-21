M = {}

function M.contains(tbl, str)
  for _, v in ipairs(tbl) do
    if v == str then
      return true
    end
  end
  return false
end

function M.get_match(tbl, str)
  for _, v in ipairs(tbl) do
    if v:match(str) then
      return v
    end
  end
  return false
end

return M
