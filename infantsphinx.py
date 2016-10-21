import subprocess, os

class PhoneInfo:
    'Phones, true consonant count, and vowel count given by pocketsphinx'
    
    def __init__(self, sphinx_output, consonant_count, vowel_count):
        self.sphinx_output = sphinx_output
        self.consonant_count = consonant_count
        self.vowel_count = vowel_count
        

def get_phone_info(wavFile, pocketsphinx_path):
    phones = subprocess.check_output([
        'pocketsphinx_continuous',
        '-infile',wavFile,
        '-hmm',pocketsphinx_path + '/model/en-us/en-us',
        '-allphone',pocketsphinx_path + '/model/en-us/en-us-phone.lm.bin',
        '-backtrace','yes',
        '-beam','1e-20',
        '-pbeam','1e-20',
        '-lw','2.0'], stderr=open(os.devnull,'w'))
    sphinx_output = phones.replace('\n',' ')
    phone_list = sphinx_output.split(" ")
    consonant_count = sum(
        1 for p in phone_list if
        p=="B" or p=="CH" or p=="D" or p=="DH" or p=="F" or p=="G" or
        p=="JH" or p=="K" or p=="L" or p=="M" or p=="N" or p=="NG" or
        p=="P" or p=="R" or p=="S" or p=="SH" or p=="T" or p=="TH" or
        p=="V" or p=="W" or p=="Y" or p=="Z" or p=="ZH") # Exclude "HH"
    vowel_count = sum(
        1 for p in phone_list if
        p=="AA" or p=="AE" or p=="AH" or p=="AO" or p=="AW" or p=="AY"
        or p=="EH" or p=="ER" or p=="EY" or p=="IH" or p=="IY" or
        p=="OW" or p=="OY" or p=="UH" or p=="UW")
    phone_measures = PhoneInfo(sphinx_output, consonant_count, vowel_count)
    return phone_measures
