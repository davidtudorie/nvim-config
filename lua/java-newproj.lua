local M = {}

local function input(prompt, default)
  vim.fn.inputsave()
  local result = vim.fn.input(prompt, default or "")
  vim.fn.inputrestore()
  return result
end

M.create_project = function()
 local default_path = vim.fn.getcwd() .. "/facultate/designPatterns"
local path = vim.fn.input("Project directory: ", default_path)
 
  local src_path = path .. "/src"
  vim.fn.mkdir(src_path, "p")
  local file = io.open(src_path .. "/Main.java", "w")
  file:write([[
public class Main {
    public static void main(String[] args) {
        System.out.println("Salut din Java!");
    }
}
]])
  file:close()
  vim.cmd("e " .. src_path .. "/Main.java")
end

M.create_package = function()
  local package = input("Nume pachet (ex: designpatterns.singleton): ")
  local dir = "src/" .. package:gsub("%.", "/")
  vim.fn.mkdir(dir, "p")
  print("Pachet creat: " .. dir)
end

M.create_class = function()
  local package = input("Nume pachet: ")
  local class_name = input("Nume clasa: ")
  local dir = "src/" .. package:gsub("%.", "/")
  vim.fn.mkdir(dir, "p")
  local path = dir .. "/" .. class_name .. ".java"
  local file = io.open(path, "w")
  file:write(string.format([[
package %s;

public class %s {
    public %s() {
        // constructor
    }
}
]], package, class_name, class_name))
  file:close()
  vim.cmd("e " .. path)
end

return M

