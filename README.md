# word-ladder
This is a word ladder game written in Perl .

This is the idea of the game: https://en.wikipedia.org/wiki/Word_ladder

To run, use the command: perl doublets.pl word word
where words are words to chain.

The file wordlist.txt needs to be in the same directory. It contains an extensive list of english words to check word chainings.

Example input and Output: 
  perl doublets.pl hello saves
  Found chain
  hello ---> cello ---> cells ---> bells ---> balls ---> bales ---> sales ---> saves
  

