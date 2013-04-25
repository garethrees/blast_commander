module BlastCommander
  class Reference

    attr_reader :ref

    def initialize(reference)
      @ref = reference
    end

    def description
      ref['GBReference_title']
    end

    def authors
      if ref['GBReference_authors']['GBAuthor'].respond_to?(:join)
        ref['GBReference_authors']['GBAuthor'].join(', ')
      else
        ref['GBReference_authors']['GBAuthor'].to_s
      end
    end

    def to_s
      "#{ authors }: #{ description }"
    end

  end
end