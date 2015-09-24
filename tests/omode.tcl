begin {Check OMODE changes}

set test_channel #omode

client oper

oper :
    # set up m_omode.so
    >> OPER god testsuite
    << $RPL_YOUREOPER
    >> MODLOAD extensions/m_omode.so

    # sleep a little just in case
    after 125

    >> MODE [oper nick] +p
    << MODE [oper nick] +p
    >> MODE $test_channel +h [oper nick]
    << MODE $test_channel +h [oper nick]
    >> OMODE $test_channel +y [oper nick]
    << MODE $test_channel +y [oper nick]

    >> MODUNLOAD m_omode.so