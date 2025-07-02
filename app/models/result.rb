class Result
  attr_reader :model, :success, :errors

  def initialize(model: nil, success: false, errors: [])
    @model = model
    @success = success
    @errors = errors
  end

  def success?
    @success
  end

  def failure?
    !@success
  end

  def self.success(model)
    new(model: model, success: true)
  end

  def self.failure(model, errors = [])
    new(model: model, success: false, errors: errors)
  end
end
