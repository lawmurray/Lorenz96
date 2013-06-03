#!/usr/bin/perl

my $line;
my $method;
my $config;
my $time;
my @pf_results;
my @pmmh_results;
my @smc2_results;
my $results;

# parse results
while ($line = <>) {
    chomp $line;
    if ($line =~ /^Particle filter$/) {
	push(@pf_results, []);
	$results = $pf_results[$#pf_results];
    } elsif ($line =~ /^Particle marginal Metropolis-Hastings/) {
	push(@pmmh_results, []);
	$results = $pmmh_results[$#pmmh_results];
    } elsif ($line =~ /^SMC\^2/) {
	push(@smc2_results, []);
	$results = $smc2_results[$#smc2_results];
    } elsif ($line =~ /^(\d+): (\d+)$/) {
	$config = $1;
	$time = $2/1e6;
	$results->[$config] = $time;
    }
}

# output results
open(PF, ">", "pf.csv") || die("could not open pf.csv\n");
for ($i = 0; $i < @pf_results; ++$i) {
    for ($j = 0; $j < @{$pf_results[$i]}; ++$j) {
	print PF "\t" . $pf_results[$i]->[$j];
    }
    print PF "\n";
}
close PF;

open(PMMH, ">", "pmmh.csv") || die("could not open pmmh.csv\n");
for ($i = 0; $i < @pmmh_results; ++$i) {
    for ($j = 0; $j < @{$pmmh_results[$i]}; ++$j) {
	print PMMH "\t" . $pmmh_results[$i]->[$j];
    }
    print PMMH "\n";
}
close PMMH;

open(SMC2, ">", "smc2.csv") || die("could not open smc2.csv\n");
for ($i = 0; $i < @smc2_results; ++$i) {
    for ($j = 0; $j < @{$smc2_results[$i]}; ++$j) {
	print SMC2 "\t" . $smc2_results[$i]->[$j];
    }
    print SMC2 "\n";
}
close SMC2;
