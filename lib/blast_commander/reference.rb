module BlastCommander
  class Reference

    def self.parse(hash)
      parsed = { description: hash.fetch('description', 'No Description'),
                 journal: hash.fetch('journal', 'Unpublished'),
                 authors: hash['authors'] }
      
      new(parsed)
    end

    attr_reader :description, :journal

    def initialize(hash)
      @description = hash[:description]
      @journal     = hash[:journal]
      @authors     = hash[:authors]
    end

    def authors
      begin
        if @authors.kind_of?(Array)
          @authors.join(', ')
        else
          @authors.to_s
        end
      rescue
        'Could not find valid authors for this reference'
      end
    end

  end
end