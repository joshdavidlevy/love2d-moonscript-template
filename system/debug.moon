love = love
DEBUG = true

return (system) ->

  if DEBUG

    screenshotTimer = love.timer.getTime() + 3

    inspect = require("inspect")

    oldPrint = print
    export print = (...) ->
      args = {...}
      output = ""
      for i, v in ipairs args
        if type(v) == "table" then args[i] = inspect(v)
        else args[i] = tostring(v)
        output = output .. args[i] .. " , "

      log = ""
      if love.filesystem.getInfo('log.txt')
        log = love.filesystem.read('log.txt',64000)
      love.filesystem.write('log.txt', (os.date() .. ' - ' .. output\sub(1,-3) .. '\n\n' .. log ))
      oldPrint(output)

    oldUpdate = system.update
    system.update = (...) ->

      if screenshotTimer and love.timer.getTime() > screenshotTimer
        screenshotTimer = nil
        love.graphics.captureScreenshot('screenshot.png')

      oldUpdate(...)
