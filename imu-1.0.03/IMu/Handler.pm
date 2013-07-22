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

package IMu::Handler;

use IMu::Exception;
use IMu::Session;
use IMu::Trace;

# Constructor
#
sub new
{
	my $package = shift;
	my $session = shift;

	my $this = bless({}, $package);

	if (! defined($session))
	{
		$this->{session} = IMu::Session->new();
	}
	else
	{
		$this->{session} = $session;
	}

	$this->{create} = undef;
	$this->{destroy} = undef;
	$this->{id} = undef;
	$this->{language} = undef;
	$this->{name} = undef;

	return $this;
}

# Properties
#
sub getCreate
{
	my $this = shift;

	return $this->{create};
}

sub setCreate
{
	my $this = shift;
	my $create = shift;

	$this->{create} = $create;
}

sub getDestroy
{
	my $this = shift;

	if (! defined($this->{destroy}))
	{
		return 0;
	}
	return $this->{destroy};
}

sub setDestroy
{
	my $this = shift;
	my $destroy = shift;

	$this->{destroy} = $destroy;
}

sub getID
{
	my $this = shift;

	return $this->{id};
}

sub setID
{
	my $this = shift;
	my $id = shift;

	$this->{id} = $id;
}

sub getLanguage
{
	my $this = shift;

	return $this->{language};
}

sub setLanguage
{
	my $this = shift;
	my $language = shift;

	$this->{language} = $language;
}

sub getName
{
	my $this = shift;

	return $this->{name};
}

sub setName
{
	my $this = shift;
	my $name = shift;

	$this->{name} = $name;
}

sub getSession
{
	my $this = shift;

	return $this->{session};
}

# Methods
#
sub call
{
	my $this = shift;
	my $method = shift;
	my $params = shift;

	my $request = {};
	$request->{method} = $method;
	if (defined($params))
	{
		$request->{params} = $params;
	}
	my $response = $this->request($request);
	return $response->{result};
}

sub request
{
	my $this = shift;
	my $request = shift;

	if (defined($this->{id}))
	{
		$request->{id} = $this->{id};
	}
	elsif (defined($this->{name}))
	{
		$request->{name} = $this->{name};
		if (defined($this->{create}))
		{
			$request->{create} = $this->{create};
		}
	}
	if (defined($this->{destroy}))
	{
		$request->{destroy} = $this->{destroy};
	}
	if (defined($this->{language}))
	{
		$request->{language} = $this->{language};
	}

	my $response = $this->{session}->request($request);

	if (exists($response->{id}))
	{
		$this->{id} = $response->{id};
	}

	return $response;
}

1;
