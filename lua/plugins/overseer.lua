---@type LazySpec
return {
  {
    'stevearc/overseer.nvim',
    opts = {},
    keys = {
      {
        '<leader>or',
        function()
          local overseer = require 'overseer'
          local tasks = overseer.list_tasks { recent_first = true }
          if vim.tbl_isempty(tasks) then
            vim.notify('No tasks found', vim.log.levels.WARN)
          else
            overseer.run_action(tasks[1], 'restart')
          end
        end,
        desc = 'Overseer: Run last task',
      },
      {
        '<leader>ok',
        function()
          local overseer = require 'overseer'
          local tasks = overseer.list_tasks()

          for _, task in pairs(tasks) do
            if task.status == 'RUNNING' then
              overseer.run_action(task, 'stop')
            end
          end
        end,
        desc = 'Overseer: Stop all tasks',
      },
    },
    {
      '<leader>on',
      '<cmd>OverseerRunCmd<cr>',
      desc = 'Overseer: Run new task',
    },
    {
      '<leader>ow',
      '<cmd>OverseerToggle! bottom <cr>',
      desc = 'Overseer: Toggle window',
    },
    {
      '<leader>oa',
      '<cmd>OverseerTaskAction<cr>',
      desc = 'Overseer Run task action',
    },
    {
      '<leader>ot',
      '<cmd>OverseerRun<cr>',
      desc = 'Overseer: Run task template',
    },
    {
      '<leader>obs',
      '<cmd>OverseerSaveBundle<cr>',
      desc = 'Overseer: Save current tasks',
    },
    {
      '<leader>obl',
      '<cmd>OverseerLoadBundle<cr>',
      desc = 'Overseer: Load saved tasks',
    },
    {
      '<leader>obd',
      '<cmd>OverseerDeleteBundle<cr>',
      desc = 'Overseer: Delete saved tasks',
    },
  },
}
