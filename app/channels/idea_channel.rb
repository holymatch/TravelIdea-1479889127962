# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class IdeaChannel < ApplicationCable::Channel
  def subscribed
    idea = Idea.find(params[:idea_id])
    stream_for idea
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
