These are the steps to cross-compile hurd:

    emerge sys-devel/crossdev::hurd
    crossdev -t i686-gnu
    i686-gnu-emerge hurd
