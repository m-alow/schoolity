class Notifier::Notify
  attr_reader :scope, :publishers

  def initialize scope, publishers
    @scope = scope
    @publishers = publishers.to_ary
  end

  def call notifiable
    publishers.each do |p|
      p.call scope, notifiable
    end
  end
end
