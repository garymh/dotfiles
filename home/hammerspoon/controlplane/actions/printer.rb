def home_printer
  system 'lpoptions -d b___Brother_HL_2170W_series___ProfX'
end

def rhlccc_printer
  system 'lpoptions -d _676_Copy_Room'
end

def dvorak_printer
  system 'lpoptions -d Brother_HL_2270DW_series___The_Dvorak_Family_iMac'
end
