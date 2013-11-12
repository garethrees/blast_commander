module BlastCommander
  class Hit

    def initialize(attrs)
      attrs.each do |k,v|
        instance_variable_set("@#{ k }".to_sym, v)
      end
      references
      self
    end

    def method_missing(meth, *args, &block)
      if instance_variable_defined?("@#{ meth }".to_sym) 
        instance_variable_get("@#{ meth }".to_sym)
      else
        super
      end
    end

    # TODO: Define `respond_to?`

    def references
      @references ||= HTTParty.get(reference_url, timeout: 600 ).collect do |reference|
        Reference.parse(reference)
      end
    end

    private

    def reference_url
      "http://stark-plains-5163.herokuapp.com/search/#{ saccver }"
    end

  end
end
