local executable = "zathura"
local args = {
  "--synctex-forward", "%l:1:%f", "%p"
}

return {
	settings = {
		texlab = {
      build = {
        onSave = true
      },
			forwardSearch = {
				executable = executable,
				args = args,
			},
		},
	},
}
