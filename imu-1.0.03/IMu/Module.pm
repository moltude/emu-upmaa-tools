# KE Software Open Source Licence
# 
# Notice: Copyright (c) 2011  KE SOFTWARE PTY LTD (ACN 006 213 298)
# (the "Owner"). All rights reserved.
# 
# Licence: Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal with the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions.
# 
# Conditions: The Software is licensed on condition that:
# 
# (1) Redistributions of source code must retain the above Notice,
#     these Conditions and the following Limitations.
# 
# (2) Redistributions in binary form must reproduce the above Notice,
#     these Conditions and the following Limitations in the
#     documentation and/or other materials provided with the distribution.
# 
# (3) Neither the names of the Owner, nor the names of its contributors
#     may be used to endorse or promote products derived from this
#     Software without specific prior written permission.
# 
# Limitations: Any person exercising any of the permissions in the
# relevant licence will be taken to have accepted the following as
# legally binding terms severally with the Owner and any other
# copyright owners (collectively "Participants"):
# 
# TO THE EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS",
# WITHOUT ANY REPRESENTATION, WARRANTY OR CONDITION OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING (WITHOUT LIMITATION) AS TO MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. TO THE EXTENT
# PERMITTED BY LAW, IN NO EVENT SHALL ANY PARTICIPANT BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
# 
# WHERE BY LAW A LIABILITY (ON ANY BASIS) OF ANY PARTICIPANT IN RELATION
# TO THE SOFTWARE CANNOT BE EXCLUDED, THEN TO THE EXTENT PERMITTED BY
# LAW THAT LIABILITY IS LIMITED AT THE OPTION OF THE PARTICIPANT TO THE
# REPLACEMENT, REPAIR OR RESUPPLY OF THE RELEVANT GOODS OR SERVICES
# (INCLUDING BUT NOT LIMITED TO SOFTWARE) OR THE PAYMENT OF THE COST OF SAME.
#
use strict;
use warnings;

package IMu::Module;

use base 'IMu::Handler';
use IMu::Exception;
use IMu::Trace;

# Constructor
#
sub new
{
	my $package = shift;
	my $table = shift;

	my $this = $package->SUPER::new(@_);

	$this->{name} = 'Module';
	$this->{create} = $table;

	$this->{table} = $table;

	return $this;
}

# Properties
#
sub getTable
{
	my $this = shift;

	return $this->{table};
}

# Methods
#
sub addFetchSet
{
	my $this = shift;
	my $name = shift;
	my $columns = shift;

	my $args = {};
	$args->{name} = $name;
	$args->{columns} = $columns;
	return $this->call('addFetchSet', $args) + 0;
}

sub addFetchSets
{
	my $this = shift;
	my $sets = shift;

	return $this->call('addFetchSets', $sets) + 0;
}

sub addSearchAlias
{
	my $this = shift;
	my $name = shift;
	my $columns = shift;

	my $args = {};
	$args->{name} = $name;
	$args->{columns} = $columns;
	return $this->call('addSearchAlias', $args) + 0;
}

sub addSearchAliases
{
	my $this = shift;
	my $aliases = shift;

	return $this->call('addSearchAliases', $aliases) + 0;
}

sub addSortSet
{
	my $this = shift;
	my $name = shift;
	my $columns = shift;

	my $args = {};
	$args->{name} = $name;
	$args->{columns} = $columns;
	return $this->call('addSortSet', $args) + 0;
}

sub addSortSets
{
	my $this = shift;
	my $sets = shift;

	return $this->call('addSortSets', $sets) + 0;
}

sub fetch
{
	my $this = shift;
	my $flag = shift;
	my $offset = shift;
	my $count = shift;
	my $columns = shift;

	my $args = {};
	$args->{flag} = $flag;
	$args->{offset} = $offset;
	$args->{count} = $count;
	if (defined($columns))
	{
		$args->{columns} = $columns;
	}
	return $this->call('fetch', $args);
}

sub findKey
{
	my $this = shift;
	my $key = shift;

	return $this->call('findKey', $key) + 0;
}

sub findKeys
{
	my $this = shift;
	my $keys = shift;

	return $this->call('findKeys', $keys) + 0;
}

sub findTerms
{
	my $this = shift;
	my $terms = shift;

	return $this->call('findTerms', $terms) + 0;
}

sub findWhere
{
	my $this = shift;
	my $where = shift;

	return $this->call('findWhere', $where) + 0;
}

sub insert
{
	my $this = shift;
	my $values = shift;
	my $columns = shift;

	my $args = {};
	$args->{values} = $values;
	if (defined($columns))
	{
		$args->{columns} = $columns;
	}
	return $this->call('insert', $args);
}

sub remove
{
	my $this = shift;
	my $flag = shift;
	my $offset = shift;
	my $count = shift;

	my $args = {};
	$args->{flag} = $flag;
	$args->{offset} = $offset;
	if (defined($count))
	{
		$args->{count} = $count;
	}
	return $this->call('remove', $args);
}

sub restoreFromFile
{
	my $this = shift;
	my $file = shift;

	my $args = {};
	$args->{file} = $file;
	return $this->call('restoreFromFile', $args) + 0;
}

sub restoreFromTemp
{
	my $this = shift;
	my $file = shift;

	my $args = {};
	$args->{file} = $file;
	return $this->call('restoreFromTemp', $args) + 0;
}

sub sort
{
	my $this = shift;
	my $columns = shift;
	my $flags = shift;

	my $args = {};
	$args->{columns} = $columns;
	if (defined($flags))
	{
		$args->{flags} = $flags;
	}
	return $this->call('sort', $args);
}

sub update
{
	my $this = shift;
	my $flag = shift;
	my $offset = shift;
	my $count = shift;
	my $values = shift;
	my $columns = shift;

	my $args = {};
	$args->{flag} = $flag;
	$args->{offset} = $offset;
	$args->{count} = $count;
	$args->{values} = $values;
	if (defined($columns))
	{
		$args->{columns} = $columns;
	}
	return $this->call('update', $args);
}

1;
