These are the steps to cross-compile hurd:

```
mkdir /usr/portage/cross-i686-gnu /usr/local/include/hurd

ln -s /usr/sys-microkernel/{gnu-headers,mig} /usr/portage/cross-i686-gnu

emerge cross-i686-gnu/gnu-headers

ln -s /usr/i686-gnu/usr/include/mach /usr/local/include

emerge -O sys-microkernel/mig

ln -s /usr/i686-gnu/include/hurd/version.h /usr/local/include/hurd

crossdev -t i686-gnu # cross-glibc fails

emerge -C sys-microkernel/mig

rm /usr/local/include/mach

rm /usr/local/include/hurd/version.h

rmdir /usr/local/include/hurd

emerge cross-i686-gnu/mig

i686-gnu-emerge -O hurd # fails

make -C /usr/i686-gnu/tmp/portage/sys-microkernel/hurd-0.9/work/hurd-0.9/libihash CC=i686-gnu-gcc libihash.a # fails

mkdir /usr/i686-gnu/lib

cp /usr/i686-gnu/tmp/portage/sys-microkernel/hurd-0.9/work/hurd-0.9/libihash/libihash.a /usr/i686-gnu/lib

crossdev -t i686-gnu # succeeds now

i686-gnu-emerge -O hurd # succeeds now

emerge cross-i686-gnu/glibc # recompile libc
```
