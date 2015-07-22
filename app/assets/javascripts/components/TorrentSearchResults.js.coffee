component 'TorrentSearchResults',

  propTypes:
    query: React.PropTypes.string.isRequired

  render: ->
    DOM.div
      className: 'TorrentSearchResults'
      PromiseStateMachine
        key: "query-#{@props.query}"
        promise: Torrent.search(@props.query)
        loading: ->
          DOM.div(null, 'loading...')
        loaded: @renderResults

  renderResults: (results) ->
    {div, table, thead, tr, th, tbody, td} = DOM

    results = results.map (result, index) =>
      SearchResult key: index, result: result

    div
      className: 'table-responsive'
      table
        className: 'table-striped table-bordered table-condensed'
        thead null,
          tr null,
            th null, 'Title'
            th null, 'Rating'
            th null, 'Age'
            th null, 'Size'
            th null, 'Seeders'
            th null, 'Leachers'
        tbody null,
        if results.length == 0
          tr(null, td(colSpan: 6, 'No results found :/'))
        else
          results


SearchResult = component

  displayName: 'AddTorrentForm-SearchResult'

  propTypes:
    result: React.PropTypes.object.isRequired

  render: ->
    result = @props.result
    {tr, td, ActionLink} = DOM
    tr null,
      td null, ActionLink className: 'link', onClick: @addTorrent, result.title
      td null, result.rating
      td null, result.date
      td null, result.size
      td null, result.seeders
      td null, result.leachers

  addTorrent: ->
    Torrent.get(@props.result.id).then (torrent) ->
      App.putio.transfers.add torrent.magnet_link
      Location.set Location.for('/waiting-for', link: torrent.magnet_link)

