--- Installs the given list of packages using mason.nvim.
--- @param packages string[] List of package names to install.
return function(packages)
	local mason_registry = require("mason-registry")
	for _, pkg in ipairs(packages) do
		local p = mason_registry.get_package(pkg)
		if not p:is_installed() then
			p:install()
		end
	end
end
