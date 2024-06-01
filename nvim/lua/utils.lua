function P(v)
	print(vim.inspect(v))
	return v
end

function R(name)
	package.loaded["myluamodule"] = nil
	-- Read and execute again from disk
	return require(name)
end
