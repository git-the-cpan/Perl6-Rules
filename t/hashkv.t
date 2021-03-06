use Perl6::Rules;
use Test::Simple 'no_plan';

# HASHES WITH KEYMATCH

our %var is keymatch(rx/b|c|d/) = (a=>1, b=>2, c=>3);

ok( "b" =~ m/%::var/, "Simple hash interpolation (b)");
ok( "d" !~ m/%::var/, "Simple hash interpolation (d)");
ok( "a" !~ m/%::var/, "Simple hash interpolation (a)");
ok( "c" =~ m/%::var/, "Simple hash interpolation (c)");
ok( "====a=====" !~ m/%::var/, "Nested hash interpolation (a)");
ok( "====c=====" =~ m/%::var/, "Nested hash interpolation (c)");
ok( "====d=====" !~ m/%::var/, "Nested hash interpolation (d)");
ok( "abca" !~ m/^%::var$/, "Simple hash non-matching");

{
  no warnings 'regexp';

  ok( "a b c a" !~ m:w/^ [ %::var]+ $/, "Simple hash repeated nonmatching (a)");
  ok( "d b c d" !~ m:w/^ [ %::var]+ $/, "Simple hash repeated nonmatching (d)");
  ok( "c b c c" =~ m:w/^ [ %::var]+ $/, "Simple hash repeated matching");
}


# HASHES WITH KEYMATCH AND VALUEMATCH

our %var2 is keymatch(rule /b|c|d|e/) is valuematch(rx/3|4/)
	= (a=>1, b=>2, c=>3, e=>3);

ok( "d2" !~ m/%::var2/, "Simple hash interpolation (d2)");
ok( "d3" !~ m/%::var2/, "Simple hash interpolation (d3)");
ok( "a" !~ m/%::var2/, "Simple hash interpolation (a)");
ok( "b2" !~ m/%::var2/, "Simple hash interpolation (b2)");
ok( "c4" !~ m/%::var2/, "Simple hash interpolation (c4)");
ok( "c3" =~ m/%::var2/, "Simple hash interpolation (c3)");
ok( "e3" =~ m/%::var2/, "Simple hash interpolation (e3)");
ok( "====a1=====" !~ m/%::var2/, "Nested hash interpolation (a)");
ok( "====c3=====" =~ m/%::var2/, "Nested hash interpolation (c)");
ok( "====d3=====" !~ m/%::var2/, "Nested hash interpolation (d)");

{
  no warnings 'regexp';

  ok( "b2 b3 c3 e3" !~ m:w/^[ %::var2]+$/,
      "Simple hash repeated nonmatching (b2 b3 c3 e3)");

  ok( "c3 e3 e3 c3" =~ m:w/^[ %::var2]+$/,
      "Simple hash repeated matching (c3 e3 e3 c3)");
}

