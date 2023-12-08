vim.g.timeoutWaitMins = 45
vim.g.timeoutMinBreakMins = 5

local shouldRun = true
local minBreakOver = false

local endBreak = function(float)
    if not minBreakOver then
        return
    end
    vim.api.nvim_win_close(float, true)
    if shouldRun then StartTimeOut() end
end

local showNotification = function()
    local gheight = vim.api.nvim_win_get_height(0)
    local gwidth = vim.api.nvim_win_get_width(0)
    local width = math.floor(gwidth * 0.5)
    local height = math.floor(gheight * 0.5)

    -- minBreakOver = false

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 1, 5, false,
        { 'Time to take a break', 'This is not a drill!', 'Take a break for at least', vim.g.timeoutMinBreakMins .. ':00' })

    local float = vim.api.nvim_open_win(buf, true,
        {
            relative = 'editor',
            width = width,
            height = height,
            row = math.floor((gheight - height) * 0.5),
            col = math.floor((gwidth - width) * 0.5),
        })

    vim.api.nvim_buf_set_keymap(buf, 'n', ';', '<Nop>', { silent = true })
    vim.api.nvim_buf_set_keymap(buf, 'n', ':', '<Nop>', { silent = true })
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Escape>', '', {
        callback = function()
            endBreak(float)
        end,
        silent = true
    })

    local countdown = vim.loop.new_timer()

    local m = vim.g.timeoutMinBreakMins
    local s = 0

    countdown:start(1000, 1000, vim.schedule_wrap(function()
        if s == 0 then
            m = m - 1
            s = 59
        else
            s = s - 1
        end
        local secondsText = tostring(s)
        if s < 10 then secondsText = '0' .. s end
        vim.api.nvim_buf_set_lines(buf, 1, 5, false,
            { 'Time to take a break', 'This is not a drill!', 'Take a break for at least', m ..
            ':' .. secondsText })
    end))
    local timer = vim.loop.new_timer()
    timer:start(math.floor(vim.g.timeoutMinBreakMins * 60 * 1000), 0, vim.schedule_wrap(function()
        timer:close()
        countdown:stop()
        countdown:close()
        minBreakOver = true
        vim.api.nvim_buf_set_lines(buf, 1, 5, false,
            { 'Break time is over', 'Press Esc to get back to it', '', '' })
    end))
end


local loopTimer = vim.loop.new_timer()
StartTimeOut = function()
    shouldRun = true
    loopTimer:start(math.floor(vim.g.timeoutWaitMins * 60 * 1000), 0, vim.schedule_wrap(function()
        showNotification()
    end))
end

StopTimeOut = function()
    shouldRun = false
end
