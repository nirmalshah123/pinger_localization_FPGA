#*****************************************************************************************

# To run this file just run the following command:

# source final_backup.tcl

#*****************************************************************************************

# Check file required for this script exists
proc checkRequiredFiles { origin_dir} {
  set status true
  set files [list \
 "[file normalize "hdl/write_to_bram.vhd"]"\
 "[file normalize "hdl/delay_by_1.vhd"]"\
 "[file normalize "hdl/read_from_bram.vhd"]"\
 "[file normalize "hdl/design_1_wrapper.vhd"]"\
 "[file normalize "hdl/frequency_finder.vhd"]"\
 "[file normalize "hdl/comparator.vhd"]"\
 "[file normalize "hdl/thresholding.vhd"]"\
 "[file normalize "hdl/corr_sine_bram.vhd"]"\
 "[file normalize "hdl/sine_real.coe"]"\
 "[file normalize "hdl/sine_img.coe"]"\
 "[file normalize "hdl/rising_edge_bram.vhd"]"\
 "[file normalize "hdl/lwr_wnd_sum.vhd"]"\
 "[file normalize "hdl/upper_wnd_sum.vhd"]"\
 "[file normalize "hdl/compare.vhd"]"\
 "[file normalize "hdl/hyd1_bram.vhd"]"\
 "[file normalize "hdl/CORR_HYD1.vhd"]"\
 "[file normalize "hdl/tb.vhd"]"\
 "[file normalize "hdl/tb_behav.wcfg"]"\
  ]
  foreach ifile $files {
    if { ![file isfile $ifile] } {
      puts " Could not find local file $ifile "
      set status false
    }
  }

  return $status
}
# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir "."

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

# Set the project name
set _xil_proj_name_ "final_backup"

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set _xil_proj_name_ $::user_project_name
}

variable script_file
set script_file "final_backup.tcl"

# Help information for this script
proc print_help {} {
  variable script_file
  puts "\nDescription:"
  puts "Recreate a Vivado project from this script. The created project will be"
  puts "functionally equivalent to the original project for which this script was"
  puts "generated. The script contains commands for creating a project, filesets,"
  puts "runs, adding/importing sources and setting properties on various objects.\n"
  puts "Syntax:"
  puts "$script_file"
  puts "$script_file -tclargs \[--origin_dir <path>\]"
  puts "$script_file -tclargs \[--project_name <name>\]"
  puts "$script_file -tclargs \[--help\]\n"
  puts "Usage:"
  puts "Name                   Description"
  puts "-------------------------------------------------------------------------"
  puts "\[--origin_dir <path>\]  Determine source file paths wrt this path. Default"
  puts "                       origin_dir path value is \".\", otherwise, the value"
  puts "                       that was set with the \"-paths_relative_to\" switch"
  puts "                       when this script was generated.\n"
  puts "\[--project_name <name>\] Create project with the specified name. Default"
  puts "                       name is the name of the project from where this"
  puts "                       script was generated.\n"
  puts "\[--help\]               Print help information for this script"
  puts "-------------------------------------------------------------------------\n"
  exit 0
}

if { $::argc > 0 } {
  for {set i 0} {$i < $::argc} {incr i} {
    set option [string trim [lindex $::argv $i]]
    switch -regexp -- $option {
      "--origin_dir"   { incr i; set origin_dir [lindex $::argv $i] }
      "--project_name" { incr i; set _xil_proj_name_ [lindex $::argv $i] }
      "--help"         { print_help }
      default {
        if { [regexp {^-} $option] } {
          puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
          return 1
        }
      }
    }
  }
}

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/../final_backup"]"

# Check for paths and files needed for project creation
set validate_required 0
if { $validate_required } {
  if { [checkRequiredFiles $origin_dir] } {
    puts "Tcl file $script_file is valid. All files required for project creation is accesable. "
  } else {
    puts "Tcl file $script_file is not valid. Not all files required for project creation is accesable. "
    return
  }
}

# Create project
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7a35ticsg324-1L

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [current_project]
set_property -name "board_part" -value "digilentinc.com:arty-a7-35:part0:1.0" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "platform.board_id" -value "arty-a7-35" -objects $obj
set_property -name "revised_directory_structure" -value "1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${_xil_proj_name_}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "sim.ipstatic.compiled_library_dir" -value "D:/AUV_Elec/Pinger_task_using_FPGA/test_2021_version/project_1/project_1.cache/compile_simlib/xsim/ip" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj
set_property -name "webtalk.activehdl_export_sim" -value "4" -objects $obj
set_property -name "webtalk.ies_export_sim" -value "4" -objects $obj
set_property -name "webtalk.modelsim_export_sim" -value "4" -objects $obj
set_property -name "webtalk.questa_export_sim" -value "4" -objects $obj
set_property -name "webtalk.riviera_export_sim" -value "4" -objects $obj
set_property -name "webtalk.vcs_export_sim" -value "4" -objects $obj
set_property -name "webtalk.xsim_export_sim" -value "4" -objects $obj
set_property -name "webtalk.xsim_launch_sim" -value "46" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_FIFO XPM_MEMORY" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
# Import local files from the original project
set files [list \
 [file normalize "hdl/write_to_bram.vhd"]\
 [file normalize "hdl/delay_by_1.vhd"]\
 [file normalize "hdl/read_from_bram.vhd"]\
 [file normalize "hdl/design_1_wrapper.vhd"]\
 [file normalize "hdl/frequency_finder.vhd"]\
 [file normalize "hdl/comparator.vhd"]\
 [file normalize "hdl/thresholding.vhd"]\
 [file normalize "hdl/corr_sine_bram.vhd"]\
 [file normalize "hdl/sine_real.coe"]\
 [file normalize "hdl/sine_img.coe"]\
 [file normalize "hdl/rising_edge_bram.vhd"]\
 [file normalize "hdl/lwr_wnd_sum.vhd"]\
 [file normalize "hdl/upper_wnd_sum.vhd"]\
 [file normalize "hdl/compare.vhd"]\
 [file normalize "hdl/hyd1_bram.vhd"]\
 [file normalize "hdl/CORR_HYD1.vhd"]\
]
set imported_files [import_files -fileset sources_1 $files]

# Set 'sources_1' fileset file properties for remote files
# None

# Set 'sources_1' fileset file properties for local files
set file "hdl/write_to_bram.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/delay_by_1.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/read_from_bram.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/design_1_wrapper.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/frequency_finder.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/comparator.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/thresholding.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/corr_sine_bram.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/rising_edge_bram.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/lwr_wnd_sum.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/upper_wnd_sum.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/compare.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/hyd1_bram.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "hdl/CORR_HYD1.vhd"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj


# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "top" -value "design_1_wrapper" -objects $obj

# Create 'design_5_inst_0' fileset (if not found)
if {[string equal [get_filesets -quiet design_5_inst_0] ""]} {
  create_fileset -blockset design_5_inst_0
}

# Set 'design_5_inst_0' fileset object
set obj [get_filesets design_5_inst_0]
# Empty (no sources present)

# Set 'design_5_inst_0' fileset properties
set obj [get_filesets design_5_inst_0]
set_property -name "top" -value "design_5_inst_0" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Empty (no sources present)

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Import local files from the original project
set files [list \
 [file normalize "hdl/tb.vhd"]\
 [file normalize "hdl/tb_behav.wcfg"]\
]
set imported_files [import_files -fileset sim_1 $files]

# Set 'sim_1' fileset file properties for remote files
# None

# Set 'sim_1' fileset file properties for local files
set file "hdl/tb.vhd"
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj


# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "nl.mode" -value "funcsim" -objects $obj
set_property -name "sim_mode" -value "post-synthesis" -objects $obj
set_property -name "top" -value "tb" -objects $obj
set_property -name "top_lib" -value "xil_defaultlib" -objects $obj

# Set 'utils_1' fileset object
set obj [get_filesets utils_1]
# Empty (no sources present)

# Set 'utils_1' fileset properties
set obj [get_filesets utils_1]


