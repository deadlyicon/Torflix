ReactatronApp = require('reactatron/App')

App = new ReactatronApp

App.router.map ->
  @match '/',               @redirectTo('/transfers')
  # @match '/',               redirectTo: '/transfers'
  # @match '/shows',          component: 'ShowsPage'
  # @match '/shows/search',   component: 'ShowsSearchPage'
  # @match '/shows/:show_id', component: 'ShowPage'
  @match '/transfers',      -> require('./components/TransfersPage')
  # @match '/files',          component: 'FilesPage'
  # @match '/files/search',   component: 'FilesSearchPage'
  # @match '/search',         component: 'TorrentsSearchPage'
  # @match '/autoplay',       component: 'AutoplayPage'
  # @match '/video/:file_id', component: 'VideoPage'
  @match '/*path',          -> require('./components/PageNotFound')





module.exports = App