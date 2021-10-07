onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /_aocII_Pratica2/clk
add wave -noupdate /_aocII_Pratica2/cc
add wave -noupdate /_aocII_Pratica2/ic
add wave -noupdate /_aocII_Pratica2/TESTING_direct_input
add wave -noupdate /_aocII_Pratica2/alu_data_in_a
add wave -noupdate /_aocII_Pratica2/alu_data_in_b
add wave -noupdate /_aocII_Pratica2/alu_data_out
add wave -noupdate /_aocII_Pratica2/alu_wrap_around
add wave -noupdate /_aocII_Pratica2/bus
add wave -noupdate /_aocII_Pratica2/ctrlu_a_reg_write
add wave -noupdate /_aocII_Pratica2/ctrlu_alu_opcode
add wave -noupdate /_aocII_Pratica2/ctrlu_bus_sel
add wave -noupdate /_aocII_Pratica2/ctrlu_g_reg_write
add wave -noupdate /_aocII_Pratica2/ctrlu_inst
add wave -noupdate /_aocII_Pratica2/step
add wave -noupdate /_aocII_Pratica2/ctrlu_instDone
add wave -noupdate /_aocII_Pratica2/ctrlu_rb_read_in_sel
add wave -noupdate /_aocII_Pratica2/ctrlu_rb_write
add wave -noupdate /_aocII_Pratica2/ctrlu_regx
add wave -noupdate /_aocII_Pratica2/ctrlu_regy
add wave -noupdate /_aocII_Pratica2/ctrlu_step
add wave -noupdate /_aocII_Pratica2/pc_out
add wave -noupdate /_aocII_Pratica2/pm_address
add wave -noupdate /_aocII_Pratica2/pm_data_out
add wave -noupdate /_aocII_Pratica2/rb_data_in
add wave -noupdate /_aocII_Pratica2/rb_data_out
add wave -noupdate /_aocII_Pratica2/rb_read_sel
add wave -noupdate /_aocII_Pratica2/rb_write
add wave -noupdate /_aocII_Pratica2/reg_a_data_in
add wave -noupdate /_aocII_Pratica2/reg_a_data_out
add wave -noupdate /_aocII_Pratica2/reg_a_write
add wave -noupdate /_aocII_Pratica2/reg_g_data_in
add wave -noupdate /_aocII_Pratica2/reg_g_data_out
add wave -noupdate /_aocII_Pratica2/reg_g_write
add wave -noupdate /_aocII_Pratica2/rst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {419 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {477 ps}
