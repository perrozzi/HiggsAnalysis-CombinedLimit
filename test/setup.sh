# # # # # # # # # # # # # # # # #
# # Install combine (ALWAYS refer to the twiki)
# # https://twiki.cern.ch/twiki/bin/viewauth/CMS/SWGuideHiggsAnalysisCombinedLimit#ROOT6_SLC6_release_CMSSW_7_4_X
# # # # # # # # # # # # # # # # #
# export SCRAM_ARCH=slc6_amd64_gcc491
# cmsrel CMSSW_7_4_7
# cd CMSSW_7_4_7/src 
# cmsenv
# git clone https://github.com/cms-analysis/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit
# cd HiggsAnalysis/CombinedLimit
# cd $CMSSW_BASE/src/HiggsAnalysis/CombinedLimit
# git fetch origin
# git checkout v6.2.1
# scramv1 b clean; scramv1 b -j 6 # always make a clean build, as scram doesn't always see updates to src/LinkDef.h


# # # # # # # # # # # # # # # # #
# # Get CombineHarvester
# # # # # # # # # # # # # # # # #
# cd $CMSSW_BASE/src
# git clone https://github.com/cms-analysis/CombineHarvester.git CombineHarvester
# cd CombineHarvester
# scram b -j 6


outputfolder="vhbb_2016_05_Aug_pujetid"
# # # # # # # # # # # # # # # #
# create working directory (launch everything from here)
# # # # # # # # # # # # # # # #
mkdir $CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
cp setup.sh $CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
cp submit.py $CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
cp fetch_results.py $CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
cd $CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
eval `scramv1 runtime -sh`
dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder

