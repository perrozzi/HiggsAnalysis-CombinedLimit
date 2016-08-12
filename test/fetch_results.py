import sys, os

# if not os.path.exists("results"):
    # os.makedirs("results")
# text_file = open("results/results.log", "w")

text_file = open("results.log", "w")
 
# channels = [ "Zll", "Wlnu", "Znn" ]
channels = [ "Zll", "Wlnu" ]

for channel in channels:
    
    text_file.write('Checking SF for channel '+channel+'H\n')
    command = "tac "+channel+"H_CR_SFcheck/SFcheck_vhbb_DC_TH_M125_"+channel+"Hbb_CR_13TeV.log | grep 'Floating Parameter' -m 1 -B 1000 | grep SF_"

    grep = os.popen(command).read()
    grep = grep.replace('1.0000e+00','').replace('<none>','').split('\n')
    sf_all = []
    for element in grep:
        element = filter(None,element.split(' '))
        sf_all.append(element)
    sf_all = [x for x in sf_all if x]
    
    for element in sf_all:
        outstring =  "%s    %.2f %s %.2f\n" % (element[0], float(element[1]), element[2], float(element[3]))
        text_file.write(outstring)
    text_file.write('\n')
    
# channels = [ "Zll", "Wlnu", "Znn", "V" ]
channels = [ "Zll", "Wlnu" ]

for channel in channels:

    text_file.write('Checking expected numbers for channel '+channel+"H\n")
    
    command = "grep Significance "+channel+"H_CR_SR_significance/prefit_significance_vhbb_DC_TH_M125_"+channel+"Hbb_CR_plus_SR_13TeV.log"
    grep = os.popen(command).read().replace('(','').replace(')','').split('=')
    if len(grep)>0 and grep[0] != "":
        text_file.write("Significance \t=   %.2f \n" % (float(grep[1])))
    
    command = "grep Best\ fit\ r "+channel+"H_CR_SR_mu_uncertainty/mu_uncertainty_vhbb_DC_TH_M125_"+channel+"Hbb_CR_plus_SR_13TeV.log"
    grep = os.popen(command).read().split(' ')[5].split('/')
    # .replace('Best fit r: 1','').replace('0.999999','').replace('(68% CL)','').replace(' ','').split('/')
    if len(grep)>0 and grep[0] != "":
        text_file.write("mu uncertainty =   %.2f / +%.2f \n" % (float(grep[0]),float(grep[1])))
    
    command = "grep Expected\ 50\.0\%\:\ r\ \< "+channel+"H_CR_SR_limit/limit_vhbb_DC_TH_M125_"+channel+"Hbb_CR_plus_SR_13TeV.log"
    grep = os.popen(command).read().replace('Expected 50.0%: r < ','')
    if len(grep)>0 and grep[0] != "":
        text_file.write("limit \t\t\t\t=   %.2f \n" % (float(grep)))

    text_file.write('\n')
    
    if os.path.isfile(channel+"H_CR_SR_pulls/impacts.json"):
        command = "cd "+channel+"H_CR_SR_pulls/;\
                  rm impact_blind.json; \
                  more ../zeroR.txt >> impact_blind.json; \
                  tail -n+12 impacts.json >> impact_blind.json; \
                  plotImpacts.py -i impact_blind.json -o impacts_blind_"+channel+"Hbb_nostat_WjSFcommonWlnuZnn; \
                  cp impacts_blind_"+channel+"Hbb_nostat_WjSFcommonWlnuZnn.pdf ../; \
                  convert -density 300 impacts_blind_"+channel+"Hbb_nostat_WjSFcommonWlnuZnn.pdf[0] impacts_blind_"+channel+"Hbb_nostat_WjSFcommonWlnuZnn.png; \
                  cp impacts_blind_"+channel+"Hbb_nostat_WjSFcommonWlnuZnn.png ../; "
        if channel != "V": command = command.replace("_nostat_WjSFcommonWlnuZnn","")
        os.system(command)

    # print command

text_file.close()