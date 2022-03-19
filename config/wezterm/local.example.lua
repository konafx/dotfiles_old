local M = {}
local local_config = {
	ssh_domains = {
		{
            name = "my.server",
            remote_address= "192.168.0.1:22",
            username = "user",
            ssh_option = {
                identityfile = "$HOME\\ssh\\key",
            },
		},
	},
}
function M.setup()
	return local_config
end

return M
