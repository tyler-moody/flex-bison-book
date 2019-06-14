#ifndef _fb96_ctx_hpp
#define _fb96_ctx_hpp

#include <cassert>

class cppcalc_ctx {
public:
    cppcalc_ctx(int r)
    {
        assert(r > 1 && r < 10);
        radix = r;
    }

    inline int getradix(void)
    {
        return radix;
    }

private:
    int radix;
};
#endif
