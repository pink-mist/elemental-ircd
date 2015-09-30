#!/bin/sh
set -e

cd `dirname $0`
testdir=`pwd`
prefix=`sed -n -e 's/^#define IRCD_PREFIX "\(.*\)"/\1/p' "$testdir/../include/setup.h"`
[ -d $prefix ] || { echo Unable to find installation prefix; exit 1; }

echo "Using the pregenned cert"

cp ssl* $prefix/etc
cp dh.pem $prefix/etc

# Copy common config somewhere the ircd can find it
cp common.conf $prefix/

echo "Starting ircd's"

$prefix/bin/ircd -configfile $testdir/ircd.conf.1 -pidfile $testdir/ircd.pid.1 -logfile logs/ircd.log.1
sleep 1
$prefix/bin/ircd -configfile $testdir/ircd.conf.2 -pidfile $testdir/ircd.pid.2 -logfile logs/ircd.log.2
sleep 1
$prefix/bin/ircd -configfile $testdir/ircd.conf.3 -pidfile $testdir/ircd.pid.3 -logfile logs/ircd.log.3
sleep 5 # let things get all situated
