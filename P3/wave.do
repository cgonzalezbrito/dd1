onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /reg16b_ena_rst_tb/clk
add wave -noupdate /reg16b_ena_rst_tb/nRST
add wave -noupdate /reg16b_ena_rst_tb/sRST
add wave -noupdate /reg16b_ena_rst_tb/ena
add wave -noupdate /reg16b_ena_rst_tb/Din
add wave -noupdate /reg16b_ena_rst_tb/Dout
add wave -noupdate /reg16b_ena_rst_tb/T_CLK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {360695 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1993555 ps} {4093555 ps}
