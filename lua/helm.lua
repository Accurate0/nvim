-- Only treat files as helm when they belong to a chart, so unrelated
-- `templates/` or `values.yaml` files keep their normal filetype.
local function in_chart(filetype)
  return function(path)
    if vim.fs.root(path, 'Chart.yaml') then
      return filetype
    end
  end
end

vim.filetype.add {
  pattern = {
    ['.*/templates/.*%.ya?ml'] = in_chart 'helm',
    ['.*/templates/.*%.tpl'] = in_chart 'helm',
    ['.*/templates/NOTES%.txt'] = in_chart 'helm',
    ['.*/values.*%.ya?ml'] = function(path)
      if vim.uv.fs_stat(vim.fs.joinpath(vim.fs.dirname(path), 'Chart.yaml')) then
        return 'yaml.helm-values'
      end
    end,
  },
}
