module BlastCommander
  class Hit

    def initialize(attrs)
      attrs.each do |k,v|
        instance_variable_set("@#{ k }".to_sym, v)
      end
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
      ReferenceSearch.new(saccver).references
    end

  end
end
