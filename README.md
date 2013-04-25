BlastCommander
==============

Simple wrapper to get NCBI Blast results.

Requirements
------------

- [NCBI Blast Command Line Tools](http://www.ncbi.nlm.nih.gov/books/NBK1763/)
- Ruby 1.9.3

Usage
-----

```ruby
blast = BlastCommander::Blast.new('./path/to/sequences.fsa')
hits  = blast.hits
```
