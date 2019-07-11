class Array
  def where(options)
    matches = []

    each do |fixture|
      @fixture = fixture
      options_array = options.to_a
      meets_criteria = true

      options_array.each do |option|
        @option = option
        meets_criteria = meets_criterion? if meets_criteria
      end

      matches << fixture if meets_criteria
      meets_criteria = true
    end

    matches
  end

  def meets_criterion?
    if contains_regexp?
      contains_partial_match?
    else
      contains_exact_match?
    end
  end

  def contains_regexp?
    @option[1].class == Regexp
  end

  def contains_partial_match?
    (@fixture[@option[0]] =~ @option[1])
  end

  def contains_exact_match?
    ([@option] - @fixture.to_a).empty?
  end
end