# Adding sources referenced in BDs, if not already added
if { [get_files CORR_HYD1.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/CORR_HYD1.vhd
}
if { [get_files delay_by_1.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/delay_by_1.vhd
}
if { [get_files CORR_HYD1.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/CORR_HYD1.vhd
}
if { [get_files delay_by_1.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/delay_by_1.vhd
}


# Proc to create BD design_6
proc cr_bd_design_6 { parentCell } {
# The design that will be created by this Tcl proc contains the following 
# module references:
# CORR_HYD1, delay_by_1



  # CHANGE DESIGN NAME HERE
  set design_name design_6

  common::send_gid_msg -ssname BD::TCL -id 2010 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:ip:floating_point:7.1\
  "

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  ##################################################################
  # CHECK Modules
  ##################################################################
  set bCheckModules 1
  if { $bCheckModules == 1 } {
     set list_check_mods "\ 
  CORR_HYD1\
  delay_by_1\
  "

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

  if { $bCheckIPsPassed != 1 } {
    common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set ADDR [ create_bd_port -dir O -from 11 -to 0 ADDR ]
  set CLK [ create_bd_port -dir I -type clk -freq_hz 100000000 CLK ]
  set CORR_IMAG [ create_bd_port -dir O -from 31 -to 0 CORR_IMAG ]
  set CORR_REAL [ create_bd_port -dir O -from 31 -to 0 CORR_REAL ]
  set HYD1_DATA_IN_IMAG [ create_bd_port -dir I -from 31 -to 0 HYD1_DATA_IN_IMAG ]
  set HYD1_DATA_IN_REAL [ create_bd_port -dir I -from 31 -to 0 HYD1_DATA_IN_REAL ]
  set INDEX [ create_bd_port -dir I -from 31 -to 0 INDEX ]
  set INDEX_VALID [ create_bd_port -dir I INDEX_VALID ]
  set INP_IMAG [ create_bd_port -dir I -from 31 -to 0 INP_IMAG ]
  set INP_REAL [ create_bd_port -dir I -from 31 -to 0 INP_REAL ]
  set INP_VALID [ create_bd_port -dir I INP_VALID ]
  set VALID [ create_bd_port -dir O VALID ]

  # Create instance: ADD, and set properties
  set ADD [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 ADD ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Add} \
   CONFIG.C_Latency {12} \
   CONFIG.Has_RESULT_TREADY {false} \
 ] $ADD

  # Create instance: AX, and set properties
  set AX [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 AX ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $AX

  # Create instance: AY, and set properties
  set AY [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 AY ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $AY

  # Create instance: BX, and set properties
  set BX [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 BX ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $BX

  # Create instance: BY, and set properties
  set BY [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 BY ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $BY

  # Create instance: CORR_HYD1_0, and set properties
  set block_name CORR_HYD1
  set block_cell_name CORR_HYD1_0
  if { [catch {set CORR_HYD1_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $CORR_HYD1_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: SUBTRACT, and set properties
  set SUBTRACT [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 SUBTRACT ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Subtract} \
   CONFIG.C_Latency {12} \
   CONFIG.Has_RESULT_TREADY {false} \
 ] $SUBTRACT

  # Create instance: delay_by_1_0, and set properties
  set block_name delay_by_1
  set block_cell_name delay_by_1_0
  if { [catch {set delay_by_1_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $delay_by_1_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create interface connections
  connect_bd_intf_net -intf_net AX_M_AXIS_RESULT [get_bd_intf_pins AX/M_AXIS_RESULT] [get_bd_intf_pins SUBTRACT/S_AXIS_A]
  connect_bd_intf_net -intf_net AY_M_AXIS_RESULT [get_bd_intf_pins ADD/S_AXIS_A] [get_bd_intf_pins AY/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net BX_M_AXIS_RESULT [get_bd_intf_pins ADD/S_AXIS_B] [get_bd_intf_pins BX/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net BY_M_AXIS_RESULT [get_bd_intf_pins BY/M_AXIS_RESULT] [get_bd_intf_pins SUBTRACT/S_AXIS_B]

  # Create port connections
  connect_bd_net -net ADD_m_axis_result_tdata [get_bd_ports CORR_IMAG] [get_bd_pins ADD/m_axis_result_tdata]
  connect_bd_net -net ADD_m_axis_result_tvalid [get_bd_ports VALID] [get_bd_pins ADD/m_axis_result_tvalid]
  connect_bd_net -net CORR_HYD1_0_ADDR [get_bd_ports ADDR] [get_bd_pins CORR_HYD1_0/ADDR]
  connect_bd_net -net CORR_HYD1_0_CORR_OUT_IMG [get_bd_ports HYD1_DATA_IN_IMAG] [get_bd_pins AY/s_axis_b_tdata] [get_bd_pins BY/s_axis_b_tdata]
  connect_bd_net -net CORR_HYD1_0_CORR_OUT_REAL [get_bd_ports HYD1_DATA_IN_REAL] [get_bd_pins AX/s_axis_b_tdata] [get_bd_pins BX/s_axis_b_tdata]
  connect_bd_net -net CORR_HYD1_0_INP_IMG [get_bd_pins BX/s_axis_a_tdata] [get_bd_pins BY/s_axis_a_tdata] [get_bd_pins CORR_HYD1_0/OUT_INPUT_IMAG]
  connect_bd_net -net CORR_HYD1_0_OUT_INPUT_REAL [get_bd_pins AX/s_axis_a_tdata] [get_bd_pins AY/s_axis_a_tdata] [get_bd_pins CORR_HYD1_0/OUT_INPUT_REAL]
  connect_bd_net -net INDEX_1 [get_bd_ports INDEX] [get_bd_pins CORR_HYD1_0/INDEX]
  connect_bd_net -net INDEX_VALID_1 [get_bd_ports INDEX_VALID] [get_bd_pins CORR_HYD1_0/INDEX_VALID]
  connect_bd_net -net INP_IMAG_1 [get_bd_ports INP_IMAG] [get_bd_pins CORR_HYD1_0/INP_IMAG]
  connect_bd_net -net INP_REAL_1 [get_bd_ports INP_REAL] [get_bd_pins CORR_HYD1_0/INP_REAL]
  connect_bd_net -net INP_VALID_1 [get_bd_ports INP_VALID] [get_bd_pins CORR_HYD1_0/INP_VALID] [get_bd_pins delay_by_1_0/INP_DATA]
  connect_bd_net -net Net [get_bd_ports CLK] [get_bd_pins ADD/aclk] [get_bd_pins AX/aclk] [get_bd_pins AY/aclk] [get_bd_pins BX/aclk] [get_bd_pins BY/aclk] [get_bd_pins CORR_HYD1_0/CLK] [get_bd_pins SUBTRACT/aclk] [get_bd_pins delay_by_1_0/CLK]
  connect_bd_net -net Net1 [get_bd_pins AX/s_axis_a_tvalid] [get_bd_pins AX/s_axis_b_tvalid] [get_bd_pins AY/s_axis_a_tvalid] [get_bd_pins AY/s_axis_b_tvalid] [get_bd_pins BX/s_axis_a_tvalid] [get_bd_pins BX/s_axis_b_tvalid] [get_bd_pins BY/s_axis_a_tvalid] [get_bd_pins BY/s_axis_b_tvalid] [get_bd_pins delay_by_1_0/OUT_DATA]
  connect_bd_net -net SUBTRACT_m_axis_result_tdata [get_bd_ports CORR_REAL] [get_bd_pins SUBTRACT/m_axis_result_tdata]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_design_6()
cr_bd_design_6 ""
set_property REGISTERED_WITH_MANAGER "1" [get_files design_6.bd ] 
set_property SYNTH_CHECKPOINT_MODE "Hierarchical" [get_files design_6.bd ] 

if { [get_files frequency_finder.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/frequency_finder.vhd
}
if { [get_files thresholding.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/thresholding.vhd
}
if { [get_files comparator.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/comparator.vhd
}
if { [get_files frequency_finder.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/frequency_finder.vhd
}
if { [get_files thresholding.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/thresholding.vhd
}
if { [get_files comparator.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/comparator.vhd
}


# Proc to create BD design_2
proc cr_bd_design_2 { parentCell } {
# The design that will be created by this Tcl proc contains the following 
# module references:
# comparator, frequency_finder, thresholding



  # CHANGE DESIGN NAME HERE
  set design_name design_2

  common::send_gid_msg -ssname BD::TCL -id 2010 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:ip:floating_point:7.1\
  xilinx.com:ip:axis_data_fifo:2.0\
  "

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  ##################################################################
  # CHECK Modules
  ##################################################################
  set bCheckModules 1
  if { $bCheckModules == 1 } {
     set list_check_mods "\ 
  comparator\
  frequency_finder\
  thresholding\
  "

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

  if { $bCheckIPsPassed != 1 } {
    common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set BIN_DETECTED [ create_bd_port -dir O BIN_DETECTED ]
  set BIN_DETECTED_VALID [ create_bd_port -dir O BIN_DETECTED_VALID ]
  set CLK [ create_bd_port -dir I CLK ]
  set IM_INPUT [ create_bd_port -dir I IM_INPUT ]
  set IM_VALID [ create_bd_port -dir I IM_VALID ]
  set RESET [ create_bd_port -dir I -type rst RESET ]
  set RE_INPUT [ create_bd_port -dir I RE_INPUT ]
  set RE_VALID [ create_bd_port -dir I RE_VALID ]

  # Create instance: ADD, and set properties
  set ADD [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 ADD ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Add} \
   CONFIG.C_Latency {12} \
   CONFIG.Has_RESULT_TREADY {false} \
 ] $ADD

  # Create instance: IM_SQUARE, and set properties
  set IM_SQUARE [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 IM_SQUARE ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_RESULT_TREADY {true} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $IM_SQUARE

  # Create instance: RE_SQUARE, and set properties
  set RE_SQUARE [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 RE_SQUARE ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_RESULT_TREADY {true} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $RE_SQUARE

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.TDATA_NUM_BYTES {4} \
 ] $axis_data_fifo_0

  # Create instance: comparator_0, and set properties
  set block_name comparator
  set block_cell_name comparator_0
  if { [catch {set comparator_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $comparator_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: frequency_finder_0, and set properties
  set block_name frequency_finder
  set block_cell_name frequency_finder_0
  if { [catch {set frequency_finder_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $frequency_finder_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.FREQUENCY {45000} \
   CONFIG.FREQ_THRESH {2000} \
   CONFIG.NO_OF_SAMPLES {4096} \
   CONFIG.SAMPLING_FREQ {2000000} \
 ] $frequency_finder_0

  # Create instance: thresholding_0, and set properties
  set block_name thresholding
  set block_cell_name thresholding_0
  if { [catch {set thresholding_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $thresholding_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.COUNTER_THRESH {100} \
 ] $thresholding_0

  # Create interface connections
  connect_bd_intf_net -intf_net IM_SQUARE_M_AXIS_RESULT [get_bd_intf_pins ADD/S_AXIS_B] [get_bd_intf_pins IM_SQUARE/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net RE_SQUARE_M_AXIS_RESULT [get_bd_intf_pins ADD/S_AXIS_A] [get_bd_intf_pins RE_SQUARE/M_AXIS_RESULT]

  # Create port connections
  connect_bd_net -net ADD_m_axis_result_tdata [get_bd_pins ADD/m_axis_result_tdata] [get_bd_pins axis_data_fifo_0/s_axis_tdata] [get_bd_pins frequency_finder_0/S_AXIS_TDATA]
  connect_bd_net -net ADD_m_axis_result_tvalid [get_bd_pins ADD/m_axis_result_tvalid] [get_bd_pins axis_data_fifo_0/s_axis_tvalid] [get_bd_pins frequency_finder_0/S_AXIS_TVALID]
  connect_bd_net -net Net [get_bd_ports CLK] [get_bd_pins ADD/aclk] [get_bd_pins IM_SQUARE/aclk] [get_bd_pins RE_SQUARE/aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins comparator_0/CLK] [get_bd_pins frequency_finder_0/CLK] [get_bd_pins thresholding_0/CLK]
  connect_bd_net -net Net1 [get_bd_ports RE_INPUT] [get_bd_pins RE_SQUARE/s_axis_a_tdata] [get_bd_pins RE_SQUARE/s_axis_b_tdata]
  connect_bd_net -net Net2 [get_bd_ports RE_VALID] [get_bd_pins RE_SQUARE/s_axis_a_tvalid] [get_bd_pins RE_SQUARE/s_axis_b_tvalid]
  connect_bd_net -net Net3 [get_bd_ports IM_INPUT] [get_bd_pins IM_SQUARE/s_axis_a_tdata] [get_bd_pins IM_SQUARE/s_axis_b_tdata]
  connect_bd_net -net Net4 [get_bd_ports IM_VALID] [get_bd_pins IM_SQUARE/s_axis_a_tvalid] [get_bd_pins IM_SQUARE/s_axis_b_tvalid]
  connect_bd_net -net Net5 [get_bd_ports RESET] [get_bd_pins comparator_0/RESET] [get_bd_pins frequency_finder_0/RESET] [get_bd_pins thresholding_0/RESET]
  connect_bd_net -net axis_data_fifo_0_m_axis_tdata [get_bd_pins axis_data_fifo_0/m_axis_tdata] [get_bd_pins comparator_0/S_AXIS_FIFO_TDATA]
  connect_bd_net -net axis_data_fifo_0_m_axis_tvalid [get_bd_pins axis_data_fifo_0/m_axis_tvalid] [get_bd_pins comparator_0/S_AXIS_FIFO_TVALID]
  connect_bd_net -net comparator_0_M_AXIS_COUNTER [get_bd_pins comparator_0/M_AXIS_COUNTER] [get_bd_pins thresholding_0/S_AXIS_TDATA]
  connect_bd_net -net comparator_0_M_AXIS_TVALID [get_bd_pins comparator_0/M_AXIS_TVALID] [get_bd_pins thresholding_0/S_AXIS_TVALID]
  connect_bd_net -net comparator_0_S_AXIS_FIFO_TREADY [get_bd_pins axis_data_fifo_0/m_axis_tready] [get_bd_pins comparator_0/S_AXIS_FIFO_TREADY]
  connect_bd_net -net frequency_finder_0_M_AXIS_FIFO_RESET [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins frequency_finder_0/M_AXIS_FIFO_RESET]
  connect_bd_net -net frequency_finder_0_M_AXIS_TDATA [get_bd_pins comparator_0/S_AXIS_FREQ_FINDER_FREQ_AMP] [get_bd_pins frequency_finder_0/M_AXIS_TDATA]
  connect_bd_net -net frequency_finder_0_M_AXIS_TVALID [get_bd_pins comparator_0/S_AXIS_FREQ_FINDER_TVALID] [get_bd_pins frequency_finder_0/M_AXIS_TVALID]
  connect_bd_net -net frequency_finder_0_VALID_FREQ [get_bd_pins comparator_0/S_AXIS_FREQ_FINDER_FREQ_BIN] [get_bd_pins frequency_finder_0/VALID_FREQ]
  connect_bd_net -net thresholding_0_M_AXIS_TDATA [get_bd_ports BIN_DETECTED] [get_bd_pins thresholding_0/M_AXIS_TDATA]
  connect_bd_net -net thresholding_0_M_AXIS_TVALID [get_bd_ports BIN_DETECTED_VALID] [get_bd_pins thresholding_0/M_AXIS_TVALID]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_design_2()
cr_bd_design_2 ""
set_property REGISTERED_WITH_MANAGER "1" [get_files design_2.bd ] 
set_property SYNTH_CHECKPOINT_MODE "Hierarchical" [get_files design_2.bd ] 

if { [get_files rising_edge_bram.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/rising_edge_bram.vhd
}
if { [get_files lwr_wnd_sum.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/lwr_wnd_sum.vhd
}
if { [get_files upper_wnd_sum.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/upper_wnd_sum.vhd
}
if { [get_files compare.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/compare.vhd
}
if { [get_files rising_edge_bram.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/rising_edge_bram.vhd
}
if { [get_files lwr_wnd_sum.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/lwr_wnd_sum.vhd
}
if { [get_files upper_wnd_sum.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/upper_wnd_sum.vhd
}
if { [get_files compare.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/compare.vhd
}


# Proc to create BD design_4
proc cr_bd_design_4 { parentCell } {
# The design that will be created by this Tcl proc contains the following 
# module references:
# compare, lwr_wnd_sum, rising_edge_bram, upper_wnd_sum



  # CHANGE DESIGN NAME HERE
  set design_name design_4

  common::send_gid_msg -ssname BD::TCL -id 2010 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:ip:floating_point:7.1\
  xilinx.com:ip:blk_mem_gen:8.4\
  "

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  ##################################################################
  # CHECK Modules
  ##################################################################
  set bCheckModules 1
  if { $bCheckModules == 1 } {
     set list_check_mods "\ 
  compare\
  lwr_wnd_sum\
  rising_edge_bram\
  upper_wnd_sum\
  "

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

  if { $bCheckIPsPassed != 1 } {
    common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set CLK [ create_bd_port -dir I -type clk -freq_hz 10000000 CLK ]
  set INDEX [ create_bd_port -dir O -from 31 -to 0 INDEX ]
  set INDEX_VALID [ create_bd_port -dir O INDEX_VALID ]
  set INP_DATA [ create_bd_port -dir I -from 31 -to 0 INP_DATA ]
  set INP_VALID [ create_bd_port -dir I INP_VALID ]

  # Create instance: ABSOLUTE_VALUE, and set properties
  set ABSOLUTE_VALUE [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 ABSOLUTE_VALUE ]
  set_property -dict [ list \
   CONFIG.C_Latency {0} \
   CONFIG.C_Mult_Usage {No_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Operation_Type {Absolute} \
   CONFIG.Result_Precision_Type {Single} \
 ] $ABSOLUTE_VALUE

  # Create instance: DIVIDE, and set properties
  set DIVIDE [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 DIVIDE ]
  set_property -dict [ list \
   CONFIG.C_Latency {29} \
   CONFIG.C_Mult_Usage {No_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_RESULT_TREADY {false} \
   CONFIG.Operation_Type {Divide} \
   CONFIG.Result_Precision_Type {Single} \
 ] $DIVIDE

  # Create instance: FIXED_TO_FLOAT, and set properties
  set FIXED_TO_FLOAT [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 FIXED_TO_FLOAT ]
  set_property -dict [ list \
   CONFIG.C_Accum_Input_Msb {32} \
   CONFIG.C_Accum_Lsb {-31} \
   CONFIG.C_Accum_Msb {32} \
   CONFIG.C_Latency {7} \
   CONFIG.C_Mult_Usage {No_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Operation_Type {Fixed_to_float} \
   CONFIG.Result_Precision_Type {Single} \
 ] $FIXED_TO_FLOAT

  # Create instance: FIXED_TO_FLOAT1, and set properties
  set FIXED_TO_FLOAT1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 FIXED_TO_FLOAT1 ]
  set_property -dict [ list \
   CONFIG.C_Accum_Input_Msb {32} \
   CONFIG.C_Accum_Lsb {-31} \
   CONFIG.C_Accum_Msb {32} \
   CONFIG.C_Latency {7} \
   CONFIG.C_Mult_Usage {No_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Operation_Type {Fixed_to_float} \
   CONFIG.Result_Precision_Type {Single} \
 ] $FIXED_TO_FLOAT1

  # Create instance: FLOAT_TO_FIX, and set properties
  set FLOAT_TO_FIX [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 FLOAT_TO_FIX ]
  set_property -dict [ list \
   CONFIG.C_Latency {7} \
   CONFIG.C_Mult_Usage {No_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {32} \
   CONFIG.C_Result_Fraction_Width {0} \
   CONFIG.Operation_Type {Float_to_fixed} \
   CONFIG.Result_Precision_Type {Int32} \
 ] $FLOAT_TO_FIX

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0 ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {true} \
   CONFIG.Byte_Size {9} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_A {Always_Enabled} \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {Simple_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {NO_CHANGE} \
   CONFIG.Operating_Mode_B {READ_FIRST} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Write_Depth_A {4096} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_0

  # Create instance: blk_mem_gen_1, and set properties
  set blk_mem_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_1 ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {true} \
   CONFIG.Byte_Size {9} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_A {Always_Enabled} \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {Simple_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {NO_CHANGE} \
   CONFIG.Operating_Mode_B {READ_FIRST} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Write_Depth_A {4096} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_1

  # Create instance: compare_0, and set properties
  set block_name compare
  set block_cell_name compare_0
  if { [catch {set compare_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $compare_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: lwr_wnd_sum_0, and set properties
  set block_name lwr_wnd_sum
  set block_cell_name lwr_wnd_sum_0
  if { [catch {set lwr_wnd_sum_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $lwr_wnd_sum_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: rising_edge_bram_0, and set properties
  set block_name rising_edge_bram
  set block_cell_name rising_edge_bram_0
  if { [catch {set rising_edge_bram_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $rising_edge_bram_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: upper_wnd_sum_0, and set properties
  set block_name upper_wnd_sum
  set block_cell_name upper_wnd_sum_0
  if { [catch {set upper_wnd_sum_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $upper_wnd_sum_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create interface connections
  connect_bd_intf_net -intf_net FIXED_TO_FLOAT1_M_AXIS_RESULT [get_bd_intf_pins DIVIDE/S_AXIS_B] [get_bd_intf_pins FIXED_TO_FLOAT1/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net FIXED_TO_FLOAT_M_AXIS_RESULT [get_bd_intf_pins DIVIDE/S_AXIS_A] [get_bd_intf_pins FIXED_TO_FLOAT/M_AXIS_RESULT]

  # Create port connections
  connect_bd_net -net ABSOLUTE_VALUE_m_axis_result_tdata [get_bd_pins ABSOLUTE_VALUE/m_axis_result_tdata] [get_bd_pins FLOAT_TO_FIX/s_axis_a_tdata]
  connect_bd_net -net ABSOLUTE_VALUE_m_axis_result_tvalid [get_bd_pins ABSOLUTE_VALUE/m_axis_result_tvalid] [get_bd_pins FLOAT_TO_FIX/s_axis_a_tvalid]
  connect_bd_net -net DIVIDE_m_axis_result_tdata [get_bd_pins DIVIDE/m_axis_result_tdata] [get_bd_pins compare_0/S_AXIS_TDATA]
  connect_bd_net -net DIVIDE_m_axis_result_tvalid [get_bd_pins DIVIDE/m_axis_result_tvalid] [get_bd_pins compare_0/S_AXIS_TVALID]
  connect_bd_net -net FLOAT_TO_FIX_m_axis_result_tdata [get_bd_pins FLOAT_TO_FIX/m_axis_result_tdata] [get_bd_pins rising_edge_bram_0/S_AXIS_TDATA]
  connect_bd_net -net FLOAT_TO_FIX_m_axis_result_tvalid [get_bd_pins FLOAT_TO_FIX/m_axis_result_tvalid] [get_bd_pins rising_edge_bram_0/S_AXIS_TVALID]
  connect_bd_net -net FLOAT_TO_FIX_s_axis_a_tready [get_bd_pins ABSOLUTE_VALUE/m_axis_result_tready] [get_bd_pins FLOAT_TO_FIX/s_axis_a_tready]
  connect_bd_net -net INP_DATA_1 [get_bd_ports INP_DATA] [get_bd_pins ABSOLUTE_VALUE/s_axis_a_tdata]
  connect_bd_net -net INP_VALID_1 [get_bd_ports INP_VALID] [get_bd_pins ABSOLUTE_VALUE/s_axis_a_tvalid]
  connect_bd_net -net Net [get_bd_ports CLK] [get_bd_pins DIVIDE/aclk] [get_bd_pins FIXED_TO_FLOAT/aclk] [get_bd_pins FIXED_TO_FLOAT1/aclk] [get_bd_pins FLOAT_TO_FIX/aclk] [get_bd_pins blk_mem_gen_0/clka] [get_bd_pins blk_mem_gen_0/clkb] [get_bd_pins blk_mem_gen_1/clka] [get_bd_pins blk_mem_gen_1/clkb] [get_bd_pins compare_0/CLK] [get_bd_pins lwr_wnd_sum_0/CLK] [get_bd_pins rising_edge_bram_0/CLK] [get_bd_pins upper_wnd_sum_0/CLK]
  connect_bd_net -net blk_mem_gen_0_doutb [get_bd_pins blk_mem_gen_0/doutb] [get_bd_pins lwr_wnd_sum_0/S_AXIS_TDATA]
  connect_bd_net -net blk_mem_gen_1_doutb [get_bd_pins blk_mem_gen_1/doutb] [get_bd_pins upper_wnd_sum_0/S_AXIS_TDATA]
  connect_bd_net -net compare_0_M_AXIS_TDATA [get_bd_ports INDEX] [get_bd_pins compare_0/M_AXIS_TDATA]
  connect_bd_net -net compare_0_M_AXIS_TVALID [get_bd_ports INDEX_VALID] [get_bd_pins compare_0/M_AXIS_TVALID]
  connect_bd_net -net lwr_wnd_sum_0_M_AXIS_TDATA [get_bd_pins FIXED_TO_FLOAT1/s_axis_a_tdata] [get_bd_pins lwr_wnd_sum_0/M_AXIS_TDATA]
  connect_bd_net -net lwr_wnd_sum_0_M_AXIS_TVALID [get_bd_pins FIXED_TO_FLOAT1/s_axis_a_tvalid] [get_bd_pins lwr_wnd_sum_0/M_AXIS_TVALID]
  connect_bd_net -net lwr_wnd_sum_0_S_AXIS_ENB [get_bd_pins blk_mem_gen_0/enb] [get_bd_pins lwr_wnd_sum_0/S_AXIS_ENB]
  connect_bd_net -net lwr_wnd_sum_0_S_AXIS_TADDR [get_bd_pins blk_mem_gen_0/addrb] [get_bd_pins lwr_wnd_sum_0/S_AXIS_TADDR]
  connect_bd_net -net rising_edge_bram_0_ADDRA [get_bd_pins blk_mem_gen_0/addra] [get_bd_pins blk_mem_gen_1/addra] [get_bd_pins rising_edge_bram_0/ADDRA]
  connect_bd_net -net rising_edge_bram_0_DINA [get_bd_pins blk_mem_gen_0/dina] [get_bd_pins blk_mem_gen_1/dina] [get_bd_pins rising_edge_bram_0/DINA]
  connect_bd_net -net rising_edge_bram_0_INIT_LWR_SUM [get_bd_pins lwr_wnd_sum_0/S_AXIS_INIT_LWR_WND] [get_bd_pins rising_edge_bram_0/INIT_LWR_SUM]
  connect_bd_net -net rising_edge_bram_0_INIT_UPPR_SUM [get_bd_pins rising_edge_bram_0/INIT_UPPR_SUM] [get_bd_pins upper_wnd_sum_0/S_AXIS_INIT_UPPR_WND]
  connect_bd_net -net rising_edge_bram_0_M_AXIS_SUM_TVALID [get_bd_pins lwr_wnd_sum_0/S_AXIS_SUM_TVALID] [get_bd_pins rising_edge_bram_0/M_AXIS_SUM_TVALID] [get_bd_pins upper_wnd_sum_0/S_AXIS_SUM_TVALID]
  connect_bd_net -net rising_edge_bram_0_S_AXIS_TREADY [get_bd_pins FLOAT_TO_FIX/m_axis_result_tready] [get_bd_pins rising_edge_bram_0/S_AXIS_TREADY]
  connect_bd_net -net rising_edge_bram_0_WEA [get_bd_pins blk_mem_gen_0/wea] [get_bd_pins blk_mem_gen_1/wea] [get_bd_pins rising_edge_bram_0/WEA]
  connect_bd_net -net upper_wnd_sum_0_M_AXIS_TDATA [get_bd_pins FIXED_TO_FLOAT/s_axis_a_tdata] [get_bd_pins upper_wnd_sum_0/M_AXIS_TDATA]
  connect_bd_net -net upper_wnd_sum_0_M_AXIS_TVALID [get_bd_pins FIXED_TO_FLOAT/s_axis_a_tvalid] [get_bd_pins upper_wnd_sum_0/M_AXIS_TVALID]
  connect_bd_net -net upper_wnd_sum_0_S_AXIS_ENB [get_bd_pins blk_mem_gen_1/enb] [get_bd_pins upper_wnd_sum_0/S_AXIS_ENB]
  connect_bd_net -net upper_wnd_sum_0_S_AXIS_TADDR [get_bd_pins blk_mem_gen_1/addrb] [get_bd_pins upper_wnd_sum_0/S_AXIS_TADDR]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_design_4()
cr_bd_design_4 ""
set_property REGISTERED_WITH_MANAGER "1" [get_files design_4.bd ] 
set_property SYNTH_CHECKPOINT_MODE "Hierarchical" [get_files design_4.bd ] 

if { [get_files rising_edge_bram.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/rising_edge_bram.vhd
}
if { [get_files lwr_wnd_sum.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/lwr_wnd_sum.vhd
}
if { [get_files upper_wnd_sum.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/upper_wnd_sum.vhd
}
if { [get_files compare.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/compare.vhd
}
if { [get_files corr_sine_bram.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/corr_sine_bram.vhd
}
if { [get_files corr_sine_bram.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/corr_sine_bram.vhd
}


# Proc to create BD design_3
proc cr_bd_design_3 { parentCell } {
# The design that will be created by this Tcl proc contains the following 
# module references:
# corr_sine_bram



  # CHANGE DESIGN NAME HERE
  set design_name design_3

  common::send_gid_msg -ssname BD::TCL -id 2010 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:ip:floating_point:7.1\
  xilinx.com:ip:blk_mem_gen:8.4\
  "

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  ##################################################################
  # CHECK Modules
  ##################################################################
  set bCheckModules 1
  if { $bCheckModules == 1 } {
     set list_check_mods "\ 
  corr_sine_bram\
  "

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

  if { $bCheckIPsPassed != 1 } {
    common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set CLK [ create_bd_port -dir I -type clk -freq_hz 100000000 CLK ]
  set CORR_IMAG [ create_bd_port -dir O -from 31 -to 0 CORR_IMAG ]
  set CORR_REAL [ create_bd_port -dir O -from 31 -to 0 CORR_REAL ]
  set CORR_VALID [ create_bd_port -dir O CORR_VALID ]
  set INPUT_IMAG [ create_bd_port -dir I -from 31 -to 0 INPUT_IMAG ]
  set INPUT_REAL [ create_bd_port -dir I -from 31 -to 0 INPUT_REAL ]
  set INP_VALID [ create_bd_port -dir I INP_VALID ]

  # Create instance: ADD, and set properties
  set ADD [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 ADD ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Add} \
   CONFIG.C_Latency {12} \
   CONFIG.Has_RESULT_TREADY {false} \
 ] $ADD

  # Create instance: AX, and set properties
  set AX [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 AX ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_RESULT_TREADY {false} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $AX

  # Create instance: AY, and set properties
  set AY [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 AY ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_RESULT_TREADY {false} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $AY

  # Create instance: BX, and set properties
  set BX [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 BX ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_RESULT_TREADY {false} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $BX

  # Create instance: BY, and set properties
  set BY [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 BY ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_RESULT_TREADY {false} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $BY

  # Create instance: SINE_IMAG, and set properties
  set SINE_IMAG [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 SINE_IMAG ]
  set_property -dict [ list \
   CONFIG.Byte_Size {9} \
   CONFIG.Coe_File {hdl/sine_img.coe} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_A {Always_Enabled} \
   CONFIG.Load_Init_File {true} \
   CONFIG.Memory_Type {Single_Port_ROM} \
   CONFIG.Port_A_Write_Rate {0} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Write_Depth_A {4096} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $SINE_IMAG

  # Create instance: SINE_REAL, and set properties
  set SINE_REAL [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 SINE_REAL ]
  set_property -dict [ list \
   CONFIG.Byte_Size {9} \
   CONFIG.Coe_File {hdl/sine_real.coe} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_A {Always_Enabled} \
   CONFIG.Load_Init_File {true} \
   CONFIG.Memory_Type {Single_Port_ROM} \
   CONFIG.Port_A_Write_Rate {0} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Write_Depth_A {4096} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $SINE_REAL

  # Create instance: SUBTRACT, and set properties
  set SUBTRACT [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 SUBTRACT ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Subtract} \
   CONFIG.C_Latency {12} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_RESULT_TREADY {false} \
   CONFIG.Operation_Type {Add_Subtract} \
   CONFIG.Result_Precision_Type {Single} \
 ] $SUBTRACT

  # Create instance: corr_sine_bram_0, and set properties
  set block_name corr_sine_bram
  set block_cell_name corr_sine_bram_0
  if { [catch {set corr_sine_bram_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $corr_sine_bram_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create interface connections
  connect_bd_intf_net -intf_net AX_M_AXIS_RESULT [get_bd_intf_pins AX/M_AXIS_RESULT] [get_bd_intf_pins SUBTRACT/S_AXIS_A]
  connect_bd_intf_net -intf_net AY_M_AXIS_RESULT [get_bd_intf_pins ADD/S_AXIS_A] [get_bd_intf_pins AY/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net BX_M_AXIS_RESULT [get_bd_intf_pins ADD/S_AXIS_B] [get_bd_intf_pins BX/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net BY_M_AXIS_RESULT [get_bd_intf_pins BY/M_AXIS_RESULT] [get_bd_intf_pins SUBTRACT/S_AXIS_B]

  # Create port connections
  connect_bd_net -net ADD_m_axis_result_tdata [get_bd_ports CORR_IMAG] [get_bd_pins ADD/m_axis_result_tdata]
  connect_bd_net -net INPUT_IMAG_1 [get_bd_ports INPUT_IMAG] [get_bd_pins corr_sine_bram_0/INPUT_IMAG]
  connect_bd_net -net INPUT_REAL_1 [get_bd_ports INPUT_REAL] [get_bd_pins corr_sine_bram_0/INPUT_REAL]
  connect_bd_net -net INP_VALID_1 [get_bd_ports INP_VALID] [get_bd_pins corr_sine_bram_0/INP_VALID]
  connect_bd_net -net Net [get_bd_pins AX/s_axis_a_tvalid] [get_bd_pins AX/s_axis_b_tvalid] [get_bd_pins AY/s_axis_a_tvalid] [get_bd_pins AY/s_axis_b_tvalid] [get_bd_pins BX/s_axis_a_tvalid] [get_bd_pins BX/s_axis_b_tvalid] [get_bd_pins BY/s_axis_a_tvalid] [get_bd_pins BY/s_axis_b_tvalid] [get_bd_pins corr_sine_bram_0/DATA_OUT_VALID]
  connect_bd_net -net Net1 [get_bd_ports CLK] [get_bd_pins ADD/aclk] [get_bd_pins AX/aclk] [get_bd_pins AY/aclk] [get_bd_pins BX/aclk] [get_bd_pins BY/aclk] [get_bd_pins SINE_IMAG/clka] [get_bd_pins SINE_REAL/clka] [get_bd_pins SUBTRACT/aclk] [get_bd_pins corr_sine_bram_0/CLK]
  connect_bd_net -net SINE_IMAG_douta [get_bd_pins SINE_IMAG/douta] [get_bd_pins corr_sine_bram_0/SINE_IN_IMG]
  connect_bd_net -net SINE_REAL_douta [get_bd_pins SINE_REAL/douta] [get_bd_pins corr_sine_bram_0/SINE_IN_REAL]
  connect_bd_net -net SUBTRACT_m_axis_result_tdata [get_bd_ports CORR_REAL] [get_bd_pins SUBTRACT/m_axis_result_tdata]
  connect_bd_net -net SUBTRACT_m_axis_result_tvalid [get_bd_ports CORR_VALID] [get_bd_pins SUBTRACT/m_axis_result_tvalid]
  connect_bd_net -net corr_sine_bram_0_ADDR [get_bd_pins SINE_IMAG/addra] [get_bd_pins SINE_REAL/addra] [get_bd_pins corr_sine_bram_0/ADDR]
  connect_bd_net -net corr_sine_bram_0_CORR_OUT_IMG [get_bd_pins AY/s_axis_b_tdata] [get_bd_pins BY/s_axis_b_tdata] [get_bd_pins corr_sine_bram_0/CORR_OUT_IMG]
  connect_bd_net -net corr_sine_bram_0_CORR_OUT_REAL [get_bd_pins AX/s_axis_b_tdata] [get_bd_pins BX/s_axis_b_tdata] [get_bd_pins corr_sine_bram_0/CORR_OUT_REAL]
  connect_bd_net -net corr_sine_bram_0_INP_IMG [get_bd_pins BX/s_axis_a_tdata] [get_bd_pins BY/s_axis_a_tdata] [get_bd_pins corr_sine_bram_0/INP_IMG]
  connect_bd_net -net corr_sine_bram_0_INP_REAL [get_bd_pins AX/s_axis_a_tdata] [get_bd_pins AY/s_axis_a_tdata] [get_bd_pins corr_sine_bram_0/INP_REAL]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_design_3()
cr_bd_design_3 ""
set_property REGISTERED_WITH_MANAGER "1" [get_files design_3.bd ] 
set_property SYNTH_CHECKPOINT_MODE "Hierarchical" [get_files design_3.bd ] 

if { [get_files hyd1_bram.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/hyd1_bram.vhd
}
if { [get_files hyd1_bram.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/hyd1_bram.vhd
}


# Proc to create BD design_5
proc cr_bd_design_5 { parentCell } {
# The design that will be created by this Tcl proc contains the following 
# module references:
# hyd1_bram



  # CHANGE DESIGN NAME HERE
  set design_name design_5

  common::send_gid_msg -ssname BD::TCL -id 2010 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:ip:blk_mem_gen:8.4\
  "

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  ##################################################################
  # CHECK Modules
  ##################################################################
  set bCheckModules 1
  if { $bCheckModules == 1 } {
     set list_check_mods "\ 
  hyd1_bram\
  "

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

  if { $bCheckIPsPassed != 1 } {
    common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set ADDR [ create_bd_port -dir I -from 11 -to 0 ADDR ]
  set CLK [ create_bd_port -dir I -type clk -freq_hz 100000000 CLK ]
  set HYD1_IMAG_OUT [ create_bd_port -dir O -from 31 -to 0 HYD1_IMAG_OUT ]
  set HYD1_REAL_OUT [ create_bd_port -dir O -from 31 -to 0 HYD1_REAL_OUT ]
  set INP_IMAG [ create_bd_port -dir I -from 31 -to 0 INP_IMAG ]
  set INP_REAL [ create_bd_port -dir I -from 31 -to 0 INP_REAL ]
  set INP_VALID [ create_bd_port -dir I INP_VALID ]

  # Create instance: HYD1_IMAG, and set properties
  set HYD1_IMAG [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 HYD1_IMAG ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {true} \
   CONFIG.Byte_Size {9} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_A {Always_Enabled} \
   CONFIG.Enable_B {Always_Enabled} \
   CONFIG.Memory_Type {Simple_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {NO_CHANGE} \
   CONFIG.Operating_Mode_B {READ_FIRST} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {true} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Write_Depth_A {4096} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $HYD1_IMAG

  # Create instance: HYD1_REAL, and set properties
  set HYD1_REAL [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 HYD1_REAL ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {true} \
   CONFIG.Byte_Size {9} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_A {Always_Enabled} \
   CONFIG.Enable_B {Always_Enabled} \
   CONFIG.Memory_Type {Simple_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {NO_CHANGE} \
   CONFIG.Operating_Mode_B {READ_FIRST} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {true} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Write_Depth_A {4096} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $HYD1_REAL

  # Create instance: hyd1_bram_0, and set properties
  set block_name hyd1_bram
  set block_cell_name hyd1_bram_0
  if { [catch {set hyd1_bram_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $hyd1_bram_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net HYD1_IMAG_doutb [get_bd_ports HYD1_IMAG_OUT] [get_bd_pins HYD1_IMAG/doutb]
  connect_bd_net -net HYD1_REAL_doutb [get_bd_ports HYD1_REAL_OUT] [get_bd_pins HYD1_REAL/doutb]
  connect_bd_net -net INP_IMAG_1 [get_bd_ports INP_IMAG] [get_bd_pins hyd1_bram_0/INP_IMAG]
  connect_bd_net -net INP_REAL_1 [get_bd_ports INP_REAL] [get_bd_pins hyd1_bram_0/INP_REAL]
  connect_bd_net -net INP_VALID_1 [get_bd_ports INP_VALID] [get_bd_pins hyd1_bram_0/INP_VALID]
  connect_bd_net -net Net [get_bd_ports CLK] [get_bd_pins HYD1_IMAG/clka] [get_bd_pins HYD1_IMAG/clkb] [get_bd_pins HYD1_REAL/clka] [get_bd_pins HYD1_REAL/clkb] [get_bd_pins hyd1_bram_0/CLK]
  connect_bd_net -net Net1 [get_bd_ports ADDR] [get_bd_pins HYD1_IMAG/addrb] [get_bd_pins HYD1_REAL/addrb]
  connect_bd_net -net hyd1_bram_0_ADDR [get_bd_pins HYD1_IMAG/addra] [get_bd_pins HYD1_REAL/addra] [get_bd_pins hyd1_bram_0/ADDR]
  connect_bd_net -net hyd1_bram_0_DATA_OUT_IMG [get_bd_pins HYD1_IMAG/dina] [get_bd_pins hyd1_bram_0/DATA_OUT_IMG]
  connect_bd_net -net hyd1_bram_0_DATA_OUT_REAL [get_bd_pins HYD1_REAL/dina] [get_bd_pins hyd1_bram_0/DATA_OUT_REAL]
  connect_bd_net -net hyd1_bram_0_WEA [get_bd_pins HYD1_IMAG/wea] [get_bd_pins HYD1_REAL/wea] [get_bd_pins hyd1_bram_0/WEA]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_design_5()
cr_bd_design_5 ""
set_property REGISTERED_WITH_MANAGER "1" [get_files design_5.bd ] 
set_property SYNTH_CHECKPOINT_MODE "Hierarchical" [get_files design_5.bd ] 

if { [get_files write_to_bram.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/write_to_bram.vhd
}
if { [get_files delay_by_1.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/delay_by_1.vhd
}
if { [get_files write_to_bram.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/write_to_bram.vhd
}
if { [get_files delay_by_1.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/delay_by_1.vhd
}
if { [get_files delay_by_1.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/delay_by_1.vhd
}
if { [get_files read_from_bram.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/read_from_bram.vhd
}
if { [get_files delay_by_1.vhd] == "" } {
  import_files -quiet -fileset sources_1 hdl/delay_by_1.vhd
}


# Proc to create BD design_1
proc cr_bd_design_1 { parentCell } {
# The design that will be created by this Tcl proc contains the following 
# module references:
# delay_by_1, delay_by_1, delay_by_1, delay_by_1, read_from_bram, write_to_bram, write_to_bram


# The design that will be created by this Tcl proc contains the following 
# block design container source references:
# design_2, design_6, design_3, design_5, design_4



  # CHANGE DESIGN NAME HERE
  set design_name design_1

  common::send_gid_msg -ssname BD::TCL -id 2010 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:ip:blk_mem_gen:8.4\
  xilinx.com:ip:xlconstant:1.1\
  "

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  ##################################################################
  # CHECK Modules
  ##################################################################
  set bCheckModules 1
  if { $bCheckModules == 1 } {
     set list_check_mods "\ 
  delay_by_1\
  delay_by_1\
  delay_by_1\
  delay_by_1\
  read_from_bram\
  write_to_bram\
  write_to_bram\
  "

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

  ##################################################################
  # CHECK Block Design Container Sources
  ##################################################################
  set bCheckSources 1
  set list_bdc_active "design_2, design_6, design_3, design_5, design_4"

  array set map_bdc_missing {}
  set map_bdc_missing(ACTIVE) ""
  set map_bdc_missing(BDC) ""

  if { $bCheckSources == 1 } {
     set list_check_srcs "\ 
  design_2 \
  design_6 \
  design_3 \
  design_5 \
  design_4 \
  "

   common::send_gid_msg -ssname BD::TCL -id 2056 -severity "INFO" "Checking if the following sources for block design container exist in the project: $list_check_srcs .\n\n"

   foreach src $list_check_srcs {
      if { [can_resolve_reference $src] == 0 } {
         if { [lsearch $list_bdc_active $src] != -1 } {
            set map_bdc_missing(ACTIVE) "$map_bdc_missing(ACTIVE) $src"
         } else {
            set map_bdc_missing(BDC) "$map_bdc_missing(BDC) $src"
         }
      }
   }

   if { [llength $map_bdc_missing(ACTIVE)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2057 -severity "ERROR" "The following source(s) of Active variants are not found in the project: $map_bdc_missing(ACTIVE)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
      set bCheckIPsPassed 0
   }
   if { [llength $map_bdc_missing(BDC)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2059 -severity "WARNING" "The following source(s) of variants are not found in the project: $map_bdc_missing(BDC)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
   }
}

  if { $bCheckIPsPassed != 1 } {
    common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set CLK [ create_bd_port -dir I -type clk -freq_hz 100000000 CLK ]
  set IM_DATA [ create_bd_port -dir I -from 31 -to 0 IM_DATA ]
  set INDEX [ create_bd_port -dir O -from 31 -to 0 INDEX ]
  set INDEX_VALID [ create_bd_port -dir O INDEX_VALID ]
  set RE_DATA [ create_bd_port -dir I -from 31 -to 0 RE_DATA ]
  set RE_VALID [ create_bd_port -dir I RE_VALID ]

  # Create instance: BIN_DETECTION, and set properties
  set BIN_DETECTION [ create_bd_cell -type container -reference design_2 BIN_DETECTION ]
  set_property -dict [ list \
   CONFIG.ACTIVE_SIM_BD {design_2.bd} \
   CONFIG.ACTIVE_SYNTH_BD {design_2.bd} \
   CONFIG.ENABLE_DFX {0} \
   CONFIG.LIST_SIM_BD {design_2.bd} \
   CONFIG.LIST_SYNTH_BD {design_2.bd} \
   CONFIG.LOCK_PROPAGATE {0} \
 ] $BIN_DETECTION

  # Create instance: CORRELATION_HYD1, and set properties
  set CORRELATION_HYD1 [ create_bd_cell -type container -reference design_6 CORRELATION_HYD1 ]
  set_property -dict [ list \
   CONFIG.ACTIVE_SIM_BD {design_6.bd} \
   CONFIG.ACTIVE_SYNTH_BD {design_6.bd} \
   CONFIG.ENABLE_DFX {0} \
   CONFIG.LIST_SIM_BD {design_6.bd} \
   CONFIG.LIST_SYNTH_BD {design_6.bd} \
   CONFIG.LOCK_PROPAGATE {0} \
 ] $CORRELATION_HYD1

  # Create instance: CORRELATION_SINE, and set properties
  set CORRELATION_SINE [ create_bd_cell -type container -reference design_3 CORRELATION_SINE ]
  set_property -dict [ list \
   CONFIG.ACTIVE_SIM_BD {design_3.bd} \
   CONFIG.ACTIVE_SYNTH_BD {design_3.bd} \
   CONFIG.ENABLE_DFX {0} \
   CONFIG.LIST_SIM_BD {design_3.bd} \
   CONFIG.LIST_SYNTH_BD {design_3.bd} \
   CONFIG.LOCK_PROPAGATE {0} \
 ] $CORRELATION_SINE

  # Create instance: HYD1_STORE_DATA, and set properties
  set HYD1_STORE_DATA [ create_bd_cell -type container -reference design_5 HYD1_STORE_DATA ]
  set_property -dict [ list \
   CONFIG.ACTIVE_SIM_BD {design_5.bd} \
   CONFIG.ACTIVE_SYNTH_BD {design_5.bd} \
   CONFIG.ENABLE_DFX {0} \
   CONFIG.LIST_SIM_BD {design_5.bd} \
   CONFIG.LIST_SYNTH_BD {design_5.bd} \
   CONFIG.LOCK_PROPAGATE {0} \
 ] $HYD1_STORE_DATA

  # Create instance: RISING_EDGE, and set properties
  set RISING_EDGE [ create_bd_cell -type container -reference design_4 RISING_EDGE ]
  set_property -dict [ list \
   CONFIG.ACTIVE_SIM_BD {design_4.bd} \
   CONFIG.ACTIVE_SYNTH_BD {design_4.bd} \
   CONFIG.ENABLE_DFX {0} \
   CONFIG.LIST_SIM_BD {design_4.bd} \
   CONFIG.LIST_SYNTH_BD {design_4.bd} \
   CONFIG.LOCK_PROPAGATE {0} \
 ] $RISING_EDGE

  # Create instance: RSING_EDGE_1, and set properties
  set RSING_EDGE_1 [ create_bd_cell -type container -reference design_4 RSING_EDGE_1 ]
  set_property -dict [ list \
   CONFIG.ACTIVE_SIM_BD {design_4.bd} \
   CONFIG.ACTIVE_SYNTH_BD {design_4.bd} \
   CONFIG.ENABLE_DFX {0} \
   CONFIG.LIST_SIM_BD {design_4.bd} \
   CONFIG.LIST_SYNTH_BD {design_4.bd} \
   CONFIG.LOCK_PROPAGATE {0} \
 ] $RSING_EDGE_1

  # Create instance: STORE_IMAG, and set properties
  set STORE_IMAG [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 STORE_IMAG ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {true} \
   CONFIG.Byte_Size {9} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_A {Always_Enabled} \
   CONFIG.Enable_B {Always_Enabled} \
   CONFIG.Memory_Type {Simple_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {NO_CHANGE} \
   CONFIG.Operating_Mode_B {READ_FIRST} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {0} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Use_RSTB_Pin {false} \
   CONFIG.Write_Depth_A {4096} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $STORE_IMAG

  # Create instance: STORE_REAL, and set properties
  set STORE_REAL [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 STORE_REAL ]
  set_property -dict [ list \
   CONFIG.Assume_Synchronous_Clk {true} \
   CONFIG.Byte_Size {9} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_A {Always_Enabled} \
   CONFIG.Enable_B {Always_Enabled} \
   CONFIG.Memory_Type {Simple_Dual_Port_RAM} \
   CONFIG.Operating_Mode_A {NO_CHANGE} \
   CONFIG.Operating_Mode_B {READ_FIRST} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {0} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Use_RSTB_Pin {false} \
   CONFIG.Write_Depth_A {4096} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $STORE_REAL

  # Create instance: delay_by_1_0, and set properties
  set block_name delay_by_1
  set block_cell_name delay_by_1_0
  if { [catch {set delay_by_1_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $delay_by_1_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: delay_by_1_1, and set properties
  set block_name delay_by_1
  set block_cell_name delay_by_1_1
  if { [catch {set delay_by_1_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $delay_by_1_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: delay_by_1_2, and set properties
  set block_name delay_by_1
  set block_cell_name delay_by_1_2
  if { [catch {set delay_by_1_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $delay_by_1_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: delay_by_1_3, and set properties
  set block_name delay_by_1
  set block_cell_name delay_by_1_3
  if { [catch {set delay_by_1_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $delay_by_1_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: read_from_bram_real, and set properties
  set block_name read_from_bram
  set block_cell_name read_from_bram_real
  if { [catch {set read_from_bram_real [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $read_from_bram_real eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: write_to_bram_imag, and set properties
  set block_name write_to_bram
  set block_cell_name write_to_bram_imag
  if { [catch {set write_to_bram_imag [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $write_to_bram_imag eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: write_to_bram_real, and set properties
  set block_name write_to_bram
  set block_cell_name write_to_bram_real
  if { [catch {set write_to_bram_real [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $write_to_bram_real eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_ports CLK] [get_bd_pins BIN_DETECTION/CLK] [get_bd_pins CORRELATION_HYD1/CLK] [get_bd_pins CORRELATION_SINE/CLK] [get_bd_pins HYD1_STORE_DATA/CLK] [get_bd_pins RISING_EDGE/CLK] [get_bd_pins RSING_EDGE_1/CLK] [get_bd_pins STORE_IMAG/clka] [get_bd_pins STORE_IMAG/clkb] [get_bd_pins STORE_REAL/clka] [get_bd_pins STORE_REAL/clkb] [get_bd_pins delay_by_1_0/CLK] [get_bd_pins delay_by_1_1/CLK] [get_bd_pins delay_by_1_2/CLK] [get_bd_pins delay_by_1_3/CLK] [get_bd_pins read_from_bram_real/CLK] [get_bd_pins write_to_bram_imag/CLK] [get_bd_pins write_to_bram_real/CLK]
  connect_bd_net -net CORRELATION_HYD1_CORR_REAL [get_bd_pins CORRELATION_HYD1/CORR_REAL] [get_bd_pins RSING_EDGE_1/INP_DATA]
  connect_bd_net -net CORRELATION_HYD1_VALID [get_bd_pins CORRELATION_HYD1/VALID] [get_bd_pins RSING_EDGE_1/INP_VALID]
  connect_bd_net -net CORRELATION_SINE_CORR_REAL [get_bd_pins CORRELATION_SINE/CORR_REAL] [get_bd_pins RISING_EDGE/INP_DATA]
  connect_bd_net -net CORRELATION_SINE_CORR_VALID [get_bd_pins CORRELATION_SINE/CORR_VALID] [get_bd_pins RISING_EDGE/INP_VALID]
  connect_bd_net -net IM_DATA_1 [get_bd_ports IM_DATA] [get_bd_pins BIN_DETECTION/IM_INPUT] [get_bd_pins HYD1_STORE_DATA/INP_IMAG] [get_bd_pins write_to_bram_imag/INP_DATA]
  connect_bd_net -net INP_DATA_1 [get_bd_ports RE_DATA] [get_bd_pins BIN_DETECTION/RE_INPUT] [get_bd_pins HYD1_STORE_DATA/INP_REAL] [get_bd_pins write_to_bram_real/INP_DATA]
  connect_bd_net -net INP_VALID_1 [get_bd_ports RE_VALID] [get_bd_pins BIN_DETECTION/IM_VALID] [get_bd_pins BIN_DETECTION/RE_VALID] [get_bd_pins HYD1_STORE_DATA/INP_VALID] [get_bd_pins write_to_bram_imag/INP_VALID] [get_bd_pins write_to_bram_real/INP_VALID]
  connect_bd_net -net RISING_EDGE_INDEX [get_bd_pins CORRELATION_HYD1/INDEX] [get_bd_pins RISING_EDGE/INDEX] [get_bd_pins read_from_bram_real/INDEX]
  connect_bd_net -net RISING_EDGE_INDEX_VALID [get_bd_pins CORRELATION_HYD1/INDEX_VALID] [get_bd_pins RISING_EDGE/INDEX_VALID] [get_bd_pins read_from_bram_real/INDEX_VALID]
  connect_bd_net -net STORE_IMAG_doutb [get_bd_pins STORE_IMAG/doutb] [get_bd_pins read_from_bram_real/DATA_FROM_BRAM_IMAG]
  connect_bd_net -net STORE_REAL_doutb [get_bd_pins STORE_REAL/doutb] [get_bd_pins read_from_bram_real/DATA_FROM_BRAM_REAL]
  connect_bd_net -net delay_by_1_0_OUT_DATA [get_bd_pins delay_by_1_0/OUT_DATA] [get_bd_pins delay_by_1_3/INP_DATA]
  connect_bd_net -net delay_by_1_1_OUT_DATA [get_bd_pins delay_by_1_1/OUT_DATA] [get_bd_pins delay_by_1_2/INP_DATA]
  connect_bd_net -net delay_by_1_2_OUT_DATA [get_bd_pins CORRELATION_HYD1/INP_VALID] [get_bd_pins delay_by_1_2/OUT_DATA]
  connect_bd_net -net delay_by_1_3_OUT_DATA [get_bd_pins CORRELATION_SINE/INP_VALID] [get_bd_pins delay_by_1_3/OUT_DATA]
  connect_bd_net -net design_2_0_BIN_DETECTED [get_bd_pins BIN_DETECTION/BIN_DETECTED] [get_bd_pins read_from_bram_real/BIN_DETECTED]
  connect_bd_net -net design_2_0_BIN_DETECTED_VALID [get_bd_pins BIN_DETECTION/BIN_DETECTED_VALID] [get_bd_pins read_from_bram_real/BIN_DETECTED_VALID]
  connect_bd_net -net design_4_0_INDEX [get_bd_ports INDEX] [get_bd_pins RSING_EDGE_1/INDEX]
  connect_bd_net -net design_4_0_INDEX_VALID [get_bd_ports INDEX_VALID] [get_bd_pins RSING_EDGE_1/INDEX_VALID]
  connect_bd_net -net design_5_0_HYD1_IMAG_OUT [get_bd_pins CORRELATION_HYD1/HYD1_DATA_IN_IMAG] [get_bd_pins HYD1_STORE_DATA/HYD1_IMAG_OUT]
  connect_bd_net -net design_5_0_HYD1_REAL_OUT [get_bd_pins CORRELATION_HYD1/HYD1_DATA_IN_REAL] [get_bd_pins HYD1_STORE_DATA/HYD1_REAL_OUT]
  connect_bd_net -net design_6_0_ADDR [get_bd_pins CORRELATION_HYD1/ADDR] [get_bd_pins HYD1_STORE_DATA/ADDR]
  connect_bd_net -net read_from_bram_0_ADDR [get_bd_pins STORE_IMAG/addrb] [get_bd_pins STORE_REAL/addrb] [get_bd_pins read_from_bram_real/ADDR]
  connect_bd_net -net read_from_bram_0_VALID [get_bd_pins delay_by_1_0/INP_DATA] [get_bd_pins read_from_bram_real/VALID_CORR_SINE]
  connect_bd_net -net read_from_bram_real_OUT_IMAG_CORR_HYD [get_bd_pins CORRELATION_HYD1/INP_IMAG] [get_bd_pins read_from_bram_real/OUT_IMAG_CORR_HYD]
  connect_bd_net -net read_from_bram_real_OUT_IMAG_CORR_SINE [get_bd_pins CORRELATION_SINE/INPUT_IMAG] [get_bd_pins read_from_bram_real/OUT_IMAG_CORR_SINE]
  connect_bd_net -net read_from_bram_real_OUT_REAL_CORR_HYD [get_bd_pins CORRELATION_HYD1/INP_REAL] [get_bd_pins read_from_bram_real/OUT_REAL_CORR_HYD]
  connect_bd_net -net read_from_bram_real_OUT_REAL_CORR_SINE [get_bd_pins CORRELATION_SINE/INPUT_REAL] [get_bd_pins read_from_bram_real/OUT_REAL_CORR_SINE]
  connect_bd_net -net read_from_bram_real_VALID_CORR_HYD [get_bd_pins delay_by_1_1/INP_DATA] [get_bd_pins read_from_bram_real/VALID_CORR_HYD]
  connect_bd_net -net write_to_bram_0_ADDR [get_bd_pins STORE_REAL/addra] [get_bd_pins write_to_bram_real/ADDR]
  connect_bd_net -net write_to_bram_0_OUT_DATA [get_bd_pins STORE_REAL/dina] [get_bd_pins write_to_bram_real/OUT_DATA]
  connect_bd_net -net write_to_bram_0_WEA [get_bd_pins STORE_REAL/wea] [get_bd_pins write_to_bram_real/WEA]
  connect_bd_net -net write_to_bram_imag_ADDR [get_bd_pins STORE_IMAG/addra] [get_bd_pins write_to_bram_imag/ADDR]
  connect_bd_net -net write_to_bram_imag_OUT_DATA [get_bd_pins STORE_IMAG/dina] [get_bd_pins write_to_bram_imag/OUT_DATA]
  connect_bd_net -net write_to_bram_imag_WEA [get_bd_pins STORE_IMAG/wea] [get_bd_pins write_to_bram_imag/WEA]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins BIN_DETECTION/RESET] [get_bd_pins xlconstant_0/dout]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   "ActiveEmotionalView":"Default View",
   "Default View_ScaleFactor":"0.316305",
   "Default View_TopLeft":"-142,-645",
   "ExpandedHierarchyInLayout":"",
   "guistr":"# # String gsaved with Nlview 7.0r6  2020-01-29 bk=1.5227 VDI=41 GEI=36 GUI=JA:10.0 non-TLS
#  -string -flagsOSRD
preplace port port-id_CLK -pg 1 -lvl 0 -x 0 -y 430 -defaultsOSRD
preplace port port-id_RE_VALID -pg 1 -lvl 0 -x 0 -y 830 -defaultsOSRD
preplace port port-id_INDEX_VALID -pg 1 -lvl 10 -x 3090 -y 680 -defaultsOSRD
preplace portBus RE_DATA -pg 1 -lvl 0 -x 0 -y 800 -defaultsOSRD
preplace portBus IM_DATA -pg 1 -lvl 0 -x 0 -y 860 -defaultsOSRD
preplace portBus INDEX -pg 1 -lvl 10 -x 3090 -y 650 -defaultsOSRD
preplace inst write_to_bram_real -pg 1 -lvl 4 -x 1050 -y 120 -defaultsOSRD
preplace inst STORE_REAL -pg 1 -lvl 6 -x 1910 -y 140 -defaultsOSRD
preplace inst delay_by_1_0 -pg 1 -lvl 1 -x 140 -y 500 -defaultsOSRD
preplace inst BIN_DETECTION -pg 1 -lvl 4 -x 1050 -y 930 -defaultsOSRD
preplace inst STORE_IMAG -pg 1 -lvl 6 -x 1910 -y 400 -defaultsOSRD
preplace inst write_to_bram_imag -pg 1 -lvl 4 -x 1050 -y 380 -defaultsOSRD
preplace inst CORRELATION_SINE -pg 1 -lvl 3 -x 670 -y 510 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 3 -x 670 -y 980 -defaultsOSRD
preplace inst RISING_EDGE -pg 1 -lvl 4 -x 1050 -y 520 -defaultsOSRD
preplace inst delay_by_1_1 -pg 1 -lvl 6 -x 1910 -y 620 -defaultsOSRD
preplace inst delay_by_1_2 -pg 1 -lvl 7 -x 2210 -y 630 -defaultsOSRD
preplace inst read_from_bram_real -pg 1 -lvl 5 -x 1520 -y 650 -defaultsOSRD
preplace inst delay_by_1_3 -pg 1 -lvl 2 -x 380 -y 490 -defaultsOSRD
preplace inst HYD1_STORE_DATA -pg 1 -lvl 7 -x 2210 -y 810 -defaultsOSRD
preplace inst CORRELATION_HYD1 -pg 1 -lvl 8 -x 2590 -y 680 -defaultsOSRD
preplace inst RSING_EDGE_1 -pg 1 -lvl 9 -x 2930 -y 670 -defaultsOSRD
preplace netloc CLK_1 1 0 9 20 430 260 420 500 420 850 610 1250 770 1770 740 2040 560 2400 550 2790
preplace netloc CORRELATION_SINE_CORR_REAL 1 3 1 840 490n
preplace netloc CORRELATION_SINE_CORR_VALID 1 3 1 870 520n
preplace netloc IM_DATA_1 1 0 7 NJ 860 NJ 860 NJ 860 880 810 NJ 810 NJ 810 NJ
preplace netloc INP_DATA_1 1 0 7 NJ 800 NJ 800 NJ 800 860 800 NJ 800 NJ 800 2040J
preplace netloc INP_VALID_1 1 0 7 NJ 830 NJ 830 NJ 830 830 820 NJ 820 NJ 820 2030J
preplace netloc RISING_EDGE_INDEX 1 4 4 1240 510 1790J 540 NJ 540 2390
preplace netloc RISING_EDGE_INDEX_VALID 1 4 4 1220 520 1760J 550 NJ 550 2380
preplace netloc STORE_IMAG_doutb 1 4 2 1290 480 NJ
preplace netloc STORE_REAL_doutb 1 4 2 1280 220 NJ
preplace netloc delay_by_1_0_OUT_DATA 1 1 1 N 500
preplace netloc delay_by_1_1_OUT_DATA 1 6 1 2030 620n
preplace netloc delay_by_1_3_OUT_DATA 1 2 1 510 480n
preplace netloc design_2_0_BIN_DETECTED 1 4 1 1260 610n
preplace netloc design_2_0_BIN_DETECTED_VALID 1 4 1 1270 630n
preplace netloc read_from_bram_0_ADDR 1 5 1 1780 180n
preplace netloc read_from_bram_0_VALID 1 0 6 20 600 NJ 600 NJ 600 NJ 600 1230J 530 1750
preplace netloc read_from_bram_real_OUT_IMAG_CORR_SINE 1 2 4 510 790 NJ 790 NJ 790 1750
preplace netloc read_from_bram_real_OUT_REAL_CORR_SINE 1 2 4 500 780 NJ 780 NJ 780 1760
preplace netloc read_from_bram_real_VALID_CORR_HYD 1 5 1 N 630
preplace netloc write_to_bram_0_ADDR 1 4 2 1280 80 NJ
preplace netloc write_to_bram_0_OUT_DATA 1 4 2 N 120 NJ
preplace netloc write_to_bram_0_WEA 1 4 2 N 140 NJ
preplace netloc write_to_bram_imag_ADDR 1 4 2 1220 340 NJ
preplace netloc write_to_bram_imag_OUT_DATA 1 4 2 N 380 NJ
preplace netloc write_to_bram_imag_WEA 1 4 2 N 400 NJ
preplace netloc xlconstant_0_dout 1 3 1 NJ 980
preplace netloc design_6_0_ADDR 1 6 3 2040 910 NJ 910 2780
preplace netloc read_from_bram_real_OUT_REAL_CORR_HYD 1 5 3 NJ 690 2030J 700 2390
preplace netloc read_from_bram_real_OUT_IMAG_CORR_HYD 1 5 3 NJ 710 NJ 710 N
preplace netloc design_5_0_HYD1_REAL_OUT 1 7 1 2380 730n
preplace netloc design_5_0_HYD1_IMAG_OUT 1 7 1 2400 750n
preplace netloc delay_by_1_2_OUT_DATA 1 7 1 N 630
preplace netloc CORRELATION_HYD1_CORR_REAL 1 8 1 N 650
preplace netloc CORRELATION_HYD1_VALID 1 8 1 2780 670n
preplace netloc design_4_0_INDEX 1 9 1 3070J 650n
preplace netloc design_4_0_INDEX_VALID 1 9 1 NJ 680
levelinfo -pg 1 0 140 380 670 1050 1520 1910 2210 2590 2930 3090
pagesize -pg 1 -db -bbox -sgen -150 0 3230 1040
"
}

  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_design_1()
cr_bd_design_1 ""
set_property REGISTERED_WITH_MANAGER "1" [get_files design_1.bd ] 
set_property SYNTH_CHECKPOINT_MODE "Hierarchical" [get_files design_1.bd ] 

generate_target all [get_files design_1.bd]

# Set 'design_2_inst_0' fileset object
set obj [get_filesets design_2_inst_0]
# Set 'design_2_inst_0' fileset file properties for remote files
# None

# Set 'design_2_inst_0' fileset file properties for local files
# None

# Set 'design_2_inst_0' fileset properties
set obj [get_filesets design_2_inst_0]
set_property -name "top" -value "design_2_inst_0" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Set 'design_3_inst_0' fileset object
set obj [get_filesets design_3_inst_0]
# Set 'design_3_inst_0' fileset file properties for remote files
# None

# Set 'design_3_inst_0' fileset file properties for local files
# None

# Set 'design_3_inst_0' fileset properties
set obj [get_filesets design_3_inst_0]
set_property -name "top" -value "design_3_inst_0" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Set 'design_4_inst_0' fileset object
set obj [get_filesets design_4_inst_0]
# Set 'design_4_inst_0' fileset file properties for remote files
# None

# Set 'design_4_inst_0' fileset file properties for local files
# None

# Set 'design_4_inst_0' fileset properties
set obj [get_filesets design_4_inst_0]
set_property -name "top" -value "design_4_inst_0" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Set 'design_5_inst_1' fileset object
set obj [get_filesets design_5_inst_1]
# Set 'design_5_inst_1' fileset file properties for remote files
# None

# Set 'design_5_inst_1' fileset file properties for local files
# None

# Set 'design_5_inst_1' fileset properties
set obj [get_filesets design_5_inst_1]
set_property -name "top" -value "design_5_inst_1" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Set 'design_6_inst_0' fileset object
set obj [get_filesets design_6_inst_0]
# Set 'design_6_inst_0' fileset file properties for remote files
# None

# Set 'design_6_inst_0' fileset file properties for local files
# None

# Set 'design_6_inst_0' fileset properties
set obj [get_filesets design_6_inst_0]
set_property -name "top" -value "design_6_inst_0" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Set 'design_4_inst_1' fileset object
set obj [get_filesets design_4_inst_1]
# Set 'design_4_inst_1' fileset file properties for remote files
# None

# Set 'design_4_inst_1' fileset file properties for local files
# None

# Set 'design_4_inst_1' fileset properties
set obj [get_filesets design_4_inst_1]
set_property -name "top" -value "design_4_inst_1" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

set idrFlowPropertiesConstraints ""
catch {
 set idrFlowPropertiesConstraints [get_param runs.disableIDRFlowPropertyConstraints]
 set_param runs.disableIDRFlowPropertyConstraints 1
}

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part xc7a35ticsg324-1L -flow {Vivado Synthesis 2021} -strategy "Vivado Synthesis Defaults" -report_strategy {No Reports} -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2021" [get_runs synth_1]
}
set obj [get_runs synth_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Synthesis Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'synth_1_synth_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0] "" ] } {
  create_report_config -report_name synth_1_synth_report_utilization_0 -report_type report_utilization:1.0 -steps synth_design -runs synth_1
}
set obj [get_report_configs -of_objects [get_runs synth_1] synth_1_synth_report_utilization_0]
if { $obj != "" } {

}
set obj [get_runs synth_1]
set_property -name "auto_incremental_checkpoint.directory" -value "D:/AUV_Elec/Pinger_task_using_FPGA/test_2021_version/project_1/project_1.srcs/utils_1/imports/synth_1" -objects $obj
set_property -name "strategy" -value "Vivado Synthesis Defaults" -objects $obj

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part xc7a35ticsg324-1L -flow {Vivado Implementation 2021} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2021" [get_runs impl_1]
}
set obj [get_runs impl_1]
set_property set_report_strategy_name 1 $obj
set_property report_strategy {Vivado Implementation Default Reports} $obj
set_property set_report_strategy_name 0 $obj
# Create 'impl_1_init_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_init_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps init_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_init_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_opt_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_drc_0 -report_type report_drc:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_place_report_io_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0] "" ] } {
  create_report_config -report_name impl_1_place_report_io_0 -report_type report_io:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_io_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0] "" ] } {
  create_report_config -report_name impl_1_place_report_utilization_0 -report_type report_utilization:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_place_report_control_sets_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0] "" ] } {
  create_report_config -report_name impl_1_place_report_control_sets_0 -report_type report_control_sets:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_control_sets_0]
if { $obj != "" } {
set_property -name "options.verbose" -value "1" -objects $obj

}
# Create 'impl_1_place_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_incremental_reuse_1' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1] "" ] } {
  create_report_config -report_name impl_1_place_report_incremental_reuse_1 -report_type report_incremental_reuse:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_incremental_reuse_1]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj

}
# Create 'impl_1_place_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_place_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps place_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_place_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_post_place_power_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_place_power_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_place_power_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_place_power_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "is_enabled" -value "0" -objects $obj
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_route_report_drc_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0] "" ] } {
  create_report_config -report_name impl_1_route_report_drc_0 -report_type report_drc:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_drc_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_methodology_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0] "" ] } {
  create_report_config -report_name impl_1_route_report_methodology_0 -report_type report_methodology:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_methodology_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_power_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0] "" ] } {
  create_report_config -report_name impl_1_route_report_power_0 -report_type report_power:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_power_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_route_status_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0] "" ] } {
  create_report_config -report_name impl_1_route_report_route_status_0 -report_type report_route_status:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_route_status_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_route_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_timing_summary_0]
if { $obj != "" } {
set_property -name "options.max_paths" -value "10" -objects $obj

}
# Create 'impl_1_route_report_incremental_reuse_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0] "" ] } {
  create_report_config -report_name impl_1_route_report_incremental_reuse_0 -report_type report_incremental_reuse:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_incremental_reuse_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_clock_utilization_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0] "" ] } {
  create_report_config -report_name impl_1_route_report_clock_utilization_0 -report_type report_clock_utilization:1.0 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_clock_utilization_0]
if { $obj != "" } {

}
# Create 'impl_1_route_report_bus_skew_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0] "" ] } {
  create_report_config -report_name impl_1_route_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps route_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_route_report_bus_skew_0]
if { $obj != "" } {
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
# Create 'impl_1_post_route_phys_opt_report_timing_summary_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_timing_summary_0 -report_type report_timing_summary:1.0 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_timing_summary_0]
if { $obj != "" } {
set_property -name "options.max_paths" -value "10" -objects $obj
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
# Create 'impl_1_post_route_phys_opt_report_bus_skew_0' report (if not found)
if { [ string equal [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0] "" ] } {
  create_report_config -report_name impl_1_post_route_phys_opt_report_bus_skew_0 -report_type report_bus_skew:1.1 -steps post_route_phys_opt_design -runs impl_1
}
set obj [get_report_configs -of_objects [get_runs impl_1] impl_1_post_route_phys_opt_report_bus_skew_0]
if { $obj != "" } {
set_property -name "options.warn_on_violation" -value "1" -objects $obj

}
set obj [get_runs impl_1]
set_property -name "auto_incremental_checkpoint.directory" -value "D:/AUV_Elec/Pinger_task_using_FPGA/test_2021_version/project_1/project_1.srcs/utils_1/imports/impl_1" -objects $obj
set_property -name "strategy" -value "Vivado Implementation Defaults" -objects $obj
set_property -name "steps.write_bitstream.args.readback_file" -value "0" -objects $obj
set_property -name "steps.write_bitstream.args.verbose" -value "0" -objects $obj

# set the current impl run
current_run -implementation [get_runs impl_1]
catch {
 if { $idrFlowPropertiesConstraints != {} } {
   set_param runs.disableIDRFlowPropertyConstraints $idrFlowPropertiesConstraints
 }
}

puts "INFO: Project created:${_xil_proj_name_}"
# Create 'drc_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "drc_1" ] ] ""]} {
create_dashboard_gadget -name {drc_1} -type drc
}
set obj [get_dashboard_gadgets [ list "drc_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_drc_0" -objects $obj

# Create 'methodology_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "methodology_1" ] ] ""]} {
create_dashboard_gadget -name {methodology_1} -type methodology
}
set obj [get_dashboard_gadgets [ list "methodology_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_methodology_0" -objects $obj

# Create 'power_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "power_1" ] ] ""]} {
create_dashboard_gadget -name {power_1} -type power
}
set obj [get_dashboard_gadgets [ list "power_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_power_0" -objects $obj

# Create 'timing_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "timing_1" ] ] ""]} {
create_dashboard_gadget -name {timing_1} -type timing
}
set obj [get_dashboard_gadgets [ list "timing_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_timing_summary_0" -objects $obj

# Create 'utilization_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "utilization_1" ] ] ""]} {
create_dashboard_gadget -name {utilization_1} -type utilization
}
set obj [get_dashboard_gadgets [ list "utilization_1" ] ]
set_property -name "reports" -value "synth_1#synth_1_synth_report_utilization_0" -objects $obj
set_property -name "run.step" -value "synth_design" -objects $obj
set_property -name "run.type" -value "synthesis" -objects $obj

# Create 'utilization_2' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "utilization_2" ] ] ""]} {
create_dashboard_gadget -name {utilization_2} -type utilization
}
set obj [get_dashboard_gadgets [ list "utilization_2" ] ]
set_property -name "reports" -value "impl_1#impl_1_place_report_utilization_0" -objects $obj

move_dashboard_gadget -name {utilization_1} -row 0 -col 0
move_dashboard_gadget -name {power_1} -row 1 -col 0
move_dashboard_gadget -name {drc_1} -row 2 -col 0
move_dashboard_gadget -name {timing_1} -row 0 -col 1
move_dashboard_gadget -name {utilization_2} -row 1 -col 1
move_dashboard_gadget -name {methodology_1} -row 2 -col 1