# # # # # # # # # # # # # # # #
# create file used to blind impacts and pulls
# # # # # # # # # # # # # # # #
cat <<EOT > zeroR.txt
{
  "POIs": [
    {
     "fit": [
         -1.0,
          0.0,
          1.0
      ],
      "name": "r"
    }
  ],
EOT



# # # # # # # # # # # # # # # #
# # # copy the datacards into working dir
# # # # # # # # # # # # # # # #

mkdir WlnuH
# cp -r /afs/cern.ch/user/s/scoopers/public/July1_datacards/* WlnuH/ # 2015
cp -r /afs/cern.ch/user/s/scoopers/public/July27_datacards_v2/* WlnuH/ # 2016
mkdir ZnnH 
cp -r /afs/cern.ch/user/s/sdonato/website/VHbb/ZvvHbb/V21_tesi/FitTwoBinsTight/* ZnnH/ # 2015
mkdir ZllH
# cp -r /afs/cern.ch/work/d/dcurry/public/shared/datacards/6_28_final2015_DC_v5/2015_finalDC_v5/* ZllH/ # 2015
# cp -r /afs/cern.ch/user/d/dcurry/public/shared/datacards/v23_4fb_v1/* ZllH/ # 2016
# cp -r /afs/cern.ch/user/d/dcurry/public/shared/datacards/v21_2015_DC_8_3/* ZllH/ # 2015 pileup jet id
cp -r /afs/cern.ch/user/d/dcurry/public/shared/datacards/v23_2016_4fb_DC_8_3/* ZllH/ # 2016 pileup jet id


# # # # # # # # # # # # # # # #
# # # combine datacards
# # # # # # # # # # # # # # # #

# # # combine ZnnH CR datacards
combineCards.py $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_ZLight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_Zbb.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_WLight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_Wbb.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_TTbarTight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_Signal.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_QCD.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_ZLight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_Zbb.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_WLight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_Wbb.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_TTbarTight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_QCD.txt > vhbb_DC_TH_M125_ZnnHbb_CR_13TeV.txt

# # # combine ZnnH CR+SR datacards
combineCards.py $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_ZLight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_Zbb.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_WLight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_Wbb.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_TTbarTight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_Signal.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightLowPt_QCD.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_ZLight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_Zbb.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_WLight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_Wbb.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_TTbarTight.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_QCD.txt $dc_path/ZnnH/vhbb_DC_TH_Znn_13TeVTightHighPt_Signal.txt > vhbb_DC_TH_M125_ZnnHbb_CR_plus_SR_13TeV.txt

# # # combine ZllH CR datacards
combineCards.py $dc_path/ZllH/vhbb_DC_TH_Zlf_Zuu.txt $dc_path/ZllH/vhbb_DC_TH_Zlf_Zee.txt $dc_path/ZllH/vhbb_DC_TH_Zhf_Zuu.txt $dc_path/ZllH/vhbb_DC_TH_Zhf_Zee.txt $dc_path/ZllH/vhbb_DC_TH_ttbar_Zuu.txt $dc_path/ZllH/vhbb_DC_TH_ttbar_Zee.txt > vhbb_DC_TH_M125_ZllHbb_CR_13TeV.txt

# # # combine ZllH CR+SR datacards
combineCards.py $dc_path/ZllH/vhbb_DC_TH_Zlf_Zuu.txt $dc_path/ZllH/vhbb_DC_TH_Zlf_Zee.txt $dc_path/ZllH/vhbb_DC_TH_Zhf_Zuu.txt $dc_path/ZllH/vhbb_DC_TH_Zhf_Zee.txt $dc_path/ZllH/vhbb_DC_TH_ttbar_Zuu.txt $dc_path/ZllH/vhbb_DC_TH_ttbar_Zee.txt $dc_path/ZllH/vhbb_DC_TH_BDT_M125_Zuu_HighPt.txt $dc_path/ZllH/vhbb_DC_TH_BDT_M125_Zee_HighPt.txt > vhbb_DC_TH_M125_ZllHbb_CR_plus_SR_13TeV.txt

# # # combine WlnuH CR datacards
combineCards.py $dc_path/WlnuH/vhbb_wlfWmn_13TeV.txt $dc_path/WlnuH/vhbb_wlfWen_13TeV.txt $dc_path/WlnuH/vhbb_whfWmn_13TeV.txt $dc_path/WlnuH/vhbb_whfWen_13TeV.txt $dc_path/WlnuH/vhbb_ttWmn_13TeV.txt $dc_path/WlnuH/vhbb_ttWen_13TeV.txt > vhbb_DC_TH_M125_WlnuHbb_CR_13TeV.txt

# # # combine WlnuH CR+SR datacards
combineCards.py $dc_path/WlnuH/vhbb_wlfWmn_13TeV.txt $dc_path/WlnuH/vhbb_wlfWen_13TeV.txt $dc_path/WlnuH/vhbb_whfWmn_13TeV.txt $dc_path/WlnuH/vhbb_whfWen_13TeV.txt $dc_path/WlnuH/vhbb_ttWmn_13TeV.txt $dc_path/WlnuH/vhbb_ttWen_13TeV.txt $dc_path/WlnuH/vhbb_WmnHighPt_13TeV.txt $dc_path/WlnuH/vhbb_WenHighPt_13TeV.txt > vhbb_DC_TH_M125_WlnuHbb_CR_plus_SR_13TeV.txt

# # # combine ALL CR+SR datacards
combineCards.py vhbb_DC_TH_M125_WlnuHbb_CR_plus_SR_13TeV.txt vhbb_DC_TH_M125_ZllHbb_CR_plus_SR_13TeV.txt vhbb_DC_TH_M125_ZnnHbb_CR_plus_SR_13TeV.txt  > vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV.txt

# to speed up things, clone the combined datacard and remove all the lines containing bin-by-bin statistical uncertainty, 
# for instance CMS_vhbb_statVVHF_WmnHighPt_bin7_13TeV
awk '!/CMS_vhbb_.*stat.*bin/' vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV.txt > vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.txt
# replace the number of nuisances with the new one
nuisances=$(grep -w "rate" vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.txt -A 1000000000 |grep -v "rate" | grep -v "rateParam" | grep -v "\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-" |wc -l)
sed -i "s/^kmax.*/kmax ${nuisances} number of nuisance parameters/" vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.txt

# correlate the W+jets SF for WlnuH and ZnnH replacing
# SF_Znn_.*Pt_Wjl ---> SF_Wj0b_Wln
sed -i 's/SF_Znn_.*Pt_Wjl/SF_Wj0b_Wln/g' vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.txt
# SF_Znn_.*Pt_Wjb ---> SF_Wj1b_Wln
sed -i 's/SF_Znn_.*Pt_Wjb/SF_Wj1b_Wln/g' vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.txt
# SF_Znn_.*Pt_Wjbb ---> SF_Wj2b_Wln
sed -i 's/SF_Znn_.*Pt_Wjbb/SF_Wj2b_Wln/g' vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.txt


# # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # #
# # #  STUFF FOR THE for the single channels
# # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # #

channels=( "Zll" "Wlnu" "Znn" )


for channel in "${channels[@]}"; do

# # # # # # # # # # # # # # # # #
# # # # crosscheck the SF (they are already applied in the datacards, should come out ~1)
# # # # # # # # # # # # # # # # #

dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
mkdir $dc_path/${channel}H_CR_SFcheck/
cat <<EOT > $dc_path/${channel}H_CR_SFcheck/SFcheck_vhbb_DC_TH_M125_${channel}Hbb_CR_13TeV.sh
mkdir $dc_path/${channel}H_CR_SFcheck/
cd $dc_path/${channel}H_CR_SFcheck/
eval `scramv1 runtime -sh`
combine -M MaxLikelihoodFit ../vhbb_DC_TH_M125_${channel}Hbb_CR_13TeV.txt --saveShapes --plots --saveWithUncertainties -v 3 --forceRecreateNLL --expectSignal=0 2>&1 | tee $dc_path/${channel}H_CR_SFcheck/SFcheck_vhbb_DC_TH_M125_${channel}Hbb_CR_13TeV.log
EOT
chmod +x $dc_path/${channel}H_CR_SFcheck/SFcheck_vhbb_DC_TH_M125_${channel}Hbb_CR_13TeV.sh


# # # # # # # # # # # # # # # # #
# # # # check the impacts and pulls on CR
# # # # # # # # # # # # # # # # #

dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
mkdir $dc_path/${channel}H_CR_pulls/
cat <<EOT > $dc_path/${channel}H_CR_pulls/nuisance_SF_pulls_vhbb_DC_TH_M125_${channel}Hbb_CR_13TeV.sh
cd $dc_path/${channel}H_CR_pulls/
eval `scramv1 runtime -sh`
combine -M MaxLikelihoodFit ../vhbb_DC_TH_M125_${channel}Hbb_CR_13TeV.txt -v 3 --plots --saveWithUncertainties --rMin -20 --rMax 20 --robustFit 1 2>&1 | tee $dc_path/${channel}H_CR_pulls/SF_pulls_vhbb_DC_TH_M125_${channel}Hbb_CR_13TeV.log
python $dc_path/../diffNuisances.py mlfit.root -f text 2>&1 | tee $dc_path/${channel}H_CR_pulls/nuisance_SF_pulls_vhbb_DC_TH_M125_${channel}Hbb_CR_13TeV.log
EOT
chmod +x $dc_path/${channel}H_CR_SFcheck/nuisance_SF_pulls_vhbb_DC_TH_M125_${channel}Hbb_CR_13TeV.sh


# # # # # # # # # # # # # # # # #
# # # expected 95% CL limit (CLs) and signal strenght
# # # # # # # # # # # # # # # # #
# (N.B there is also a postfit significance) which you get with the command
# combine -M ProfileLikelihood -m 125 --signif --pvalue -t -1 --toysFreq --expectSignal=1 vhbb_DC_TH_M125_ZllHbb_CR_plus_SR_13TeV.txt 2>&1 | tee postfit_significance_vhbb_DC_TH_M125_ZllHbb_CR_plus_SR_13TeV.log 

# # # compute the median expected confidence limit (CLs) for sigma/sigmaSM you would exclude at 95%
dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
mkdir $dc_path/${channel}H_CR_SR_limit/
cat <<EOT > $dc_path/${channel}H_CR_SR_limit/limit_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh
cd $dc_path/${channel}H_CR_SR_limit/
eval `scramv1 runtime -sh`
combine -M Asymptotic -t -1 ../vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.txt 2>&1 | tee $dc_path/${channel}H_CR_SR_limit/limit_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log
grep 'Expected 50.0%' $dc_path/${channel}H_CR_SR_limit/limit_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log | awk '{print $5 }'
EOT
chmod +x $dc_path/${channel}H_CR_SR_limit/limit_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh

# the significance (and correspondent pvalue) of the excess in the background only hypothesis 
# to justify a fluctuation to account for the expected signal (in the prefit fit, i.e. when the nuisances are not adjusted with the data observation)
dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
mkdir $dc_path/${channel}H_CR_SR_significance/
cat <<EOT > $dc_path/${channel}H_CR_SR_significance/significance_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh
cd $dc_path/${channel}H_CR_SR_significance/
eval `scramv1 runtime -sh`
combine -M ProfileLikelihood -m 125 --signif --pvalue -t -1 --expectSignal=1 ../vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.txt  2>&1 | tee $dc_path/${channel}H_CR_SR_significance/prefit_significance_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log 
grep Significance $dc_path/${channel}H_CR_SR_significance/prefit_significance_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log | awk '{print $3 } '
EOT
chmod +x $dc_path/${channel}H_CR_SR_significance/significance_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh

# the uncertainty of the best fitted signal strength in the signal + background fit
dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
mkdir $dc_path/${channel}H_CR_SR_mu_uncertainty/
cat <<EOT > $dc_path/${channel}H_CR_SR_mu_uncertainty/mu_uncertainty_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh
cd $dc_path/${channel}H_CR_SR_mu_uncertainty/
eval `scramv1 runtime -sh`
combine -M MaxLikelihoodFit -m 125 -t -1 --expectSignal=1 --robustFit=1 --stepSize=0.05 --rMin=-5 --rMax=5 --saveNorm --saveShapes --plots --saveWithUncertainties ../vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.txt  2>&1 | tee $dc_path/${channel}H_CR_SR_mu_uncertainty/mu_uncertainty_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log 
grep 'Best fit r' $dc_path/${channel}H_CR_SR_mu_uncertainty/mu_uncertainty_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log  | awk '{print $5}' 
EOT
chmod +x $dc_path/${channel}H_CR_SR_mu_uncertainty/mu_uncertainty_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh


# # # # # # # # # # # # # # # # #
# # # # check the impacts and pulls on SR+CR for single channels
# # # # # # # # # # # # # # # # #

dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
mkdir $dc_path/${channel}H_CR_SR_pulls/
cat <<EOT > $dc_path/${channel}H_CR_SR_pulls/pulls_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh
cd $dc_path/${channel}H_CR_SR_pulls/
eval `scramv1 runtime -sh`
text2workspace.py ../vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.txt -m 125
mv ../vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.root ./
combineTool.py -M Impacts -d vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.root -m 125 --doInitialFit --robustFit 1  --rMax 100 --rMin -100 2>&1 | tee $dc_path/${channel}H_CR_SR_pulls/vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV_1.log
combineTool.py -M Impacts -d vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.root -m 125 --robustFit 1 --doFits --allPars --rMax 100 --rMin -100  2>&1 | tee $dc_path/${channel}H_CR_SR_pulls/vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV_2.log
combineTool.py -M Impacts -d vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.root -m 125 --allPars -o impacts.json 2>&1 | tee $dc_path/${channel}H_CR_SR_pulls/vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV_3.log
# blind and extract the results
# rm impact_blind.json 
# more $dc_path/zeroR.txt >> impact_blind.json 
# tail -n+12 impacts.json >> impact_blind.json
# plotImpacts.py -i impact_blind.json -o impacts_blind_${channel}Hbb
EOT
chmod +x $dc_path/${channel}H_CR_SR_pulls/pulls_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh

done


# # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # #
# # #  STUFF FOR THE for the combined VH
# # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # #

channel="V"

# # # # # # # # # # # # # # # # #
# # # expected 95% CL limit (CLs) and signal strenght
# # # # # # # # # # # # # # # # #
# (N.B there is also a postfit significance) which you get with the command
# combine -M ProfileLikelihood -m 125 --signif --pvalue -t -1 --toysFreq --expectSignal=1 vhbb_DC_TH_M125_ZllHbb_CR_plus_SR_13TeV.txt 2>&1 | tee postfit_significance_vhbb_DC_TH_M125_ZllHbb_CR_plus_SR_13TeV.log 

# # # compute the median expected confidence limit (CLs) for sigma/sigmaSM you would exclude at 95%
dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
mkdir $dc_path/${channel}H_CR_SR_limit/
cat <<EOT > $dc_path/${channel}H_CR_SR_limit/limit_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh
cd $dc_path/${channel}H_CR_SR_limit/
eval `scramv1 runtime -sh`
combine -M Asymptotic -t -1 ../vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.txt 2>&1 | tee $dc_path/${channel}H_CR_SR_limit/limit_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log
grep 'Expected 50.0%' $dc_path/${channel}H_CR_SR_limit/limit_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log | awk '{print $5 }'
EOT
chmod +x $dc_path/${channel}H_CR_SR_limit/limit_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh

# the significance (and correspondent pvalue) of the excess in the background only hypothesis 
# to justify a fluctuation to account for the expected signal (in the prefit fit, i.e. when the nuisances are not adjusted with the data observation)
dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
mkdir $dc_path/${channel}H_CR_SR_significance/
cat <<EOT > $dc_path/${channel}H_CR_SR_significance/significance_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh
cd $dc_path/${channel}H_CR_SR_significance/
eval `scramv1 runtime -sh`
combine -M ProfileLikelihood -m 125 --signif --pvalue -t -1 --expectSignal=1 ../vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.txt  2>&1 | tee $dc_path/${channel}H_CR_SR_significance/prefit_significance_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log 
grep Significance $dc_path/${channel}H_CR_SR_significance/prefit_significance_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log | awk '{print $3 } '
EOT
chmod +x $dc_path/${channel}H_CR_SR_significance/significance_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh

# the uncertainty of the best fitted signal strength in the signal + background fit
dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
mkdir $dc_path/${channel}H_CR_SR_mu_uncertainty/
cat <<EOT > $dc_path/${channel}H_CR_SR_mu_uncertainty/mu_uncertainty_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh
cd $dc_path/${channel}H_CR_SR_mu_uncertainty/
eval `scramv1 runtime -sh`
combine -M MaxLikelihoodFit -m 125 -t -1 --expectSignal=1 --robustFit=1 --stepSize=0.05 --rMin=-5 --rMax=5 --saveNorm --saveShapes --plots ../vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.txt  2>&1 | tee $dc_path/${channel}H_CR_SR_mu_uncertainty/mu_uncertainty_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log 
grep 'Best fit r' $dc_path/${channel}H_CR_SR_mu_uncertainty/mu_uncertainty_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.log  | awk '{print $5}' 
EOT
chmod +x $dc_path/${channel}H_CR_SR_mu_uncertainty/mu_uncertainty_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh


# # # # # # # # # # # # # # # # #
# # # impacts and pulls for the combined VH
# # # # # # # # # # # # # # # # #

dc_path=$CMSSW_BASE/src/HiggsAnalysis/CombinedLimit/test/$outputfolder
mkdir $dc_path/${channel}H_CR_SR_pulls/
cat <<EOT > $dc_path/${channel}H_CR_SR_pulls/pulls_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh
cd $dc_path/${channel}H_CR_SR_pulls/
eval `scramv1 runtime -sh`
text2workspace.py ../vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.txt -m 125
mv ../vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.root ./
combineTool.py -M Impacts -d vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.root -m 125 --doInitialFit --robustFit 1  --rMax 100 --rMin -100 2>&1 | tee $dc_path/${channel}H_CR_SR_pulls/vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn_1.log
combineTool.py -M Impacts -d vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.root -m 125 --robustFit 1 --doFits --allPars --rMax 100 --rMin -100  2>&1 | tee $dc_path/${channel}H_CR_SR_pulls/vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn_2.log
combineTool.py -M Impacts -d vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn.root -m 125 --allPars -o impacts.json 2>&1 | tee $dc_path/${channel}H_CR_SR_pulls/vhbb_DC_TH_M125_VHbb_CR_plus_SR_13TeV_nostat_WjSFcommonWlnuZnn_3.log
# blind and extract the results
# rm impact_blind.json
# more $dc_path/zeroR.txt >> impact_blind.json 
# tail -n+12 impacts.json >> impact_blind.json
# plotImpacts.py -i impact_blind.json -o impacts_blind_VHbb_nostat_WjSFcommonWlnuZnn
EOT
chmod +x $dc_path/${channel}H_CR_SR_pulls/pulls_vhbb_DC_TH_M125_${channel}Hbb_CR_plus_SR_13TeV.sh




# #############################################################################
# # the significance (and correspondent pvalue) of the excess in the background only hypothesis 
# # to justify a fluctuation to account for the expected signal (in the prefit fit, i.e. when the nuisances are not adjusted with the data observation)
# combine -M ProfileLikelihood -m 125 --signif --pvalue -t -1 --expectSignal=1 datacard.txt ### | grep Significance | awk '{print $3 } '
# # (N.B there is also a postfit significance) which you get with the command
# combine -M ProfileLikelihood -m 125 --signif --pvalue -t -1 --toysFreq --expectSignal=1 
# # the uncertainty of the best fitted signal strength in the signal + background fit
# combine -M MaxLikelihoodFit -m 125 -t -1 --expectSignal=1 --robustFit=1 --stepSize=0.05 --rMin=-5 --rMax=5 --saveNorm --saveShapes --plots ### | grep 'Best fit r' | awk '{print $5}' 
# # the plot of nuisances pulls, to do now after the '-t -1' MaxLikelihoodFit and later on with removing this option after unblinding, assuming your Higgs combine branch stays in 7_1_5
 # python ~/CMSSW_7_1_15/src//HiggsAnalysis/CombinedLimit/test/diffNuisances.py mlfit.root -g outputfile.root
    # root -l outputfile.root
    # nuisancs->SaveAs("nuisances.pdf")

    