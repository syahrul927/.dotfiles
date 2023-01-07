local api = vim.api
local function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
api.nvim_create_autocmd("BufNewFile", {
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
		if ft == "java" then 
			local dir = vim.fn.expand('%:p:h')
			local filename = string.gsub(vim.fn.expand('%:p:t'), ".java", "")
			local t = split(dir, "/src/main/java/")
			local src = t[2]
			local package = string.gsub(src, "/", ".")
			vim.fn.append(0, 'package ' .. package .. ";")
			vim.fn.append(1, '')
			vim.fn.append(2, 'public class ' .. filename .. " {")
			vim.fn.append(3, "")
			vim.fn.append(4, "}")
		end
	end
})
