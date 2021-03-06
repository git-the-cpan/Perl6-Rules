use Test::Simple 'no_plan';
my $results;

BEGIN {
	close STDERR;
	open STDERR, '>', \$results or die "Can't redirect STDERR: $!";
}

END{

	@expected = (
		q{The :u0 modifier is not currently implemented},
		q{The :u1 modifier is not currently implemented},
		q{The :u2 modifier is not currently implemented},
		q{The :u3 modifier is not currently implemented},
		q{The :p5 modifier is not currently implemented},
		q{The :perl5 modifier is not currently implemented},
		q{The :once modifier is not currently implemented},
		q{The :nth modifier can only be used with m/.../ or s/.../.../},
		q{The :x modifier can only be used with m/.../ or s/.../.../},
		q{Fatal errors in one or more Perl 6 rules},
	);

	@results  = split "\n", $results;

	while (1) {
		($expected, $result) = (shift @expected, shift @results);
		last unless defined($expected) || defined($result);
		ok($expected eq $result, $expected);
	}

}

use Perl6::Rules;

rule bad:u0:u1:u2:u3:p5:perl5:once:nth(4):x(5) {};
