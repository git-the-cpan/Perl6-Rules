
use ExtUtils::MakeMaker;
WriteMakefile(
		NAME	=> q[Perl6::Rules],
		VERSION => q[0.02],
        AUTHOR     => 'Damian Conway',
   		PREREQ_PM  => { Filter::Simple=>0.78, Attribute::Handlers=>0.78 },

	     );
