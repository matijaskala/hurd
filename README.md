These are the steps to cross-compile hurd:

First emerge sys-devel/crossdev from this overlay.

Then

    emerge cross-i686-gnu/gnu-headers
    crossdev -t i686-gnu
    i686-gnu-emerge hurd
