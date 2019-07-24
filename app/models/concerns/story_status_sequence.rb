module StoryStatusSequence
  extend ActiveSupport::Concern

  def sequence
    sequence = {}
    Story.status.values.each_with_index { |value, key| sequence[value] = key }
    sequence
  end

  def version_status
    paper_trail.previous_version.try(:status)
  end

  def saved_status
    Story.find_by(id: id).try(:status)
  end

  def current_status
    status
  end

  def previous_status
    version_status || saved_status
  end

  def next_status
    value = sequence[current_status] + 1
    sequence.key(value)
  end

  def step_back?(step = nil)
    if previous_status.nil?
      false
    elsif step.nil?
      sequence[current_status] < sequence[previous_status]
    else
      sequence[current_status] == (sequence[previous_status] - step)
    end
  end

  def step_forward?(step = nil)
    if previous_status.nil?
      false
    elsif step.nil?
      sequence[current_status] > sequence[previous_status]
    else
      sequence[current_status] == (sequence[previous_status] + step)
    end
  end

  def stopped?
    previous_status.nil? ? true : sequence[current_status] == sequence[previous_status]
  end
end
