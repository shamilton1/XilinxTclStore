#########################################################################
#
# register_options.tcl (create simulation fileset properties with default
#                       values for the 'Cadence IES Simulator')
#
# Script created on 01/06/2014 by Raj Klair (Xilinx, Inc.)
#
# 2014.1 - v1.0 (rev 1)
#  * initial version
#
#########################################################################
package require Vivado 2013.1
package require ::tclapp::xilinx::ies::helpers

namespace eval ::tclapp::xilinx::ies {
proc register_options { simulator } {
  # Summary:
  # Argument Usage:
  # Return Value:

  variable options
  if { {} == $simulator } {
    send_msg_id Vivado-IES-999 ERROR "Simulator not specified.\n"
  }
  # is simulator registered?
  if { {-1} == [lsearch [get_simulators] $simulator] } {
    send_msg_id Vivado-IES-999 ERROR "Simulator '$simulator' is not registered\n"
    return 1
  }
  # simulation fileset object on which the options will be created and value set
  set fs_obj [current_fileset -simset]
  set options {
    {{compile.v93}            {bool}   {1}                                                   {Enable VHDL93 features}}
    {{compile.32bit}          {bool}   {1}                                                   {Invoke 32-bit executable}}
    {{compile.relax}          {bool}   {1}                                                   {Enable relaxed VHDL interpretation}}
    {{compile.unifast}        {bool}   {0}                                                   {Enable fast simulation models}}
    {{compile.load_glbl}      {bool}   {1}                                                   {Load GLBL module}}
    {{compile.more_options}   {string} {}                                                    {More Compilation Options}}
    {{elaborate.more_options} {string} {}                                                    {More Elaboration Options}}
    {{simulate.saif}          {string} {}                                                    {SAIF Filename}}
    {{simulate.more_options}  {string} {}                                                    {More Simulation Options}}
  }
  # create options
  ::tclapp::xilinx::ies::usf_create_options $simulator $options
  return 0
}
}
