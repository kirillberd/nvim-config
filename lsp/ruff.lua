return {
	on_attach = function(client)
		-- hover is basedpyright's job
		client.server_capabilities.hoverProvider = false
	end,
}
