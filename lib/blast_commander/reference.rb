module BlastCommander
  class Reference

    attr_reader :ref

    def initialize(reference)
      @ref = reference
    end

    def description
      ref.fetch('GBReference_title', 'No Description')
    end

    def authors
      begin
        if ref['GBReference_authors']['GBAuthor'].kind_of?(Array)
          ref['GBReference_authors']['GBAuthor'].join(', ')
        else
          ref['GBReference_authors']['GBAuthor'].to_s
        end
      rescue
        'Could not locate a valid reference'
      end
    end

  end
end