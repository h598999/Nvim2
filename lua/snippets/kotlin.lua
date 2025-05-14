local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local f = ls.function_node

local function get_kotlin_package()
  local filepath = vim.fn.expand("%:p")
  local project_root = nil
  local dirname = vim.fn.fnamemodify(filepath, ":p:h")

  -- Search upward to find 'src/main/kotlin' or 'src'
  while dirname ~= "/" do
    if vim.fn.isdirectory(dirname .. "/src/main/kotlin") == 1 then
      project_root = dirname .. "/src/main/kotlin"
      break
    elseif vim.fn.isdirectory(dirname .. "/src") == 1 then
      project_root = dirname .. "/src"
      break
    end
    dirname = vim.fn.fnamemodify(dirname, ":h")
  end

  if not project_root then
    return "com.example"
  end

  -- Compute relative path to infer package name
  local relative = filepath:sub(#project_root + 2):gsub("%.kt$", "")
  local folders = {}

  for part in relative:gmatch("[^/\\]+") do
    table.insert(folders, part)
  end

  table.remove(folders) -- remove the filename
  local sub = table.concat(folders, ".")

  if #sub > 0 then
    return sub
  else
    return "defaultpkg"
  end
end

local function get_classname()
    return vim.fn.expand("%:t:r")
end


return {
  -- println
  s("pln", fmt('println({})', { i(1, '"Hello, world!"') })),

  -- for loop
  s("for", fmt([[
    for ({} in 0 until {}) {{
        {}
    }}
  ]], {
    i(1, "i"),
    i(2, "n"),
    i(3, "// body")
  })),

  -- try-catch
  s("try", fmt([[
    try {{
        {}
    }} catch (e: Exception) {{
        println(e.message)
    }}
  ]], {
    i(1, "// risky code")
  })),

-- inside your snippet list:
s("class", fmt([[
  package {}

  class {} {{
      {}
  }}
]], {
  f(get_kotlin_package),
  f(get_classname),
  i(1, "// body")
})),

s("package", fmt("package {};", {
  f(get_kotlin_package),
})),

s("interface", fmt([[
  package {}

  interface {} {{
      {}
  }}
]], {
  f(get_kotlin_package),
  i(1, "MyInterface"),
  i(2, "// body")
})),

  -- main function
  s("main", fmt([[
    fun main() {{
        {}
    }}
  ]], {
    i(1, "// your code here")
  })),
}

