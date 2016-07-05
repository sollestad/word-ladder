#!/usr/bin/perl -w

use strict;

my($start_word, $end_word) = @ARGV;

my $word_check = 1;

if(!(length($start_word) == length ($end_word))){ $word_check = 0; }

open(FILE,"wordlist.txt");


my %word_hash = ();

my $hash_count = 0;

for(<FILE>){
	my $line = $_;
	chomp $line;
	if(length($line) == length($start_word)) {

		$word_hash{$line} = $line;
		$hash_count++;
	}
}


$word_check = check_file($start_word);
$word_check = check_file($end_word);

if($word_check == 0 ){
	print "Invalid word\n";
	exit(0);
}

##########################################


my $gen_count = 0;
my @matches;
my @generations;
my %match_hash = ();

push(@generations, $gen_count);
push(@matches, $start_word);
$match_hash{$start_word} = $start_word;

$gen_count++;
main_loop($start_word, 0, $gen_count);
my $count = 1;


foreach $a (@matches){ 
	main_loop($a, $count, $gen_count);
	$gen_count++;
	$count++;
}

print "No chain found\n";


sub print_chain{
	my @chains;
	for(my $i=$_[0]; $i>-1; $i--){
		my $num = $i+1;

		push(@chains, $matches[$i]);

		$i = $generations[$i];
	}
	for(my $i=scalar(@chains)-1; $i > 0; $i--){
		print "$chains[$i] ";
		if($i != 1){print "---> ";}
	}

	print "\n"
}

sub check_file{
	if(exists($word_hash{$_[0]})){
       return 1;
    }else{
    	return 0;
    }
    close FILE;
}

sub main_loop{

	my $gen_count = $_[2];
	my $loop_check = 1;
	my $temp_word = $_[0];
	my $loop_count = 0;

	if($temp_word eq $end_word){
		push(@generations, $gen_count);
		push(@matches, $temp_word);
		found_match();
	}

	while($loop_check){
		for(my $i=0; $i < length($temp_word); $i++){
			for(my $j=0; $j < 26; $j++){
				$loop_count++;

				substr($temp_word,$i,1) = chr(97 + $j);
				if(exists($word_hash{$temp_word})){

					if(!(exists($match_hash{$temp_word}))){

						push(@generations, $gen_count);
						push(@matches, $temp_word);
						$match_hash{$temp_word} = $temp_word;
					}
				}

				$temp_word = $_[0];
			}
		}
			$loop_check = 0;
	}

}

sub found_match{
	print "Found chain\n";

	my $x = scalar @matches -1;
	print_chain($x);
	exit(0);
}


