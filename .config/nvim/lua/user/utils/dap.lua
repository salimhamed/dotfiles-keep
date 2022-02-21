M = {}

function M.dap_ui_toggle()
  require("dapui").toggle({})
end

function M.dap_ui_eval()
  require("dapui").eval()
end

function M.dap_ui_open()
  require("dapui").open({})
end

function M.dap_ui_close()
  require("dapui").close({})
end

function M.set_breakpoint_condition()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end

function M.toggle_breakpoint()
  require("dap").toggle_breakpoint()
end

function M.continue()
  require("dap").continue()
end

function M.run_to_cursor()
  require("dap").run_to_cursor()
end

function M.go_to_line()
  require("dap").goto_()
end

function M.step_into()
  require("dap").step_into()
end

function M.go_down()
  require("dap").down()
end

function M.go_up()
  require("dap").up()
end

function M.run_last()
  require("dap").run_last()
end

function M.step_out()
  require("dap").step_out()
end

function M.step_over()
  require("dap").step_over()
end

function M.pause()
  require("dap").pause()
end

function M.toggle_repl()
  require("dap").repl.toggle()
end

function M.session()
  require("dap").session()
end

function M.stop_debug_session()
  require("dap").terminate()
end

function M.widgets()
  require("dap.ui.widgets").hover()
end

return M
