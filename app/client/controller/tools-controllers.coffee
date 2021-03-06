toolsSort = sort: usageCount: -1
class @ToolsController extends RouteController
  data: ->
    page: 'tools'
    tools: Tool.find({}, toolsSort)
    limit: parseInt(@params.limit || 10)

  waitOn: ->
    limit = @params.limit || 10
    Meteor.subscribe('tools', _.extend({limit: limit}, toolsSort))

  after: -> document.title = "#{@data().tools.count()} tools | devdev.io"

class @ToolController extends RouteController

  notFoundTemplate: 'toolNotFound'

  data: ->
    Session.set('toolId', undefined)
    @tool = Tool.findOne(@params.id)
    if not @tool
      Session.set('toolId', @params.id)
      return null

    toolNamesSub = Meteor.subscribe('toolNames')

    tool: @tool
    toolId: @params.id
    page: 'tools'
    toolNamesSub: toolNamesSub

  waitOn: -> Meteor.subscribe('tool', @params.id)

  after: -> document.title = "#{@tool.name()} | devdev.io"

