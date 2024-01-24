local config = {
    cmd = { '/home/gabriel-costa/.local/share/nvim/site/pack/packer/start/nvim-jdtls/lua' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)