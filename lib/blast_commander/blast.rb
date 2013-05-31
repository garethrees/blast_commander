require 'csv'

module BlastCommander
  class Blast

    attr_reader :uncultured

    def self.default_output_format_options
      @default_output_format_options ||= {
        'qseqid' => 'Query Seq-id',
        'qgi' => 'Query GI',
        'qacc' => 'Query accesion',
        'qaccver' => 'Query accesion.version',
        'qlen' => 'Query sequence length',
        'sseqid' => 'Subject Seq-id',
        'sallseqid' => 'All subject Seq-id(s), separated by a ;',
        'sgi' => 'Subject GI',
        'sallgi' =>' All subject GIs',
        'sacc' => 'Subject accession',
        'saccver' => 'Subject accession.version',
        'sallacc' => 'All subject accessions',
        'slen' => 'Subject sequence length',
        'qstart' => 'Start of alignment in query',
        'qend' => 'End of alignment in query',
        'sstart' => 'Start of alignment in subject',
        'send' => 'End of alignment in subject',
        'qseq' => 'Aligned part of query sequence',
        'sseq' => 'Aligned part of subject sequence',
        'evalue' => 'Expect value',
        'bitscore' => 'Bit score',
        'score' => 'Raw score',
        'length' => 'Alignment length',
        'pident' => 'Percentage of identical matches',
        'nident' => 'Number of identical matches',
        'mismatch' => 'Number of mismatches',
        'positive' => 'Number of positive-scoring matches',
        'gapopen' => 'Number of gap openings',
        'gaps' => 'Total number of gaps',
        'ppos' => 'Percentage of positive-scoring matches',
        'frames' => 'Query and subject frames separated by a /',
        'qframe' => 'Query frame',
        'sframe' => 'Subject frame',
        'btop' => 'Blast traceback operations (BTOP)',
        'staxids' => 'Subject Taxonomy ID(s), separated by a ;',
        'sscinames' => 'Subject Scientific Name(s), separated by a ;',
        'scomnames' => 'Subject Common Name(s), separated by a ;',
        'sblastnames' => 'Subject Blast Name(s), separated by a ; (in alphabetical order)',
        'sskingdoms' => 'Subject Super Kingdom(s), separated by a ; (in alphabetical order)',
        'stitle' => 'Subject Title',
        'salltitles' => 'All Subject Title(s), separated by a <>',
        'sstrand' => 'Subject Strand',
        'qcovs' => 'Query Coverage Per Subject',
        'qcovhsp' => 'Query Coverage Per HSP' }
    end

    def initialize(seq_file, opts = {})
      @file       = seq_file
      @uncultured = opts.fetch(:uncultured, true)
    end

    def hits
      @hits ||= get_hits!
    end

    def hits!
      @hits = get_hits!
    end

    def remove_uncultured?
      !uncultured
    end

    private

    def get_hits!
      CSV.parse(generate_csv, parse_options).collect do |row|
        BlastCommander::Hit.new(row.to_hash)
      end
    end

    def generate_csv
      puts "==> Running: blastn #{ generate_csv_options }"
      %x[blastn #{ generate_csv_options }]
    end

    def generate_csv_options
      "-db nt -query #{ @file } -outfmt '6 #{ self.class.default_output_format_options.keys.join(' ') }' -max_target_seqs 50 -remote #{ entrez_query if remove_uncultured? }"
    end

    def entrez_query
      "-entrez_query 'all[filter] NOT (environmental samples[organism] OR metagenomes[orgn])'"
    end

    def parse_options
      { headers: self.class.default_output_format_options.keys,
        col_sep: "\t",
        header_converters: :symbol }
    end

  end
end