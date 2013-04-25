module BlastCommander
  class ReferenceSearch

    DATABASE = 'nucleotide'

    attr_reader :accession_id

    def initialize(accession_id)
      @accession_id = accession_id
      @parser = Nori.new
    end

    def references
      paper['GBSet']['GBSeq']['GBSeq_references']['GBReference'].collect do |ref|
        Reference.new(ref)
      end
    end

    private

    def entrez_search_id
      response = Entrez.ESearch(DATABASE, { ACCN: accession_id }, retmode: :xml)
      response.parsed_response['eSearchResult']['IdList']['Id'].to_i
    end

    def paper
      paper_xml = Entrez.EFetch(DATABASE, id: entrez_search_id, retmode: :xml)
      @parser.parse(paper_xml.parsed_response)
    end

  end
end
