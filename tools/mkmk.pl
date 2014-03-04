#!/usr/bin/perl -w
#
# Makefile Generator for C based MIOS applications
# Thorsten Klose (2005-08-14)
#
# SYNTAX: mkmk.pl [<-verbose>] <input-file>
#

use Getopt::Long;

$command_line = "$0 " . join(" ", @ARGV);

#######################################################################################

my %mk_variables = ();
my %obj_filenames = ();

#######################################################################################

my $verbose = 0;

GetOptions (
   "verbose" => \$verbose,
   );

######################################################################################

if( scalar(@ARGV) != 1 )
{
   die "SYNTAX: mkmk.pl [<-verbose>] <input-file>\n";
}

my ($input_file, $dos_makefile, $unix_makefile) = @ARGV;

#######################################################################################

open(IN, "<${input_file}") || die "ERROR: Cannot read ${input_file}\n";

my $line = 0;
while( <IN> ) {
  ++$line;

  chomp $_;   # delete \n

  $original_line = $_;

  s/\#.*//;  # remove comments
  s/^\s+//;  # strip left
  s/\s+$//;  # strip right

  if( length($_) ) {
    my @args = split(/\s+/, $_);
    my $cmd = uc($args[0]);


    if( $cmd eq "MK_SET" ) {
      if( scalar(@args) < 2 ) {
        notify_error("expecting at least one argument for the ${cmd} command: '${cmd} <variable> [<value(s)>]'");
      } else {
        my $key = uc($args[1]);

        $mk_variables{$key} = join(" ", splice(@args, 2));
        notify_note(sprintf("Setting makefile variable %s = %s", $key, $mk_variables{$key}));
      }
    } 

    elsif( $cmd eq "MK_ADD" ) {
      if( scalar(@args) < 3 ) {
        notify_error("expecting at least two arguments for the ${cmd} command: '${cmd} <variable> <value(s)>'");
      } else {
        my $key = uc($args[1]);

        if( !exists $mk_variables{$key} ) { $mk_variables{$key} = ""; }
        $mk_variables{$key} .= " " . join(" ", splice(@args, 2));
        notify_note(sprintf("Adding to makefile variable %s += %s", $key, $mk_variables{$key}));
      }
    }

    elsif( $cmd eq "MK_SET_OBJ" || $cmd eq "MK_ADD_OBJ" ) {
      if( scalar(@args) < 2 ) {
        notify_error("expecting at least two arguments for the ${cmd} command: '${cmd} <source-file(s)>'");
      } else {
        my $src_file;

	if( $cmd eq "MK_SET_OBJ" ) {
	  %obj_filenames = ();
	}

        foreach $src_file (splice(@args, 1)) {
          my @obj_path = split(/\//, $src_file);
          my $filename = $obj_path[$#obj_path];
          $filename =~ s/\.[^\.]+$/.o/;

          if( exists $obj_filenames{$filename} ) {
            notify_error("entry for $obj_filenames{$filename} does already exist!\n");
          } else {
            my $key;

            foreach $key (keys %obj_filenames) {
              if( $obj_filenames{$key} eq $filename ) {
                notify_error("Cannot add '${src_file}', entry for object name '${filename}' does already exist (used by '${key}')!\n");
              }
            }

            $obj_filenames{$src_file} = $filename;
            notify_note("adding source file ${src_file} (object file: ${filename})");
          }
	}
      }
    }

    elsif( $cmd eq "WRITE_FILE" ) {
      if( scalar(@args) < 2 ) {
        notify_error("expecting at least two arguments for the ${cmd} command: '${cmd} <target-file>'");
      } else {
        my $target_file = $args[1];

	write_file($target_file);
      }
    }

    else {
      notify_error("Don't know what to do with statement:\n${original_line}");
    }
  }
}
close(IN);

exit;


#######################################################################################
#######################################################################################
### Subroutines
#######################################################################################
#######################################################################################

sub notify_error
{
  my ($msg) = @_;

  die sprintf("[ERROR  |%4d] %s\n", $line, $msg);
}

sub notify_warning
{
  my ($msg) = @_;

  printf("[WARNING|%4d] %s\n", $line, $msg);
}

sub notify_note
{
  my ($msg) = @_;

  if( $verbose ) {
    printf("[NOTE   |%4d] %s\n", $line, $msg);
  }
}

sub check_defined_var
{
  my $key;
  foreach $key (@_) {
    if( !exists $mk_variables{$key} ) {
      notify_error("${key} variable has to be specified for DOS batchfile!\n");
    }
  }
}

sub write_file
{
  my ($target_file) = @_;

  my $src_file;
  my @obj_list;
  foreach $src_file (keys %obj_filenames)
  {
    my $obj_file = $obj_filenames{$src_file};
    push @obj_list, "\$(OUTDIR)/${obj_file}";
  }

  ##############################################################################
  # UNIX makefile

  open(OUT, ">${target_file}") || die "ERROR: cannot open ${target_file}!\n";

  print OUT "# generated with ${command_line}\n";
  print OUT "\n";
  foreach $var (sort keys %mk_variables) {
    printf OUT "%s=%s\n", $var, $mk_variables{$var};
  }

  print OUT "\n";
  print OUT "OBJS=" . join(" ", @obj_list) . "\n";

  if( exists $mk_variables{HEX2SYX} ) {
     print OUT "\n";
     print OUT "\$(PROJECT).syx: \$(PROJECT).hex\n";
     print OUT "\t\$(HEX2SYX) \$(PROJECT).hex\n";
  }

  if( exists $mk_variables{MIOS_WRAPPER_DEFINES} ) {
     print OUT "\n";
     print OUT "\$(PROJECT).hex: \$(OUTDIR)/mios_wrapper.o \$(OBJS)\n";
     print OUT "\t\$(GPLINK) -s \$(PROJECT).lkr -m -o \$(PROJECT).hex \$(OUTDIR)/mios_wrapper.o \$(OBJS)\n";
     print OUT "\n";
     print OUT "\$(OUTDIR)/mios_wrapper.o: mios_wrapper/mios_wrapper.asm\n";
     print OUT "\t\$(GPASM) \$(MIOS_WRAPPER_DEFINES) -I mios_wrapper mios_wrapper/mios_wrapper.asm -o \$(OUTDIR)/mios_wrapper.o\n";
  } else {
     print OUT "\n";
     print OUT "\$(PROJECT).hex: \$(OBJS)\n";
     print OUT "\t\$(GPLINK) -s \$(PROJECT).lkr -m -o \$(PROJECT).hex \$(OBJS)\n";
  }


  print OUT "\n";
  print OUT "\$(OUTDIR)/%.o: %.c\n";

  print OUT "\n";
  print OUT "\$(OUTDIR)/%.asm: %.c\n";
  print OUT "\t\$(CC) \$(CFLAGS) \$(SDCC_DEFINES) \$< -o \$\@\n";
  if( exists $mk_variables{FIXASM} ) {
    print OUT "\t\$(FIXASM) \$\@\n";
  }

  print OUT "\n";
  foreach $src_file (keys %obj_filenames)
  {
    my $obj_file = $obj_filenames{$src_file};
    my $asm_file = substr($obj_file, 0, -2) . ".asm";
    if( $src_file eq $asm_file ) {
      print OUT "\$(OUTDIR)/${obj_file}: ${src_file}\n";
      print OUT "\t\$(GPASM) \$< -o \$@\n";
    } else {
      print OUT "\$(OUTDIR)/${obj_file}: \$(OUTDIR)/${asm_file}\n";
      print OUT "\t\$(GPASM) \$< -o \$@\n";
    }
  }

  print OUT "\n";


  print OUT "\n";
  print OUT "clean:\n";
  print OUT "\trm -rf _output/*\n";
  print OUT "\trm -rf *.cod *.map *.lst\n";

  close(OUT);

  print "${target_file} generated.\n";


  ##############################################################################
  # DOS batch file

#  check_defined_var("CC", "FIXASM", "HEX2SYX", "GPASM", "GPLINK", "OUTDIR", "CFLAGS", 
#    "PROJECT", "MIOS_WRAPPER_DEFINES", "SDCC_DEFINES");
  check_defined_var("CC", "GPASM", "GPLINK", "OUTDIR", "CFLAGS", 
    "PROJECT", "SDCC_DEFINES");

  my $FIXASM = 0;
  if( exists $mk_variables{FIXASM} ) {
    $FIXASM = $mk_variables{FIXASM};
    $FIXASM =~ s/\//\\/g;
  }

  my $HEX2SYX = 0;
  if( exists $mk_variables{HEX2SYX} ) {
     $HEX2SYX = $mk_variables{HEX2SYX};
     $HEX2SYX =~ s/\//\\/g;
  }

  open(OUT, ">${target_file}.bat") || die "ERROR: cannot open ${target_file}.bat!\n";

  print OUT "\@ECHO OFF\n";
  print OUT "REM generated with ${command_line}\n";

  print OUT "\n";
  print OUT "REM === create output directory ===============================================\n";
  print OUT "if not exist $mk_variables{OUTDIR} mkdir $mk_variables{OUTDIR}\n";

  if( exists $mk_variables{MIOS_WRAPPER_DEFINES} ) {
     print OUT "\n";
     print OUT "REM === assemble MIOS SDCC wrapper and device specific setup ==================\n";
     print OUT "echo Assembling MIOS SDCC wrapper\n";
     print OUT "$mk_variables{GPASM} $mk_variables{MIOS_WRAPPER_DEFINES} -I mios_wrapper mios_wrapper\\mios_wrapper.asm -o $mk_variables{OUTDIR}\\mios_wrapper.o\n";
     print OUT "if errorlevel 1 goto end_error\n";
  }

  print OUT "\n";
  print OUT "REM === Build the project files ===============================================\n";

  foreach $src_file (keys %obj_filenames)
  {
    my $obj_file = $obj_filenames{$src_file};
    my $asm_file = substr($obj_file, 0, -2) . ".asm";

    if( $src_file eq $asm_file ) {
       print OUT "echo ==========================================================================\n";
       print OUT "echo Compiling ${src_file}\n";

#       print OUT "copy ${src_file} $mk_variables{OUTDIR}\\${asm_file}\n";
#       print OUT "if errorlevel 1 goto end_error\n";

       print OUT "$mk_variables{GPASM} ${asm_file} -o $mk_variables{OUTDIR}\\${obj_file}\n";
       print OUT "if errorlevel 1 goto end_error\n";
    } else {
       print OUT "echo ==========================================================================\n";
       print OUT "echo Compiling ${src_file}\n";

       print OUT "$mk_variables{CC} $mk_variables{CFLAGS} $mk_variables{SDCC_DEFINES} ${src_file} -o $mk_variables{OUTDIR}\\${asm_file}\n";
       print OUT "if errorlevel 1 goto end_error\n";

       if( $FIXASM ) {
	  print OUT "${FIXASM} $mk_variables{OUTDIR}\\${asm_file}\n";
	  print OUT "if errorlevel 1 goto end_error\n";
       }

       print OUT "$mk_variables{GPASM} $mk_variables{OUTDIR}\\${asm_file} -o $mk_variables{OUTDIR}\\${obj_file}\n";
       print OUT "if errorlevel 1 goto end_error\n";
    }
  }

  print OUT "\n";
  print OUT "echo ==========================================================================\n";
  print OUT "echo Linking $mk_variables{PROJECT}\n";
  print OUT "$mk_variables{GPLINK} -s $mk_variables{PROJECT}.lkr -m -o $mk_variables{PROJECT}.hex $mk_variables{OUTDIR}\\*.o\n";
  print OUT "if errorlevel 1 goto end_error\n";

  if( $HEX2SYX ) {
     print OUT "\n";
     print OUT "echo ==========================================================================\n";
     print OUT "echo Converting to $mk_variables{PROJECT}.syx\n";
     print OUT "${HEX2SYX} $mk_variables{PROJECT}.hex\n";
     print OUT "if errorlevel 1 goto end_error\n";
  }

  print OUT "\n";
  print OUT "echo ==========================================================================\n";
  print OUT "echo SUCCESS!\n";
  print OUT "goto :end\n";

  print OUT "\n";
  print OUT ":end_error\n";
  print OUT "echo ERROR!\n";
  print OUT ":end\n";

  close(OUT);

  print "${target_file}.bat generated.\n";

}

