These are the steps to cross-compile hurd:

```
mkdir /usr/portage/cross-i686-gnu

ln -s /usr/sys-microkernel/{gnu-headers,mig} /usr/portage/cross-i686-gnu

emerge cross-i686-gnu/gnu-headers

crossdev -t i686-gnu # cross-glibc fails

emerge cross-i686-gnu/mig

crossdev -t i686-gnu # succeeds now

i686-gnu-emerge hurd
```
