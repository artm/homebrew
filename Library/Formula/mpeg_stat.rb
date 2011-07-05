require 'formula'

class MpegStat < Formula
  url 'http://hpux.connect.org.uk/ftp/hpux/Development/Tools/mpeg_stat-2.2b/mpeg_stat-2.2b-src-11.00.tar.gz'
  homepage 'http://hpux.connect.org.uk/hppd/hpux/Development/Tools/mpeg_stat-2.2b/'
  version '2.2b-11.00'
  md5 'b836282185be404a6eebb55311b49ade'

  def patches
    # add a compliant install target
    DATA
  end

  def install
    system "make install DESTDIR=#{prefix}"
  end
end
__END__
t a/Makefile b/Makefile
index 48aedd1..a6c5be2 100644
--- a/Makefile
+++ b/Makefile
@@ -23,7 +23,7 @@ CFLAGS                =   $(DEBUGFLAG) $(INCLUDEDIR)

 # for SunOS cc, just use the above
 # for cc on HPUX:
-HP-CC-FLAGS        =  -Aa $(CFLAGS) -D_HPUX_SOURCE -DBSD -DNONANSI_INCLUDES
+# HP-CC-FLAGS        =  -Aa $(CFLAGS) -D_HPUX_SOURCE -DBSD -DNONANSI_INCLUDES

 HDRS       = util.h video.h decoders.h fs2.h dither.h fs4.h

@@ -45,12 +45,12 @@ $(PROGRAM): $(OBJS)

 clean:;    @rm -f *.o core $(PROGRAM)

-bindir=/opt/mpeg_stat/bin
-mandir=/opt/mpeg_stat/man/man1
+bindir=$(DESTDIR)/bin
+mandir=$(DESTDIR)/share/man/man1

 EXES= block2spec parse_time to_hist to_nums

-install:
+bsd-install:
  test -d $(bindir) || mkdirhier $(bindir)
  bsdinst -c  -s mpeg_stat $(bindir)
  for i in $(EXES) ; do \
@@ -59,3 +59,8 @@ install:
  test -d $(mandir) || mkdirhier $(mandir)
  bsdinst -c  -m 0644 mpeg_stat.1 $(mandir)

+install: all
+ install -d $(bindir)
+ install -m 0755 mpeg_stat $(bindir)
+ install -d $(mandir)
+ install -m 0644 mpeg_stat.1 $(mandir)
