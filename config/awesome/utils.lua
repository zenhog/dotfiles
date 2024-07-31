local utils = {}

utils.homedir = os.getenv('HOME')

utils.getscreen = function()
    return screen.focused()
end

utils.getclient = function(tag)
    if tag == 0 then
        return client.focused
    end
end

utils.getclients = function()
    return client.get()
end

utils.getlayout = function(s)
    return awful.layout.getname(awful.layout.get(s))
end

