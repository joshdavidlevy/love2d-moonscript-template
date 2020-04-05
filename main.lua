love.filesystem.setRequirePath("modules/lpeglj/src/?.lua")
package.loaded.lpeg = require "lpeglj"

love.filesystem.setRequirePath("modules/moonscript/?.lua")
moonscript = require "moonscript"
moon = require "moon.init"

love.filesystem.setRequirePath("?.lua;?/init.lua;/modules/?.lua;/modules/?/init.lua;/modules/?/?.lua")

require("system.init")
