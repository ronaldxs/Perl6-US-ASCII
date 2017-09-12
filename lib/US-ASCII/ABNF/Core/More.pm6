use US-ASCII::ABNF::Core::P6Common;

# duplicates of p6 character classes

unit role US-ASCII::ABNF::Core::More:ver<0.1.1>:auth<R Schmidt (ronaldxs@software-path.com)>;

token CTL       { <.US-ASCII::ABNF::Core::P6Common_g::cntrl>   }
token WSP       { <.US-ASCII::ABNF::Core::P6Common_g::blank>   }
