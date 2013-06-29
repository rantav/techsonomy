Template.technology.technology = ->
  # Save the selected technology in the window object for the events to work...
  # Kind of lame, but...
  window.technology = Technologies.findOne Session.get("technologyId")

Template.technology.contributors = ->
  technology = Technologies.findOne Session.get("technologyId")
  contributors = [].concat (contribution.contributorId for contribution in aspect.contributions for aspect in technology.aspects)...
  output = {}
  output[contributors[key]] = contributors[key] for key in [0...contributors.length]
  contributors = (value for key, value of output)

Template.technology.events
  'click .icon-plus': ->
    @['contributing-' + Meteor.userId()] = !@['contributing-' + Meteor.userId()]
    Technologies.update(technology._id, technology)

  'click .cancel-contribution': ->
    @['contributing-' + Meteor.userId()] = false
    Technologies.update(technology._id, technology)

  'submit form.contribute-form': (event) ->
    @['contributing-' + Meteor.userId()] = false
    if not @contributions
      @contributions = []
    text = $('textarea.contribute-text', event.target).val()
    @contributions.push
      contributorId: Meteor.userId()
      html: text
    Technologies.update(technology._id, technology)
    false

$ ->
  Template.technology.rendered = () ->
    $('.contribution[rel=tooltip]').tooltip() # initialize all tooltips in this template
