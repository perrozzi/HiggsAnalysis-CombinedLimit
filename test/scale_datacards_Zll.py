import os,sys
from ROOT import *

oldLumi = 2.32
newLumi = 20.0

dirName = "20fb"

old_dir = "/afs/cern.ch/work/p/perrozzi/private/git/Hbb/vhbb_heppy/CMSSW_7_4_7/src/HiggsAnalysis/CombinedLimit/test/zll_4p3_basic/" 


oldFileNames = [
    old_dir+"vhbb_TH_BDT_M125_Zee_HighPt.root",
    old_dir+"vhbb_TH_BDT_M125_Zuu_HighPt.root",
    old_dir+"vhbb_TH_Zhf_Zuu.root",
    old_dir+"vhbb_TH_Zhf_Zee.root",
    old_dir+"vhbb_TH_Zlf_Zuu.root",
    old_dir+"vhbb_TH_Zlf_Zee.root",
    old_dir+"vhbb_TH_ttbar_Zuu.root",
    old_dir+"vhbb_TH_ttbar_Zee.root",
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

    if 'Zee_HighPt' in oldFileName:
        Dir = fileOld.Get("ZeeHighPt_13TeV")

    if 'Zuu_HighPt' in oldFileName:
        Dir = fileOld.Get("ZuuHighPt_13TeV")

    if 'LowPt'in oldFileName:
        Dir = fileOld.Get("ZeeLowPt_13TeV")    
        
    if 'Zhf_Zuu' in oldFileName:
         Dir = fileOld.Get("Zhf_Zuu")

    if 'Zlf_Zuu' in oldFileName:
        Dir = fileOld.Get("Zlf_Zuu")

    if 'ttbar_Zuu' in oldFileName:
        Dir = fileOld.Get("ttbar_Zuu")

    if 'Zhf_Zee' in oldFileName:
         Dir = fileOld.Get("Zhf_Zee")

    if 'Zlf_Zee' in oldFileName:
        Dir = fileOld.Get("Zlf_Zee")

    if 'ttbar_Zee' in oldFileName:
        Dir = fileOld.Get("ttbar_Zee")

    print 'dir:',dir

    assert(type(Dir)==TDirectoryFile)
    fileNew = TFile(newFileName,"recreate")

    if 'Zee_HighPt' in oldFileName:
        newDir = fileNew.mkdir("ZeeHighPt_13TeV")
    
    if 'Zuu_HighPt' in oldFileName:
        newDir = fileNew.mkdir("ZuuHighPt_13TeV")

    if 'LowPt' in oldFileName:
        newDir = fileNew.mkdir("ZeeLowPt_13TeV")

    if 'Zhf_Zuu' in oldFileName:
        newDir = fileNew.mkdir("Zhf_Zuu")

    if 'Zlf_Zuu' in oldFileName:
        newDir = fileNew.mkdir("Zlf_Zuu")

    if 'ttbar_Zuu' in oldFileName:
        newDir = fileNew.mkdir("ttbar_Zuu")

    if 'Zhf_Zee' in oldFileName:
        newDir = fileNew.mkdir("Zhf_Zee")

    if 'Zlf_Zee' in oldFileName:
        newDir = fileNew.mkdir("Zlf_Zee")

    if 'ttbar_Zee' in oldFileName:
        newDir = fileNew.mkdir("ttbar_Zee")

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
    
    # scaleHistos(oldFileName, newFileName, scale)
    scaleDC(oldFileNameDC, newFileNameDC, scale)
