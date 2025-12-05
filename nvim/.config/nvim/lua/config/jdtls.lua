local M = {}

local function get_workspace()
    vim.notify('Get Workspace', 'info')
    -- Get the home directory of your operating system
    local home = os.getenv('HOME')
    -- Declare a directory where you would like to store project information
    local workspace_path = home .. '/Development/Java/'
    -- Determine the project name
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    -- Create the workspace directory by concatenating the designated workspace path and the project name
    local workspace_dir = workspace_path .. project_name
    return workspace_dir
end

function M:setup()
    vim.notify('Starting JDTLS Setup', 'info')
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local workspace_dir = get_workspace()

    local jdtls_path = vim.fn.exepath('jdtls')
    local lombok_path = jdtls_path .. '/lombok.jar'
    local launcher_path = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
    local os_config = jdtls_path .. '/config_linux'

    vim.notify('Preparing JDTLS Config', 'info')
    local config = {
        -- The command that starts the language server
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        cmd = {
            'java', -- or '/path/to/java17_or_newer/bin/java'
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xmx1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens',
            'java.base/java.util=ALL-UNNAMED',
            '--add-opens',
            'java.base/java.lang=ALL-UNNAMED',
            '-javaagent:' .. lombok_path
            '-jar',
            launcher_path,
            '-configuration',
            os_config,
            -- eclipse.jdt.ls installation            Depending on your system.

            -- See `data directory configuration` section in the README
            '-data',
            workspace_dir,
        },

        -- This is the default if not provided, you can remove it. Or adjust as needed.
        -- One dedicated LSP server & client will be started per unique root_dir
        root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml' }),

        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = {
            java = {},
        },

        -- Language server `initializationOptions`
        -- You need to extend the `bundles` with paths to jar files
        -- if you want to use additional eclipse.jdt.ls plugins.
        --
        -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
        --
        -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
        init_options = {
            bundles = {},
        },
    }
    -- This starts a new client & server,
    -- or attaches to an existing client & server depending on the `root_dir`.
    vim.notify('Starting JDTLS', 'info')
    require('jdtls').start_or_attach(config)
end

return M
