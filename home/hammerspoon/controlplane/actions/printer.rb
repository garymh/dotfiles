def home_printer
  system 'lpoptions -d b___Brother_HL_2170W_series___ProfX'
end

def rhlccc_printer
  system 'lpoptions -d _165_124_121_95'
end

def dvorak_printer
  system 'lpoptions -d Brother_HL_2270DW_series___The_Dvorak_Family_iMac'
end
