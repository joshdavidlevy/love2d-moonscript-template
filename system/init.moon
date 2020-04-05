love = love

local system
system = {

  config: {
    projectName: "love2d-moonscript-template"
    width: 128
    height: 128
  }

  state: {
    current: {}
    load: (state) =>
      oldState = @current
      newState = require('states.' .. state)
      newState._count or= 0

      if oldState.onStop then oldState.onStop(oldState)
      if newState.onFirst and newState._count < 1 then newState.onFirst(newState)
      if newState.onStart then newState.onStart(newState)

      newState._count += 1
      @current = newState
  }

  pushCallback: (func, ...) =>
    if @[func] then @[func](@,...)
    if @state.current[func] then @state.current[func](@state.current,...)

  update: (dt) =>
    if @screenshotTimer and love.timer.getTime() > @screenshotTimer
      @screenshotTimer = nil
      love.graphics.captureScreenshot('screenshot.png')
    love.window.setTitle(@config.projectName .. " (FPS: " .. love.timer.getFPS() .. ") ")

  resize: () =>
    @scale = math.floor(math.min(love.graphics.getWidth() / @config.width,
     love.graphics.getHeight() / @config.height))
    @tx = math.floor((love.graphics.getWidth() - (@config.width * @scale)) / 2)
    @ty = math.floor((love.graphics.getHeight() - (@config.height * @scale)) / 2)

  draw: () =>
    love.graphics.translate(@tx, @ty)
    love.graphics.scale(@scale,@scale)


  load: () =>
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.keyboard.setKeyRepeat(true)

    require('system.debug')(system)
    @resize!

    @state\load("main")
}

love.load = () ->

  system\load!

  love.update = (...) -> system\pushCallback('update', ...)
  love.directorydropped = (...) -> system\pushCallback('directorydropped', ...)
  love.draw = (...) -> system\pushCallback('draw', ...)
  love.filedropped = (...) -> system\pushCallback('filedropped', ...)
  love.focus = (...) -> system\pushCallback('focus', ...)
  love.keypressed = (...) -> system\pushCallback('keypressed', ...)
  love.keyreleased = (...) -> system\pushCallback('keyreleased', ...)
  love.lowmemory = (...) -> system\pushCallback('lowmemory', ...)
  love.mousefocus = (...) -> system\pushCallback('mousefocus', ...)
  love.mousemoved = (...) -> system\pushCallback('mousemoved', ...)
  love.mousepressed = (...) -> system\pushCallback('mousepressed', ...)
  love.mousereleased = (...) -> system\pushCallback('mousereleased', ...)
  love.quit = (...) -> system\pushCallback('quit', ...)
  love.resize = (...) -> system\pushCallback('resize', ...)
  love.textedited = (...) -> system\pushCallback('textedited', ...)
  love.textinput = (...) -> system\pushCallback('textinput', ...)
  love.threaderror = (...) -> system\pushCallback('threaderror', ...)
  love.touchmoved = (...) -> system\pushCallback('touchmoved', ...)
  love.touchpressed = (...) -> system\pushCallback('touchpressed', ...)
  love.touchreleased = (...) -> system\pushCallback('touchreleased', ...)
  love.visible = (...) -> system\pushCallback('visible', ...)
  love.wheelmoved = (...) -> system\pushCallback('wheelmoved', ...)
  love.gamepadaxis = (...) -> system\pushCallback('gamepadaxis', ...)
  love.gamepadpressed = (...) -> system\pushCallback('gamepadpressed', ...)
  love.gamepadreleased = (...) -> system\pushCallback('gamepadreleased', ...)
  love.joystickadded = (...) -> system\pushCallback('joystickadded', ...)
  love.joystickaxis = (...) -> system\pushCallback('joystickaxis', ...)
  love.joystickhat = (...) -> system\pushCallback('joystickhat', ...)
  love.joystickpressed = (...) -> system\pushCallback('joystickpressed', ...)
  love.joystickreleased = (...) -> system\pushCallback('joystickreleased', ...)
  love.joystickremoved = (...) -> system\pushCallback('joystickremoved', ...)

return @
