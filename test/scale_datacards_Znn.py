import os,sys
from ROOT import *

oldLumi = 2.32
newLumi = 20.0

dirName = "20fb"

old_dir = "/afs/cern.ch/work/p/perrozzi/private/git/Hbb/vhbb_heppy/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/znn_4p3_basic/" 


oldFileNames = [
    old_dir+"vhbb_TH_Znn_13TeVTightLowPt_ZLight.root",
    old_dir+"vhbb_TH_Znn_13TeVTightLowPt_Zbb.root",
    old_dir+"vhbb_TH_Znn_13TeVTightLowPt_WLight.root",
    old_dir+"vhbb_TH_Znn_13TeVTightLowPt_Wbb.root",
    old_dir+"vhbb_TH_Znn_13TeVTightLowPt_TTbarTight.root",
    old_dir+"vhbb_TH_Znn_13TeVTightLowPt_Signal.root",
    old_dir+"vhbb_TH_Znn_13TeVTightLowPt_QCD.root",
    old_dir+"vhbb_TH_Znn_13TeVTightHighPt_ZLight.root",
    old_dir+"vhbb_TH_Znn_13TeVTightHighPt_Zbb.root",
    old_dir+"vhbb_TH_Znn_13TeVTightHighPt_WLight.root",
    old_dir+"vhbb_TH_Znn_13TeVTightHighPt_Wbb.root",
    old_dir+"vhbb_TH_Znn_13TeVTightHighPt_TTbarTight.root",
    old_dir+"vhbb_TH_Znn_13TeVTightHighPt_Signal.root",
    old_dir+"vhbb_TH_Znn_13TeVTightHighPt_QCD.root",
    ]

def scaleDC(oldFileName, newFileName, scale):
    print "DC - Opening: ",oldFileName+" . Writing:",newFileName
    fOld = open(oldFileName)
    fNew = open(newFileName, 'w')

    for line in fOld.readlines():
        if 'rate' == line[:4] or 'observation' == line[:11]:
            # print 'line',line
            newLine = ""
            for word in line.split(): #line.split("\t"):
                # print 'word',word
                try:
                    num = eval(word)
                except:
                    num = 0.0
                if num>0:
                    word = str(num*scale)
                newLine = newLine + word + "          "
            newLine = newLine + "\n"
            # print 'newLine',newLine
            # sys.exit()
            line = newLine
        fNew.write(line)

    fOld.close()
    fNew.close()

def scaleHistos(oldFileName, newFileName, scale):

    print "Opening: ",oldFileName+" . Writing:",newFileName

    fileOld = TFile(oldFileName)
    fileOld.ls()

    # if 'Zee_HighPt' in oldFileName:
    Dir = fileOld.Get("Znn_13TeV")

    # if 'Zuu_HighPt' in oldFileName:
        # Dir = fileOld.Get("ZuuHighPt_13TeV")

    print 'dir:',dir

    assert(type(Dir)==TDirectoryFile)
    fileNew = TFile(newFileName,"recreate")

    # if 'Zee_HighPt' in oldFileName:
    newDir = fileNew.mkdir("Znn_13TeV")
    
    # if 'Zuu_HighPt' in oldFileName:
        # newDir = fileNew.mkdir("ZuuHighPt_13TeV")

    newDir.cd()
    for i in Dir.GetListOfKeys():
        obj = i.ReadObj()
        obj = obj.Clone(obj.GetName())
        obj.Scale(scale)
        if obj.GetName()=="TTCMS_vhbb_bTagHFWeightHFStats1Up":
            print obj.GetName(), obj.GetMaximum() 
        obj.Write()
    fileNew.Close()
    return

scale = newLumi/oldLumi

oldFileName = oldFileNames[0]

new_directory = os.path.dirname(oldFileName)+'/'+dirName+'/'
# print 'oldFileName',oldFileName
# print new_directory

try:
    os.mkdir(new_directory)
except:
    pass

for oldFileName in oldFileNames:
    newFileName = new_directory+os.path.basename(oldFileName)
    oldFileNameDC = (oldFileName.replace("vhbb_TH","vhbb_DC_TH")).replace(".root",".txt")
    newFileNameDC = (newFileName.replace("vhbb_TH","vhbb_DC_TH")).replace(".root",".txt")
    
    scaleHistos(oldFileName, newFileName, scale)
    scaleDC(oldFileNameDC, newFileNameDC, scale)
