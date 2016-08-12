import sys, os

# channels = [ "Zll", "Wlnu", "Znn" ]
channels = [ "Zll" ]

for channel in channels:
    
    command = "cd "+channel+"H_CR_SFcheck/;           bsub -q 8nh -C 0 -u pippo123 SFcheck_vhbb_DC_TH_M125_"+channel+"Hbb_CR_13TeV.sh; cd -"
    print command
    os.system(command)
    command = "cd "+channel+"H_CR_pulls/;             bsub -q 2nd -C 0 -u pippo123 nuisance_SF_pulls_vhbb_DC_TH_M125_"+channel+"Hbb_CR_13TeV.sh; cd -"
    print command
    os.system(command)
    
# channels = [ "Zll", "Wlnu", "Znn", "V" ]
channels = [ "Zll" ]

for channel in channels:

    command = "cd "+channel+"H_CR_SR_significance/;   bsub -q 8nh -C 0 -u pippo123 significance_vhbb_DC_TH_M125_"+channel+"Hbb_CR_plus_SR_13TeV.sh; cd -"
    print command
    os.system(command)
    command = "cd "+channel+"H_CR_SR_mu_uncertainty/; bsub -q 1nd -C 0 -u pippo123 mu_uncertainty_vhbb_DC_TH_M125_"+channel+"Hbb_CR_plus_SR_13TeV.sh; cd -"
    print command
    os.system(command)
    command = "cd "+channel+"H_CR_SR_limit/;          bsub -q 8nh -C 0 -u pippo123 limit_vhbb_DC_TH_M125_"+channel+"Hbb_CR_plus_SR_13TeV.sh; cd -"
    print command
    os.system(command)
    command = "cd "+channel+"H_CR_SR_pulls/;          bsub -q 2nd -C 0 -u pippo123 pulls_vhbb_DC_TH_M125_"+channel+"Hbb_CR_plus_SR_13TeV.sh; cd -"
    print command
    os.system(command)

os.system("bjobs -w")