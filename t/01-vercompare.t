# Do some version comparisons

use Test;

BEGIN { plan tests => 23; }

use strict;
use warnings;

use Portroach::Const;
use Portroach::Util;
use Portroach::Config;

# vercompare returns: 1 when 'new > old', and 0 when 'new < old'

ok(vercompare('1.3.2', '1.3.2'), 0);                 # Equal, therefore not greater
ok(vercompare('1.8.2', '1.1.2'), 1);
ok(vercompare('1.1.2', '1.8.2'), 0);
ok(vercompare('20010301', '20010304'), 0);

ok(vercompare('1.8.20', '1.8.2'), 1);
ok(vercompare('1.8.1000', '1.8.20'), 0);             # 1000 more likely to mean "1"

ok(vercompare('2009-May-03', '2009-Jan-07'), 1);     # Month names

ok(vercompare('4.3.2', '4.3.2beta4'), 1);            # Betas are older than releases
ok(vercompare('1.2-rc3', '1.2'), 0);                 #
ok(vercompare('1.0.3', '1.0-beta4'), 1);             # Beta no. shouldn't trump the release no.
ok(vercompare('1.0.1-beta8', '1.0-beta4'), 1);       #

ok(vercompare('2.0-alpha3', '2.0-beta'), 0);         # beta > alpha
ok(vercompare('3.0-pre8', '3.0pre8'), 0);            # Same version, different format
ok(vercompare('1.8rc2', '1.8b6'), 1);                # release candidate > beta

ok(vercompare('2.0-beta4', '2.0-beta3.1'), 1);       # Complex beta number
ok(vercompare('2.0-beta3.1.7', '2.0-beta3.1.4'), 1); #
ok(vercompare('8.9-beta2.3.3', '8.9b2.3.4'), 0);     #

ok(vercompare('9.20_src_all', '9.20.1_src_all'), 0); # Hyphens and underbars
ok(vercompare('1_1_0', '1_0_0'), 1);
ok(vercompare('1_0', '0_9_9'), 1);

ok(vercompare('5.21p', '5.21m'), 1);                 # Single alphabetic suffix
ok(vercompare('5.20p', '5.21p'), 0);

ok(vercompare('2.dog', '2.cat'), 1);                 # Strings should compare too
