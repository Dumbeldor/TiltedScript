premake.extensions.script = {}

function script_parent_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    local dir =  str:match("(.*/)"):sub(0,-2)
    local index = string.find(dir, "/[^/]*$")
    return dir:sub(0, index)
end

function script_generate()
    if premake.extensions.script.generated == true then
        return
    end

    project ("Script")
        kind ("StaticLib")
        language ("C++")

        includedirs
        {
            premake.extensions.script.path .. "/Code/script/include/",
            premake.extensions.core.path .. "/Code/core/include/",
        }

        files
        {
            premake.extensions.script.path .. "/Code/script/include/**.hpp",
            premake.extensions.script.path .. "/Code/script/src/**.cpp",
        }

    premake.extensions.script.generated = true
end

function script_lua_generate()
    if premake.extensions.script.lua_generated == true then
        return
    end

    project ("Lua")
        kind ("StaticLib")
        language ("C")

        includedirs
        {
            premake.extensions.script.path .. "/ThirdParty/lua/",
        }

        files
        {
            premake.extensions.script.path .. "/ThirdParty/lua/**.h",
            premake.extensions.script.path .. "/ThirdParty/lua/**.c",
        }

    premake.extensions.script.lua_generated = true
end

function script_generate_all()
    
    group ("Libraries")
        script_generate()

    group ("ThirdParty")
        script_lua_generate()

end

premake.extensions.script.path = script_parent_path()
premake.extensions.script.generate = script_generate_all