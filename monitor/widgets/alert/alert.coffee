class Dashing.Alert extends Dashing.Widget

  ready: ->
    # This is fired when the widget is done being rendered

  onData: (data) ->
  	@accessor 'isTooHigh', ->
  		@get('value') > 2000

