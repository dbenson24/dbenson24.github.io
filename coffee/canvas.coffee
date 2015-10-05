canvas = document.getElementById("test")

class CanvasObjects
    constructor: (@ctx, @canvas) ->
        @elements = []
        @changed = true
    
    draw: ()=>
        if @changed
            @clear()
            for element in @elements
                element.draw()
            
    clear: ()=>
        @ctx.clearRect -0.5, -0.5, @canvas.width, @canvas.height
        
    add: (element)=>
        @elements.push element
        @changed = true
    
class Note
    constructor: (@container, @x, @y, @radius) ->
        
    draw: () =>
        ctx = @container.ctx
        path = new Path2D()
        lineWidth = Math.floor(@radius*0.4)
        stemLength = @radius * 4
        path.arc(@x, @y, @radius,0,Math.PI*2,true)
        ctx.lineWidth = lineWidth
        ctx.fillStyle = "rgb(0, 0, 0)"
        ctx.fill path
        path = new Path2D()
        path.moveTo @x+@radius-lineWidth/2, @y
        path.lineTo @x+@radius-lineWidth/2, @y - stemLength
        ctx.stroke path

    moveTo: (@x, @y) =>
        @container.changed = true
    
    randomize: () =>
        maxX = @container.canvas.width
        maxY = @container.canvas.height
        minX = 10
        minY = 50
        x = Math.random()*(maxX-minX)+minX
        y = Math.random()*(maxY-minY)+minY
        @moveTo x,y 
        


if canvas.getContext
    ctx = canvas.getContext "2d"
    ctx.translate 0.5, 0.5
    
    Container = new CanvasObjects(ctx, canvas)
    
    note = new Note(Container,150, 150, 10)
    
    note2 = new Note(Container, 50, 50, 20)
    
    note3 = new Note(Container, 250, 250, 15)
    Container.add note
    Container.add note2
    Container.add note3
    
    setInterval(Container.draw, 30)
    setInterval(note.randomize, 3000)
    setInterval(note2.randomize, 3000)
    setInterval(note3.randomize, 3000)
    
fab = new fabric.Canvas "fab"

scalingFactor = 0.05

loadSVG = (object, options) ->
    group = fabric.util.groupSVGElements(object, options)
    group.scale scalingFactor
    fab.add(group).renderAll()
    
fabric.loadSVGFromURL "./images/notehead.svg", loadSVG
fabric.loadSVGFromURL "./images/Music-staff.svg", loadSVG
fabric.loadSVGFromURL "./images/Treble.svg", loadSVG
fabric.loadSVGFromURL "./images/Bass.svg", loadSVG
    
window.canvas = fab
