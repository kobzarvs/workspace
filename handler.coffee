#!/usr/local/bin/coffee

VK_ESCAPE = 27

fade = (obj, _time, cb ) ->
    obj.animate {opacity:0}, _time, -> cb()
    obj.animate {opacity:1}, _time
    obj.show 'highlight', _time


class Activity
    constructor: (@ws,@x,@y,@wx,@wy) ->



class WorkSpace extends Properties

    constructor: (_svg_div) ->
        @name = 'WorkSpace'

        @modes = { 'R': 'Activity', 'C': 'Connetion' }

        # привязаем SVG к тэгу DIV с ID: _svg_div
        $('#workspace').svg (svg_context) -> @svg = svg_context
        
        console.log "SVG initialized"

        @space = []
        console.log 'WorkSpace initialized'

        @cookies
            draw:
                flag: {}
                mode:
                    before_get: =>
                        console.log 'BEFORE GET'
                    before_set: (val) =>
                        @old_mode = @draw._prop.mode

                    after_set: (val) =>
                        if @old_mode == val
                            console.log 'mode is not changed'
                        else
                            console.log 'mode is changed'
                            @draw_mode_status()

        @draw_mode_status()
         
    draw_mode_status: ->
        console.log 'mode is changed...'
        fade $('#status'), 100, =>
            $('#status').html 'mode: ' + @modes[ @draw.mode ]

    clear: ->
        @space = []




#
#   Ждем окончания полной загрузки страницы
ws = null
$(document).ready ->
    ws = new WorkSpace '#workspace'

    #
    #   выбор режима

    $(window).keydown (e) ->
        key = String.fromCharCode(e.keyCode)
        console.log "Down: #{e.keyCode} = #{key}"
        switch key
            when 'R'
                ws.draw.mode = 'R'
            when 'C'
                ws.draw.mode = 'C'

        console.log "Mode: #{ws.draw.mode}"
#        set_mode ws.draw.modes[ ws.draw.mode ]
#        ws.change_draw_mode()


    $('#workspace').mousedown (e) ->
#       console.log "MouseDown: #{e.clientX}:#{e.clientY}"
        switch ws.draw.mode
            when 'R'
                ;
#                console.log "MouseDown: #{e.clientX}:#{e.clientY}"

    $('#workspace').mouseup (e) ->
#        console.log "MouseUp: #{e.pageX}:#{e.pageY} Object: #{e.target.id}"
        switch ws.draw.mode
            when 'R'
                ;
#                console.log "MouseUp: #{e.pageX}:#{e.pageY} Object: #{e.target.id}"


    $('#workspace').mousemove (e) ->
#        return if last_object == e.target
#        return unless draw_flag
#        console.log "MouseMove: #{e.clientX}:#{e.clientY} Object: #{e.target.id}"

        switch ws.draw.mode
            when 'R'
                ;
#                console.log "MouseMove: #{e.clientX}:#{e.clientY} Object: #{e.target.id}"


