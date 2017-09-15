# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_0 {
  DIN_WIDTH 8 DIN_FROM 0 DIN_TO 0 DOUT_WIDTH 1
}

# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_1 {
  DIN_WIDTH 64 DIN_FROM 31 DIN_TO 0 DOUT_WIDTH 32
}

# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_2 {
  DIN_WIDTH 64 DIN_FROM 47 DIN_TO 32 DOUT_WIDTH 16
}

# Create axi_axis_writer
cell pavel-demin:user:axi_axis_writer:1.0 writer_0 {
  AXI_DATA_WIDTH 32
} {
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create fifo_generator
cell xilinx.com:ip:fifo_generator:13.1 fifo_generator_0 {
  PERFORMANCE_OPTIONS First_Word_Fall_Through
  INPUT_DATA_WIDTH 32
  INPUT_DEPTH 16384
  OUTPUT_DATA_WIDTH 64
  OUTPUT_DEPTH 8192
  WRITE_DATA_COUNT true
  WRITE_DATA_COUNT_WIDTH 15
} {
  clk /pll_0/clk_out1
  srst slice_0/Dout
}

# Create axis_fifo
cell pavel-demin:user:axis_fifo:1.0 fifo_0 {
  S_AXIS_TDATA_WIDTH 32
  M_AXIS_TDATA_WIDTH 64
} {
  S_AXIS writer_0/M_AXIS
  FIFO_READ fifo_generator_0/FIFO_READ
  FIFO_WRITE fifo_generator_0/FIFO_WRITE
  aclk /pll_0/clk_out1
}

# Create axis_dwidth_converter
cell xilinx.com:ip:axis_dwidth_converter:1.1 conv_0 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 8
  M_TDATA_NUM_BYTES 4
} {
  S_AXIS fifo_0/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create floating_point
cell xilinx.com:ip:floating_point:7.1 fp_0 {
  OPERATION_TYPE Float_to_fixed
  RESULT_PRECISION_TYPE Custom
  C_RESULT_EXPONENT_WIDTH 2
  C_RESULT_FRACTION_WIDTH 22
  HAS_ARESETN true
} {
  S_AXIS_A conv_0/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create fir_compiler
cell xilinx.com:ip:fir_compiler:7.2 fir_0 {
  DATA_WIDTH.VALUE_SRC USER
  DATA_WIDTH 24
  COEFFICIENTVECTOR {-1.64767793258513e-08, -4.73130401933802e-08, -7.89015020514924e-10, 3.0928184365585e-08, 1.86171437967678e-08, 3.27417490308436e-08, -6.28882305952853e-09, -1.52249021913047e-07, -8.30430341770078e-08, 3.14471544812983e-07, 3.05585913883361e-07, -4.74074722314402e-07, -7.1338208245138e-07, 5.47206423115321e-07, 1.3343968996369e-06, -4.14040144583054e-07, -2.15013647398608e-06, -6.77619137550772e-08, 3.07492149792295e-06, 1.03687542811551e-06, -3.94365999515519e-06, -2.5914915826665e-06, 4.51456433189903e-06, 4.74702085282004e-06, -4.49203269648069e-06, -7.39696882784057e-06, 3.57151821825862e-06, 1.02877406394336e-05, -1.50354924265334e-06, -1.30185958926664e-05, -1.83174482827086e-06, 1.50755354383702e-05, 6.3534983589819e-06, -1.59029513110266e-05, -1.1730365587969e-05, 1.50084756841038e-05, 1.73688625150811e-05, -1.20923926627015e-05, -2.24628775241618e-05, 7.16873343279609e-06, 2.60986655918355e-05, -6.63803310616104e-07, -2.74245274524168e-05, -6.54903880761834e-06, 2.58600110513329e-05, 1.32014955436698e-05, -2.13136755611044e-05, -1.77863688020237e-05, 1.43644844800593e-05, 1.88158679557272e-05, -6.35743236236129e-06, -1.51594598941384e-05, -6.33340264439249e-07, 6.41449969049065e-06, 4.00578688109124e-06, 6.75621989783952e-06, -1.00377756449914e-06, -2.2398505461023e-05, -1.07621836546251e-05, 3.72258385282273e-05, 3.26964029837136e-05, -4.68508688937697e-05, -6.46423820481749e-05, 4.62500983625866e-05, 0.000104384232343877, -3.05330381601634e-05, -0.000147431561987664, -4.12147390650285e-06, 0.000187152827292834, 5.94637903355769e-05, -0.000215336486101329, -0.000134280163072923, 0.000223184095508548, 0.000223797283005097, -0.000202664167392007, -0.000319568481767237, 0.00014806955570149, 0.000409978966685005, -5.75495256781405e-05, -0.000481431007338046, -6.56642501833879e-05, 0.000520160554778501, 0.000212625552393526, -0.000514530090745051, -0.000368939171329215, 0.000457390149683129, 0.000515880947691506, -0.000348421662177339, -0.000632768442617035, 0.000195622490446342, 0.000700065348190713, -1.58057317708103e-05, -0.000703083728664529, -0.000166336378785249, 0.000635737406265774, 0.000320763687201459, -0.000503732017561133, -0.000416170022012877, 0.000326526970141958, 0.000425306548879864, -0.000137462265764282, -0.000330979941859231, -1.84048176671591e-05, 0.000131927647365226, 8.89478838287332e-05, 0.000152374873227341, -2.19722858559691e-05, -0.000479012308015841, -0.00022614865530981, 0.000781437457190653, 0.000680243238924177, -0.000973641121797422, -0.00133721680288367, 0.000957301297342088, 0.00215787191514504, -0.000632907257915351, -0.003061861827782, -8.63031823998107e-05, 0.00392679721544048, 0.0012587181051531, -0.00459238166585313, -0.00289858802427871, 0.00486993618945311, 0.00496186969403106, -0.00455706432107208, -0.00733540086522566, 0.00345654716644672, 0.00983082178384368, -0.0013979524281709, -0.0121840389988802, -0.00174001298838836, 0.0140598439849354, 0.00600743409066738, -0.015062994324315, -0.0113680773474374, 0.0147458915607562, 0.0176840463041863, -0.0126165251402871, -0.0247087717848408, 0.00812982134278691, 0.0320808592160365, -0.000645559420412108, -0.0393103467958045, -0.0106897859087942, 0.045729185206815, 0.0272443866466503, -0.0503139645101435, -0.0517055596247492, 0.0510135842875111, 0.0905541017267955, -0.0416082674314903, -0.163722176130542, -0.0107786376098801, 0.356376541271961, 0.554784695532231, 0.356376541271961, -0.0107786376098801, -0.163722176130542, -0.0416082674314903, 0.0905541017267954, 0.051013584287511, -0.0517055596247491, -0.0503139645101435, 0.0272443866466503, 0.045729185206815, -0.0106897859087943, -0.0393103467958045, -0.000645559420412102, 0.0320808592160365, 0.00812982134278688, -0.0247087717848408, -0.012616525140287, 0.0176840463041863, 0.0147458915607562, -0.0113680773474374, -0.0150629943243149, 0.00600743409066738, 0.0140598439849354, -0.00174001298838836, -0.0121840389988802, -0.0013979524281709, 0.00983082178384367, 0.00345654716644673, -0.00733540086522566, -0.00455706432107209, 0.00496186969403104, 0.00486993618945311, -0.00289858802427871, -0.00459238166585313, 0.0012587181051531, 0.00392679721544048, -8.63031823998206e-05, -0.003061861827782, -0.00063290725791536, 0.00215787191514504, 0.000957301297342091, -0.00133721680288367, -0.000973641121797417, 0.000680243238924181, 0.000781437457190653, -0.000226148655309812, -0.000479012308015826, -2.19722858559681e-05, 0.000152374873227327, 8.8947883828729e-05, 0.000131927647365228, -1.84048176671555e-05, -0.000330979941859234, -0.000137462265764287, 0.000425306548879865, 0.000326526970141962, -0.000416170022012868, -0.000503732017561137, 0.000320763687201449, 0.000635737406265777, -0.000166336378785242, -0.000703083728664529, -1.58057317708433e-05, 0.000700065348190713, 0.000195622490446357, -0.000632768442617035, -0.00034842166217735, 0.000515880947691503, 0.000457390149683133, -0.000368939171329213, -0.000514530090745054, 0.000212625552393524, 0.000520160554778502, -6.56642501833866e-05, -0.000481431007338041, -5.75495256781407e-05, 0.000409978966685006, 0.00014806955570149, -0.000319568481767233, -0.000202664167392008, 0.000223797283005097, 0.000223184095508547, -0.000134280163072924, -0.000215336486101328, 5.94637903355747e-05, 0.000187152827292833, -4.12147390650418e-06, -0.000147431561987664, -3.05330381601629e-05, 0.000104384232343877, 4.62500983625856e-05, -6.46423820481746e-05, -4.685086889377e-05, 3.26964029837137e-05, 3.72258385282232e-05, -1.0762183654625e-05, -2.23985054610212e-05, -1.00377756449925e-06, 6.75621989784024e-06, 4.00578688109135e-06, 6.41449969048969e-06, -6.3334026443941e-07, -1.51594598941391e-05, -6.35743236236115e-06, 1.88158679557273e-05, 1.43644844800593e-05, -1.77863688020233e-05, -2.13136755611043e-05, 1.32014955436695e-05, 2.58600110513327e-05, -6.54903880761725e-06, -2.74245274524168e-05, -6.63803310616344e-07, 2.60986655918356e-05, 7.16873343279648e-06, -2.24628775241617e-05, -1.20923926627015e-05, 1.7368862515081e-05, 1.50084756841038e-05, -1.1730365587969e-05, -1.59029513110268e-05, 6.35349835898202e-06, 1.50755354383701e-05, -1.8317448282709e-06, -1.30185958926663e-05, -1.50354924265335e-06, 1.02877406394342e-05, 3.57151821825862e-06, -7.39696882784057e-06, -4.49203269648073e-06, 4.74702085281997e-06, 4.51456433189905e-06, -2.59149158266642e-06, -3.94365999515521e-06, 1.03687542811548e-06, 3.07492149792293e-06, -6.7761913755078e-08, -2.15013647398607e-06, -4.14040144583041e-07, 1.33439689963689e-06, 5.47206423115316e-07, -7.13382082451387e-07, -4.74074722314374e-07, 3.05585913883357e-07, 3.14471544812957e-07, -8.30430341770035e-08, -1.52249021913042e-07, -6.28882305952705e-09, 3.27417490308378e-08, 1.86171437967661e-08, 3.09281843655902e-08, -7.89015020514364e-10, -4.73130401933756e-08, -1.64767793258518e-08}
  COEFFICIENT_WIDTH 24
  QUANTIZATION Quantize_Only
  BESTPRECISION true
  FILTER_TYPE Interpolation
  INTERPOLATION_RATE 2
  NUMBER_CHANNELS 2
  NUMBER_PATHS 1
  SAMPLE_FREQUENCY 2.5
  CLOCK_FREQUENCY 125
  OUTPUT_ROUNDING_MODE Convergent_Rounding_to_Even
  OUTPUT_WIDTH 25
  HAS_ARESETN true
} {
  S_AXIS_DATA fp_0/M_AXIS_RESULT
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_dwidth_converter
cell xilinx.com:ip:axis_dwidth_converter:1.1 conv_1 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 8
} {
  S_AXIS fir_0/M_AXIS_DATA
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_broadcaster
cell xilinx.com:ip:axis_broadcaster:1.1 bcast_0 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  M_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 8
  M_TDATA_NUM_BYTES 3
  M00_TDATA_REMAP {tdata[55:32]}
  M01_TDATA_REMAP {tdata[23:0]}
} {
  S_AXIS conv_1/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_variable
cell pavel-demin:user:axis_variable:1.0 rate_0 {
  AXIS_TDATA_WIDTH 16
} {
  cfg_data slice_2/Dout
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_variable
cell pavel-demin:user:axis_variable:1.0 rate_1 {
  AXIS_TDATA_WIDTH 16
} {
  cfg_data slice_2/Dout
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create cic_compiler
cell xilinx.com:ip:cic_compiler:4.0 cic_0 {
  INPUT_DATA_WIDTH.VALUE_SRC USER
  FILTER_TYPE Interpolation
  NUMBER_OF_STAGES 6
  SAMPLE_RATE_CHANGES Programmable
  MINIMUM_RATE 25
  MAXIMUM_RATE 8192
  FIXED_OR_INITIAL_RATE 625
  INPUT_SAMPLE_FREQUENCY 5.0
  CLOCK_FREQUENCY 125
  INPUT_DATA_WIDTH 24
  QUANTIZATION Truncation
  OUTPUT_DATA_WIDTH 24
  USE_XTREME_DSP_SLICE false
  HAS_ARESETN true
} {
  S_AXIS_DATA bcast_0/M00_AXIS
  S_AXIS_CONFIG rate_0/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create cic_compiler
cell xilinx.com:ip:cic_compiler:4.0 cic_1 {
  INPUT_DATA_WIDTH.VALUE_SRC USER
  FILTER_TYPE Interpolation
  NUMBER_OF_STAGES 6
  SAMPLE_RATE_CHANGES Programmable
  MINIMUM_RATE 25
  MAXIMUM_RATE 8192
  FIXED_OR_INITIAL_RATE 625
  INPUT_SAMPLE_FREQUENCY 5.0
  CLOCK_FREQUENCY 125
  INPUT_DATA_WIDTH 24
  QUANTIZATION Truncation
  OUTPUT_DATA_WIDTH 24
  USE_XTREME_DSP_SLICE false
  HAS_ARESETN true
} {
  S_AXIS_DATA bcast_0/M01_AXIS
  S_AXIS_CONFIG rate_1/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_combiner
cell  xilinx.com:ip:axis_combiner:1.1 comb_0 {
  TDATA_NUM_BYTES.VALUE_SRC USER
  TDATA_NUM_BYTES 3
} {
  S00_AXIS cic_0/M_AXIS_DATA
  S01_AXIS cic_1/M_AXIS_DATA
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_constant
cell pavel-demin:user:axis_constant:1.0 phase_0 {
  AXIS_TDATA_WIDTH 32
} {
  cfg_data slice_1/Dout
  aclk /pll_0/clk_out1
}

# Create dds_compiler
cell xilinx.com:ip:dds_compiler:6.0 dds_0 {
  DDS_CLOCK_RATE 125
  SPURIOUS_FREE_DYNAMIC_RANGE 138
  FREQUENCY_RESOLUTION 0.2
  PHASE_INCREMENT Streaming
  HAS_PHASE_OUT false
  PHASE_WIDTH 30
  OUTPUT_WIDTH 24
  DSP48_USE Minimal
} {
  S_AXIS_PHASE phase_0/M_AXIS
  aclk /pll_0/clk_out1
}

# Create axis_lfsr
cell pavel-demin:user:axis_lfsr:1.0 lfsr_0 {} {
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create cmpy
cell xilinx.com:ip:cmpy:6.0 mult_0 {
  APORTWIDTH.VALUE_SRC USER
  BPORTWIDTH.VALUE_SRC USER
  APORTWIDTH 24
  BPORTWIDTH 24
  ROUNDMODE Random_Rounding
  OUTPUTWIDTH 17
} {
  S_AXIS_A comb_0/M_AXIS
  S_AXIS_B dds_0/M_AXIS_DATA
  S_AXIS_CTRL lfsr_0/M_AXIS
  aclk /pll_0/clk_out1
}
