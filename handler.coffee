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
        $("#workspace").svg (svg_context) => @svg = svg_context
        @svg.rect 0,0,'100%','100%', {style:'fill:gray'}
        
        @cookies
            session_id: {}

        @localStorage 'db',
            points:
                before_get: =>
                after_set: (val,old) =>
                    console.log val
                    switch @draw.mode
                        when 'R'
                            if @points.length >= 2
                                push @, 'space', {rect: [@points[0].x, @points[0].y, @points[1].x, @points[1].y] }
                                $('#tmp').remove()
                                @tmp_space = null
                                @points = []
                            else if @points.length == 1
                                @tmp_space = [@points[0].x, @points[0].y, @points[0].x, @points[0].y]

            tmp_space:
                after_set: (r,old) =>
#                    if val[val.length-1]?.rect?
                    if r?
                        $('#tmp').remove()
                        @svg.rect r[0], r[1], r[2]-r[0], r[3]-r[1],
                            {id: 'tmp', style:'fill:none; stroke-width:1; stroke:red'}

            space:
                after_set: (val,old) =>
                    if val[val.length-1]?.rect?
                        r = val[val.length-1].rect
                        @svg.rect r[0], r[1], r[2]-r[0], r[3]-r[1]

            draw:
                flag: {}
                mode:
                    before_set: (val) =>
                        @old_mode = @draw._prop.mode
                        true

                    after_set: (val) =>
                        if @old_mode == val
                            console.log 'mode is not changed'
                        else
                            console.log 'mode is changed'
                            @draw_mode_status()
                            @points = []

        if @draw.mode? then @draw_mode_status() else @draw.mode = 'C'

        @points = []
        @tmp_space=null

        @space = [] #unless @space?
#        for i in [1..10000]
#            @space.push {rect: [i,i]}
         
    draw_mode_status: ->
        fade $('#status'), 100, =>
            $('#status').html 'mode: ' + @modes[ @draw.mode ]

    clear: ->
        @draw.space = []




#
#   Ждем окончания полной загрузки страницы
ws = null
$(document).ready ->
    ws = new WorkSpace '#workspace'

    #ws.svg.rect 0,0,100,100
    #   выбор режима
    #
    $(window).keydown (e) ->
        key = String.fromCharCode(e.keyCode)
        switch key
            when 'R', 'C'
                ws.draw.mode = key


    $('#workspace').mousedown (e) ->
        console.log "MouseDown: #{e.clientX}:#{e.clientY}"
        switch ws.draw.mode
            when 'R'
                push ws, 'points', {x: (e.clientX - workspace.offsetLeft), y: (e.clientY - workspace.offsetTop) }

    $('#workspace').mouseup (e) ->
#        console.log "MouseUp: #{e.pageX}:#{e.pageY} Object: #{e.target.id}"
        switch ws.draw.mode
            when 'R'
                ;


    $('#workspace').mousemove (e) ->
        switch ws.draw.mode
            when 'R'
                tmp = ws.tmp_space
                if tmp
                    ws.tmp_space = [tmp[0], tmp[1], e.pageX - workspace.offsetLeft, e.pageY - workspace.offsetTop]
#                    ws.tmp_space = [tmp[0], tmp[1], e.pageX, e.pageY]
                ;
#                console.log "MouseMove: #{e.clientX}:#{e.clientY} Object: #{e.target.id}"


