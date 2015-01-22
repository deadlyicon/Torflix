React     = require 'react'
component = require '../component'

{div, table, thead, tbody, tr, td, th} = React.DOM





module.exports = component 'TransfersList',

  contextTypes:
    putio: React.PropTypes.any.isRequired

  getInitialState: ->
    error: null
    transfers: @context.putio.transfers.toArray()

  transfersChanged: ->
    console.log('transfersChanged')
    @setState transfers: @context.putio.transfers.toArray()

  componentDidMount: ->
    @context.putio.transfers.on('change', @transfersChanged)
    @context.putio.transfers.load()

  componentWillUnmount: ->
    @context.putio.transfers.off('change', @transfersChanged)

  render: ->
    console.log('REDERING', @state)
    div
      className: 'TransfersList'
      @renderContent()

  renderContent: ->
    switch
      when @state.error
        div(null, "ERROR: #{@state.error}")
      when @state.transfers
        console.dir @state.transfers[0]
        Table(transfers: @state.transfers)
      else
        div(null, 'Loading…')


Table = component 'TransfersListTable',
  render: ->
    div className: 'transfers',
      div className: 'header',
        div className: 'status',     'Status'
        div className: 'name',       'Name'
        div className: 'created_at', 'Created At'
      @props.transfers.map (transfer) ->
        div key: transfer.id, className: 'transfer',
          div className: 'status',     transfer.status
          div className: 'name',       transfer.name
          div className: 'created_at', transfer.created_at


