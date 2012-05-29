require File.expand_path('../exceptions', __FILE__)

# Supports the following matchers:
#
#  describe '/api/account.json' do
#    subject { json_response }
#    before { get '/api/account.json' }
#    it { should have_json(:email).of_type(String) }
#    it { should have_json(:posts).of_type(Array).inside_of('account') }
#    it { should have_json(:review).of_type(Hash).inside_of('account/profile') }
#  end
#
RSpec::Matchers.define :have_json do |name|
  diffable

  match_for_should do |json|
    begin
      @obj = value_at_json_path(json, @path)["#{name}"]
      check_nil = !!@allow_nil ? @obj.nil? : true
      check_equals = !!@equals ? @obj == @equals : true
      check_matching = !!@matching ? !!(@obj =~ @matching) : true
      check_greater_than = !!@greater_than ? @obj > @greater_than : true
      check_type = !!@type_class ? @obj.kind_of?(@type_class) : true
      (@allow_nil and check_nil) || (check_type and check_equals and check_matching and check_greater_than)
    rescue Response::Matchers::MissingPathError
      false
    end
  end

  match_for_should_not do |json|
    begin
      @obj = value_at_json_path(json, @path)["#{name}"]
      check_nil = @obj.nil?
      check_equals = !!@equals ? @obj != @equals : true
      check_matching = !!@matching ? !(@obj =~ @matching) : true
      check_greater_than = !!@greater_than ? @obj <= @greater_than : true
      check_type = !!@type_class ? !@obj.kind_of?(@type_class) : true
      check_nil || (check_type or check_equals or check_mathing or check_greater_than)
    rescue Response::Matchers::MissingPathError
      true
    end
  end

  # TODO Boolean currently does not work. FalseClass
  chain :of_type do |type_class|
    @type_class = type_class
  end

  chain :inside_of do |path|
    @path = path
  end

  chain :allow_nil do |allow_nil|
    @allow_nil = allow_nil
  end

  chain :equal_to do |equals|
    @equals = equals
  end

  chain :greater_than do |greater_than|
    @greater_than = greater_than
  end

  chain :matching do |match|
    @matching = match
  end

  failure_message_for_should do |json|
    message = "expected JSON signature to include attribute '#{name}'"
    message << %( of type #{@type_class}) if @type_class
    message << %( equal to "#{@equals}") if @equals
    message << %( matching "#{@matching}") if @matching
    message << %( greater than "#{@greater_than}") if @greater_than
    message << %( or nil) if @allow_nil
    message << %( at path "#{@path}") if @path
    message << %(, but it was #{@obj.inspect})
    message
  end

  failure_message_for_should_not do |json|
    message = "expected JSON signature to exclude attribute '#{name}'"
    message << %( at path "#{@path}") if @path
    message << %( equal to "#{@equals}") if @equals
    message << %( matching "#{@matching}") if @matching
    message << %( greater than "#{@greater_than}") if @greater_than
    message << %(, but it was #{@obj.inspect})
    message
  end

  description do
    message = "contain the JSON signature for '#{name.to_s}'"
    message << %( of type #{@type_class}) if @type_class
    message << %( equal to "#{@equals}") if @equals
    message << %( matching "#{@matching}") if @matching
    message << %( greater than "#{@greater_than}") if @greater_than
    message << %( or nil) if @allow_nil
    message << %( at path "#{@path}") if @path
    message
  end

# Begin internal helpers

  def value_at_json_path(json, path)
    return json unless path

    json_path_to_keys(path).inject(json) do |value, key|
      case value
      when Hash, Array then value.fetch(key){ missing_json_path!(path) }
      else missing_json_path!(path)
      end
    end
  end

  def json_path_to_keys(path)
    path.split("/").map{|k| k =~ /^\d+$/ ? k.to_i : k }
  end

  def missing_json_path!(path)
    raise Response::Matchers::MissingPathError.new(path)
  end
end
