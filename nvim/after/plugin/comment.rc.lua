local status, comment = pcall(require, "nvim_comment")
if (not status) then return end

comment.setup({
  operator_mapping = "<leader>c",
  comment_empty = false
})
