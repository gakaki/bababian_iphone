
#import "URLModelResponse.h"

/*
 *      BababianXMLRPCResponse
 *      -----------------
 *
 *  Parses the HTTP response from a Bababian image search query
 *  into a list of SearchResult objects.
 *
 *  I use wordpress android client xmlrpc framework
 *  to parse the JSON response and then store the parts
 *  in which we're interested to our domain object, "SearchResult".
 *
 */
@interface BababianXMLRPCResponse : URLModelResponse
{
}

@end
