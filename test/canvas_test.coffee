{ assert, brains, Browser } = require("./helpers")

describe "Canvas", ->

  browser = null
  before (done) ->
    browser = Browser.create()
    brains.ready(done)

  describe "api", ->
    before ->
      brains.get "/canvas/validCanvas", (req, res) ->
        res.send """
          <html>
            <body>
              <canvas height='100' width='100'></canvas>
            </body>
          </html>
        """

    before (done) ->
      browser.visit("/canvas/validCanvas", done)

    it "should have one canvas element", ->
      canvases = browser.document.querySelectorAll("canvas")
      assert.equal canvases.length, 1
      @canvas = canvases[0]

    it "should expose a valid 2d context", ->
      @context = @canvas.getContext("2d")
      assert.equal typeof(@context), 'object'

    it "should provide the standard context attributes", ->
      assert.equal typeof(@context.canvas), 'object'
      assert.equal typeof(@context.fillStyle), 'string'
      assert.equal typeof(@context.font), 'string'
      assert.equal typeof(@context.globalAlpha), 'number'
      assert.equal typeof(@context.globalCompositeOperation), 'string'
      assert.equal typeof(@context.lineCap), 'string'
      assert.equal typeof(@context.lineJoin), 'string'
      assert.equal typeof(@context.lineWidth), 'number'
      assert.equal typeof(@context.miterLimit), 'number'
      assert.equal typeof(@context.shadowBlur), 'number'
      assert.equal typeof(@context.shadowColor), 'string'
      assert.equal typeof(@context.shadowOffsetX), 'number'
      assert.equal typeof(@context.shadowOffsetY), 'number'
      assert.equal typeof(@context.strokeStyle), 'string'
      assert.equal typeof(@context.textAlign), 'string'
      assert.equal typeof(@context.textBaseline), 'string'

    it "should provide the standard context methods", ->
      standard_methods = [
        'arc',
        'arcTo',
        'beginPath',
        'bezierCurveTo',
        'clearRect',
        'clip',
        'closePath',
        'createImageData',
        'createLinearGradient',
        'createPattern',
        'createRadialGradient',
        'drawImage',
        'fill',
        'fillRect',
        'fillText',
        'getImageData',
        'isPointInPath',
        'lineTo',
        'measureText',
        'moveTo',
        'putImageData',
        'quadraticCurveTo',
        'rect',
        'restore',
        'rotate',
        'save',
        'scale',
        'setTransform',
        'stroke',
        'strokeRect',
        'strokeText',
        'transform',
        'translate'
      ]
      assert.equal typeof(@context[method]), 'function' for method in standard_methods

  after ->
    browser.destroy()