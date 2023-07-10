These are the steps to cross-compile hurd:

```
mkdir /usr/portage/cross-i686-gnu

ln -s /usr/sys-microkernel/{gnu-headers,mig} /usr/portage/cross-i686-gnu

emerge cross-i686-gnu/gnu-headers

ln -s /usr/i686-gnu/usr/include/mach /usr/local/include

emerge -O sys-microkernel/mig

rm /usr/local/include/mach

crossdev -t i686-gnu # cross-glibc fails

emerge -C sys-microkernel/mig

emerge cross-i686-gnu/mig

crossdev -t i686-gnu # succeeds now

i686-gnu-emerge hurd
```
