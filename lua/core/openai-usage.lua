-- Function to fetch OpenAI usage data using curl and display it in Neovim
local function fetch_openai_usage()
    -- Retrieve the OpenAI API key from the environment variable
    local api_key = os.getenv("OPENAI_API_KEY")

    -- Check if the API key exists
    if not api_key then
        vim.api.nvim_echo({ { "Error: OPENAI_API_KEY not set in environment variables.", "ErrorMsg" } }, false, {})
        return
    end

    -- Command to fetch usage data from OpenAI API
    local curl_command = string.format(
        "curl -s -H 'Authorization: Bearer %s' https://api.openai.com/v1/usage",
        api_key
    )

    -- Execute the curl command and capture the output
    local handle = io.popen(curl_command)
    local result = handle:read("*a")
    handle:close()

    -- Parse the JSON response
    local usage_data = vim.fn.json_decode(result)

    -- Check if the response contains the usage information
    if usage_data then
        -- Customize this message based on the actual fields in your response
        local message = string.format(
            "Total Usage: $%.2f",
            usage_data.total_usage or 0
        )

        -- Display the message in Neovim
        vim.api.nvim_echo({ { message, "Normal" } }, false, {})
    else
        -- Display error message if usage data is not found
        vim.api.nvim_echo({ { "Failed to retrieve OpenAI usage data.", "ErrorMsg" } }, false, {})
    end
end

-- Command to manually fetch and display OpenAI usage data
vim.api.nvim_create_user_command('CheckOpenAIUsage', fetch_openai_usage, {})

-- Optionally, you can call fetch_openai_usage automatically when Neovim starts
-- Uncomment the following line if desired
-- fetch_openai_usage()

