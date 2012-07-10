package WWW::Curl::Easy;

use strict;
use warnings;
use Carp;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK $AUTOLOAD);

$VERSION = '4.11';

require WWW::Curl;
require Exporter;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

@EXPORT = qw(
CURLOPT_AUTOREFERER
CURLOPT_BUFFERSIZE
CURLOPT_CAINFO
CURLOPT_CAPATH
CURLOPT_CLOSEPOLICY
CURLOPT_CONNECTTIMEOUT
CURLOPT_CONNECT_ONLY
CURLOPT_CONV_FROM_NETWORK_FUNCTION
CURLOPT_CONV_FROM_UTF8_FUNCTION
CURLOPT_CONV_TO_NETWORK_FUNCTION
CURLOPT_COOKIE
CURLOPT_COOKIEFILE
CURLOPT_COOKIEJAR
CURLOPT_COOKIELIST
CURLOPT_COOKIESESSION
CURLOPT_CRLF
CURLOPT_CUSTOMREQUEST
CURLOPT_DEBUGDATA
CURLOPT_DEBUGFUNCTION
CURLOPT_DNS_CACHE_TIMEOUT
CURLOPT_DNS_USE_GLOBAL_CACHE
CURLOPT_EGDSOCKET
CURLOPT_ENCODING
CURLOPT_ERRORBUFFER
CURLOPT_FAILONERROR
CURLOPT_FILE
CURLOPT_FILETIME
CURLOPT_FOLLOWLOCATION
CURLOPT_FORBID_REUSE
CURLOPT_FRESH_CONNECT
CURLOPT_FTPAPPEND
CURLOPT_FTPASCII
CURLOPT_FTPLISTONLY
CURLOPT_FTPPORT
CURLOPT_FTPSSLAUTH
CURLOPT_FTP_ACCOUNT
CURLOPT_FTP_ALTERNATIVE_TO_USER
CURLOPT_FTP_CREATE_MISSING_DIRS
CURLOPT_FTP_FILEMETHOD
CURLOPT_FTP_RESPONSE_TIMEOUT
CURLOPT_FTP_SKIP_PASV_IP
CURLOPT_FTP_SSL
CURLOPT_FTP_USE_EPRT
CURLOPT_FTP_USE_EPSV
CURLOPT_HEADER
CURLOPT_HEADERDATA
CURLOPT_HEADERFUNCTION
CURLOPT_HTTP200ALIASES
CURLOPT_HTTPAUTH
CURLOPT_HTTPGET
CURLOPT_HTTPHEADER
CURLOPT_HTTPPOST
CURLOPT_HTTPPROXYTUNNEL
CURLOPT_HTTP_VERSION
CURLOPT_IGNORE_CONTENT_LENGTH
CURLOPT_INFILE
CURLOPT_INFILESIZE
CURLOPT_INFILESIZE_LARGE
CURLOPT_INTERFACE
CURLOPT_IOCTLDATA
CURLOPT_IOCTLFUNCTION
CURLOPT_IPRESOLVE
CURLOPT_KRB4LEVEL
CURLOPT_LOCALPORT
CURLOPT_LOCALPORTRANGE
CURLOPT_LOW_SPEED_LIMIT
CURLOPT_LOW_SPEED_TIME
CURLOPT_MAXCONNECTS
CURLOPT_MAXFILESIZE
CURLOPT_MAXFILESIZE_LARGE
CURLOPT_MAXREDIRS
CURLOPT_MAX_RECV_SPEED_LARGE
CURLOPT_MAX_SEND_SPEED_LARGE
CURLOPT_NETRC
CURLOPT_NETRC_FILE
CURLOPT_NOBODY
CURLOPT_NOPROGRESS
CURLOPT_NOSIGNAL
CURLOPT_PORT
CURLOPT_POST
CURLOPT_POSTFIELDS
CURLOPT_POSTFIELDSIZE
CURLOPT_POSTFIELDSIZE_LARGE
CURLOPT_POSTQUOTE
CURLOPT_PREQUOTE
CURLOPT_PRIVATE
CURLOPT_PROGRESSDATA
CURLOPT_PROGRESSFUNCTION
CURLOPT_PROTOCOLS
CURLOPT_PROXY
CURLOPT_PROXYAUTH
CURLOPT_PROXYPORT
CURLOPT_PROXYTYPE
CURLOPT_PROXYUSERPWD
CURLOPT_PUT
CURLOPT_QUOTE
CURLOPT_RANDOM_FILE
CURLOPT_RANGE
CURLOPT_READDATA
CURLOPT_READFUNCTION
CURLOPT_REDIR_PROTOCOLS
CURLOPT_REFERER
CURLOPT_RESUME_FROM
CURLOPT_RESUME_FROM_LARGE
CURLOPT_SHARE
CURLOPT_SOURCE_POSTQUOTE
CURLOPT_SOURCE_PREQUOTE
CURLOPT_SOURCE_QUOTE
CURLOPT_SOURCE_URL
CURLOPT_SOURCE_USERPWD
CURLOPT_SSLCERT
CURLOPT_SSLCERTPASSWD
CURLOPT_SSLCERTTYPE
CURLOPT_SSLENGINE
CURLOPT_SSLENGINE_DEFAULT
CURLOPT_SSLKEY
CURLOPT_SSLKEYPASSWD
CURLOPT_SSLKEYTYPE
CURLOPT_SSLVERSION
CURLOPT_SSL_CIPHER_LIST
CURLOPT_SSL_CTX_DATA
CURLOPT_SSL_CTX_FUNCTION
CURLOPT_SSL_VERIFYHOST
CURLOPT_SSL_VERIFYPEER
CURLOPT_STDERR
CURLOPT_TCP_NODELAY
CURLOPT_TELNETOPTIONS
CURLOPT_TIMECONDITION
CURLOPT_TIMEOUT
CURLOPT_TIMEVALUE
CURLOPT_TRANSFERTEXT
CURLOPT_UNRESTRICTED_AUTH
CURLOPT_UPLOAD
CURLOPT_URL
CURLOPT_USERAGENT
CURLOPT_USERPWD
CURLOPT_VERBOSE
CURLOPT_WRITEDATA
CURLOPT_WRITEFUNCTION
CURLOPT_WRITEHEADER
CURLOPT_WRITEINFO
CURLINFO_CONNECT_TIME
CURLINFO_CONTENT_LENGTH_DOWNLOAD
CURLINFO_CONTENT_LENGTH_UPLOAD
CURLINFO_CONTENT_TYPE
CURLINFO_COOKIELIST
CURLINFO_DATA_IN
CURLINFO_DATA_OUT
CURLINFO_EFFECTIVE_URL
CURLINFO_END
CURLINFO_FILETIME
CURLINFO_FTP_ENTRY_PATH
CURLINFO_HEADER_IN
CURLINFO_HEADER_OUT
CURLINFO_HEADER_SIZE
CURLINFO_HTTPAUTH_AVAIL
CURLINFO_HTTP_CODE
CURLINFO_HTTP_CONNECTCODE
CURLINFO_LASTONE
CURLINFO_LASTSOCKET
CURLINFO_NAMELOOKUP_TIME
CURLINFO_NONE
CURLINFO_NUM_CONNECTS
CURLINFO_OS_ERRNO
CURLINFO_PRETRANSFER_TIME
CURLINFO_PRIVATE
CURLINFO_PROXYAUTH_AVAIL
CURLINFO_REDIRECT_COUNT
CURLINFO_REDIRECT_TIME
CURLINFO_REQUEST_SIZE
CURLINFO_RESPONSE_CODE
CURLINFO_SIZE_DOWNLOAD
CURLINFO_SIZE_UPLOAD
CURLINFO_SPEED_DOWNLOAD
CURLINFO_SPEED_UPLOAD
CURLINFO_SSL_DATA_IN
CURLINFO_SSL_DATA_OUT
CURLINFO_SSL_ENGINES
CURLINFO_SSL_VERIFYRESULT
CURLINFO_STARTTRANSFER_TIME
CURLINFO_TEXT
CURLINFO_TOTAL_TIME
CURLE_ABORTED_BY_CALLBACK
CURLE_BAD_CALLING_ORDER
CURLE_BAD_CONTENT_ENCODING
CURLE_BAD_DOWNLOAD_RESUME
CURLE_BAD_FUNCTION_ARGUMENT
CURLE_BAD_PASSWORD_ENTERED
CURLE_CONV_FAILED
CURLE_CONV_REQD
CURLE_COULDNT_CONNECT
CURLE_COULDNT_RESOLVE_HOST
CURLE_COULDNT_RESOLVE_PROXY
CURLE_FAILED_INIT
CURLE_FILESIZE_EXCEEDED
CURLE_FILE_COULDNT_READ_FILE
CURLE_FTP_ACCESS_DENIED
CURLE_FTP_CANT_GET_HOST
CURLE_FTP_CANT_RECONNECT
CURLE_FTP_COULDNT_GET_SIZE
CURLE_FTP_COULDNT_RETR_FILE
CURLE_FTP_COULDNT_SET_ASCII
CURLE_FTP_COULDNT_SET_BINARY
CURLE_FTP_COULDNT_STOR_FILE
CURLE_FTP_COULDNT_USE_REST
CURLE_FTP_PORT_FAILED
CURLE_FTP_QUOTE_ERROR
CURLE_FTP_SSL_FAILED
CURLE_FTP_USER_PASSWORD_INCORRECT
CURLE_FTP_WEIRD_227_FORMAT
CURLE_FTP_WEIRD_PASS_REPLY
CURLE_FTP_WEIRD_PASV_REPLY
CURLE_FTP_WEIRD_SERVER_REPLY
CURLE_FTP_WEIRD_USER_REPLY
CURLE_FTP_WRITE_ERROR
CURLE_FUNCTION_NOT_FOUND
CURLE_GOT_NOTHING
CURLE_HTTP_POST_ERROR
CURLE_HTTP_RANGE_ERROR
CURLE_HTTP_RETURNED_ERROR
CURLE_INTERFACE_FAILED
CURLE_LDAP_CANNOT_BIND
CURLE_LDAP_INVALID_URL
CURLE_LDAP_SEARCH_FAILED
CURLE_LIBRARY_NOT_FOUND
CURLE_LOGIN_DENIED
CURLE_MALFORMAT_USER
CURLE_OBSOLETE
CURLE_OK
CURLE_OPERATION_TIMEOUTED
CURLE_OUT_OF_MEMORY
CURLE_PARTIAL_FILE
CURLE_READ_ERROR
CURLE_RECV_ERROR
CURLE_SEND_ERROR
CURLE_SEND_FAIL_REWIND
CURLE_SHARE_IN_USE
CURLE_SSL_CACERT
CURLE_SSL_CERTPROBLEM
CURLE_SSL_CIPHER
CURLE_SSL_CONNECT_ERROR
CURLE_SSL_ENGINE_INITFAILED
CURLE_SSL_ENGINE_NOTFOUND
CURLE_SSL_ENGINE_SETFAILED
CURLE_SSL_PEER_CERTIFICATE
CURLE_TELNET_OPTION_SYNTAX
CURLE_TFTP_DISKFULL
CURLE_TFTP_EXISTS
CURLE_TFTP_ILLEGAL
CURLE_TFTP_NOSUCHUSER
CURLE_TFTP_NOTFOUND
CURLE_TFTP_PERM
CURLE_TFTP_UNKNOWNID
CURLE_TOO_MANY_REDIRECTS
CURLE_UNKNOWN_TELNET_OPTION
CURLE_UNSUPPORTED_PROTOCOL
CURLE_URL_MALFORMAT
CURLE_URL_MALFORMAT_USER
CURLE_WRITE_ERROR
CURL_NETRC_IGNORED
CURL_NETRC_LAST
CURL_NETRC_OPTIONAL
CURL_NETRC_REQUIRED
);

$WWW::Curl::Easy::headers = "";
$WWW::Curl::Easy::content = "";

sub AUTOLOAD {

    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    ( my $constname = $AUTOLOAD ) =~ s/.*:://;
    return constant( $constname, 0 );
}

1;

__END__

Copyright (C) 2000-2005,2008 Daniel Stenberg, Cris Bailiff,
Sebastian Riedel, et al.
 
You may opt to use, copy, modify, merge, publish, distribute and/or sell
copies of the Software, and permit persons to whom the Software is furnished
to do so, under the terms of the MPL or the MIT/X-derivate licenses. You may
pick one of these licenses.
